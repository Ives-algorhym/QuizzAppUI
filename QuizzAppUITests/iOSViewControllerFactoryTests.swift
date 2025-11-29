//
//  iOSViewControllerFactoryTests.swift
//  QuizzAppUITests
//
//  Created by Ives Murillo on 11/26/25.
//

import XCTest
@testable import QuizzAppUI

class iOSViewControllerFactoryTests: XCTestCase {

    let options = ["A1", "A2"]

    func test_questionViewController_singleAnswer_createsControllerWithQuestion() {
        XCTAssertEqual(
            makeQuestionController(question: Question.singleAnswer("Q1")).question,
            "Q1"
        )
    }

    func test_questionViewController_singleAnswer_createsControllerWithOptions() {
        XCTAssertEqual(
            makeQuestionController(question: Question.singleAnswer("Q1")).options,
            options
        )
    }

    func test_questionViewController_singleAnswer_createsControllerWithSingleSelection() {

        let controller = makeQuestionController(
            question: Question.singleAnswer("Q1")
        )
        _ = controller.view

        XCTAssertFalse(controller.tableView.allowsMultipleSelection)
    }

    // Multiple answers

    func test_questionViewController_multipleAnswer_createsControllerWithQuestion() {
        XCTAssertEqual(
            makeQuestionController(
                question: Question.multipleAnswer("Q1")
            ).question,
            "Q1"
        )
    }

    func test_questionViewController_multipleAnswer_createsControllerWithOptions() {
        XCTAssertEqual(makeQuestionController(question: Question.multipleAnswer("Q1")).options, options)
    }

    func test_questionViewController_multipleAnswer_createsControllerWithSingleSelection() {

        let controller = makeQuestionController(question: Question.multipleAnswer("Q1"))
        _ = controller.view

        XCTAssertTrue(controller.tableView.allowsMultipleSelection)
    }



    // MARK: Helpers

    func makeSUT(options: Dictionary<Question<String>, [String]>) -> iOSViewControllerFactory {
        return iOSViewControllerFactory(options: options)
    }

    func makeQuestionController(question: Question<String> = .singleAnswer("")) -> QuestionViewController {

        return makeSUT(options: [question: options])
            .questionViewController(
                for: question,
                answerCallback: {_ in
                }) as! QuestionViewController
    }
}
