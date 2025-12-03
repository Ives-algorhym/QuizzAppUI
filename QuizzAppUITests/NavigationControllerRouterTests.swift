//
//  NavigationControllerRouterTests.swift
//  QuizzAppUITests
//
//  Created by Ives Murillo on 11/22/25.
//

import Foundation
import XCTest
@testable import QuizzAppUI
@testable import QuizApp_iOS

class NavigationControllerRouterTests: XCTestCase {

    // MARK: - Shared infrastructure

    let navigationController = NonAnimatedNavigationController()
    let factory = ViewControllerFactoryStub()

    // ✅ Shared test data (single source of truth)
    let singleAnswerQuestion = Question.singleAnswer("Q1")
    let anotherSingleAnswerQuestion = Question.singleAnswer("Q2")
    let multipleAnswerQuestion = Question.multipleAnswer("Q1")

    lazy var sut = NavigationControllerRouter(
        self.navigationController,
        factory: self.factory
    )

    // MARK: - Tests

    func test_routeToQuestion_showQuestionController() {
        let viewController = UIViewController()
        let secondViewController = UIViewController()

        factory.stub(
            question: singleAnswerQuestion,
            with: viewController
        )
        factory.stub(
            question: anotherSingleAnswerQuestion,
            with: secondViewController
        )

        sut.routeTo(
            question: singleAnswerQuestion,
            answerCallback: { _ in }
        )
        sut.routeTo(
            question: anotherSingleAnswerQuestion,
            answerCallback: { _ in }
        )

        XCTAssertEqual(navigationController.viewControllers.count, 2)
        XCTAssertEqual(navigationController.viewControllers.first, viewController)
        XCTAssertEqual(navigationController.viewControllers.last, secondViewController)
    }

    func test_routeToQuestion_singleAnswer_answerCallback_progressesToNextQuestion() {
        let viewController = UIViewController()

        factory.stub(
            question: singleAnswerQuestion,
            with: viewController
        )

        sut.routeTo(
            question: singleAnswerQuestion,
            answerCallback: { _ in }
        )

        XCTAssertNil(viewController.navigationItem.rightBarButtonItem)
    }

    func test_routeToQuestion_singleAnswer_doesNotConfigureViewControllerWithSubmitButton() {
        let viewController = UIViewController()

        factory.stub(
            question: multipleAnswerQuestion,
            with: viewController
        )

        sut.routeTo(
            question: multipleAnswerQuestion,
            answerCallback: { _ in }
        )
    }

    func test_routeToQuestion_multipleAnswer_answerCallback_doesNotProgressesToNextQuestion() {
        var callbackFired = false

        sut.routeTo(
            question: multipleAnswerQuestion,
            answerCallback: { _ in callbackFired = true }
        )

        factory.answerCallback[multipleAnswerQuestion]!(["anything"])
        XCTAssertFalse(callbackFired)
    }

    func test_routeToQuestion_multipleAnswer_configureViewControllerWithSubmitButton() {
        let viewController = UIViewController()

        factory.stub(
            question: multipleAnswerQuestion,
            with: viewController
        )

        sut.routeTo(
            question: multipleAnswerQuestion,
            answerCallback: { _ in }
        )

        XCTAssertNotNil(viewController.navigationItem.rightBarButtonItem)
    }

    func test_routeToQuestion_multipleAnswerSubmitButton_isDisableWhenZeroAnswerSelected() {
        let viewController = UIViewController()

        factory.stub(
            question: multipleAnswerQuestion,
            with: viewController
        )

        sut.routeTo(
            question: multipleAnswerQuestion,
            answerCallback: { _ in }
        )

        XCTAssertFalse(
            viewController.navigationItem.rightBarButtonItem!.isEnabled
        )

        factory.answerCallback[multipleAnswerQuestion]!(["A1"])
        XCTAssertTrue(
            viewController.navigationItem.rightBarButtonItem!.isEnabled
        )

        factory.answerCallback[multipleAnswerQuestion]!([])
        XCTAssertFalse(
            viewController.navigationItem.rightBarButtonItem!.isEnabled
        )
    }

    func test_routeToQuestion_multipleAnswerSubmitButton_progressToNextQuestion() {
        let viewController = UIViewController()

        factory.stub(
            question: multipleAnswerQuestion,
            with: viewController
        )

        var callbackWasFired = false

        sut.routeTo(
            question: multipleAnswerQuestion,
            answerCallback: { _ in callbackWasFired = true }
        )

        factory.answerCallback[multipleAnswerQuestion]!(["A1"])
        let button = viewController.navigationItem.rightBarButtonItem!
        button.simulateTap()

        XCTAssertTrue(callbackWasFired)
    }

    func test_routeToResult_showsResultController() {
        let viewController = UIViewController()
        let secondViewController = UIViewController()

        let result = Result(
            answers: [singleAnswerQuestion: ["A1"]],
            score: 10
        )

        let secondResult = Result(
            answers: [anotherSingleAnswerQuestion: ["A2"]],
            score: 20
        )

        factory.stub(result: result, with: viewController)
        factory.stub(result: secondResult, with: secondViewController)

        sut.routeTo(result: result)
        sut.routeTo(result: secondResult)

        XCTAssertEqual(navigationController.viewControllers.count, 2)
        XCTAssertEqual(navigationController.viewControllers.first, viewController)
        XCTAssertEqual(navigationController.viewControllers.last, secondViewController)
    }

    // MARK: - Test Helpers

    class NonAnimatedNavigationController: UINavigationController {
        override func pushViewController(
            _ viewController: UIViewController,
            animated: Bool
        ) {
            super.pushViewController(viewController, animated: false)
        }
    }

    class ViewControllerFactoryStub: ViewControllerFactory {

        private var stubbedQuestions = Dictionary<Question<String>, UIViewController>()
        private var stubbedResults = Dictionary<Result<Question<String>, [String]>, UIViewController>()
        var answerCallback = Dictionary<Question<String>, ([String]) -> Void>()

        func stub(
            question: Question<String>,
            with viewController: UIViewController
        ) {
            stubbedQuestions[question] = viewController
        }

        func stub(
            result: Result<Question<String>, [String]>,
            with viewController: UIViewController
        ) {
            stubbedResults[result] = viewController
        }

        func questionViewController(
            for question: Question<String>,
            answerCallback: @escaping ([String]) -> Void
        ) -> UIViewController {
            self.answerCallback[question] = answerCallback
            return stubbedQuestions[question] ?? UIViewController()
        }

        func resultsViewController(
            for result: Result<Question<String>, [String]>
        ) -> UIViewController {
            stubbedResults[result] ?? UIViewController()
        }
    }
}

// MARK: - UIBarButtonItem Test Helper

private extension UIBarButtonItem {
    func simulateTap() {
        target!.performSelector(
            onMainThread: action!,
            with: nil,
            waitUntilDone: true
        )
    }
}
