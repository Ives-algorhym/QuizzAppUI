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

    let navigationController = NonAnimatedNavigationController()
    let factory = ViewControllerFactoryStub()
    lazy var sut = NavigationControllerRouter(
        self.navigationController,
        factory: self.factory
    )
    func test_routeToQuestion_showQuestionController() {

        let viewController = UIViewController()
        let scondViewController = UIViewController()
        factory
            .stub(question: Question.singleAnswer("Q1"), with: viewController)
        factory.stub(question: Question.singleAnswer("Q2"), with: scondViewController)

        sut.routeTo(question: Question.singleAnswer("Q1"), answerCallback: { _ in })
        sut.routeTo(question: Question.singleAnswer("Q2"), answerCallback: { _ in })

        XCTAssertEqual(navigationController.viewControllers.count, 2)
        XCTAssertEqual(navigationController.viewControllers.first, viewController)
        XCTAssertEqual(
            navigationController.viewControllers.last,
            scondViewController
        )
    }

    func test_routeToSecondQuestion_presentQuestionControllerWithRightCallback() {

        factory.stub(question: Question.singleAnswer("Q1"), with: UIViewController())

        var callbackFired = false

        sut.routeTo(question: Question.singleAnswer("Q1"), answerCallback: { _ in callbackFired = true })
        factory.answerCallback[Question.singleAnswer("Q1")]!(["anything"])
        XCTAssertTrue(callbackFired)

    }

    func test_routeToResult_showsResultController() {
        let viewController = UIViewController()
        let secondViewController = UIViewController()

        let result = Result(
            answers: [Question.singleAnswer("Q1"): ["A1"]],
            score: 10
        )

        let secondResult = Result(
            answers: [Question.singleAnswer("Q2"): ["A2"]],
            score: 20
        )

        factory.stub(result: result, with: viewController)
        factory.stub(result: secondResult, with: secondViewController)
        sut.routeTo(result: result)
        sut.routeTo(result: secondResult)

        XCTAssertEqual(
            navigationController.viewControllers.count,
            2
        )
        XCTAssertEqual(navigationController.viewControllers.first, viewController)
        XCTAssertEqual(
            navigationController.viewControllers.last,
            secondViewController
        )
    }

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

        func questionViewController(for question: Question<String>, answerCallback: @escaping([String]) -> Void) -> UIViewController {
            self.answerCallback[question] = answerCallback
            return stubbedQuestions[question] ?? UIViewController()
        }

        func resultsViewController(for result: Result<Question<String>, [String]>) -> UIViewController {
            return stubbedResults[result] ?? UIViewController()
        }
    }
}
