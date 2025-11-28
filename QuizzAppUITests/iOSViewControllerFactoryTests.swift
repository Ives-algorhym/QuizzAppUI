//
//  iOSViewControllerFactoryTests.swift
//  QuizzAppUITests
//
//  Created by Ives Murillo on 11/26/25.
//

import XCTest
@testable import QuizzAppUI

class iOSViewControllerFactoryTests: XCTestCase {
    func test_questionViewController_createsController() {

        let questions = Question.singleAnswer("Q1")
        let options = ["A1", "A2"]
        let sut = iOSViewControllerFactory(options: [questions: options])

        let controller = sut.questionViewController (
            for: Question.singleAnswer("Q1"), answerCallback: {
                _ in
            }
        ) as! QuestionViewController
        XCTAssertEqual(controller.question, "Q1")
    }

    func test_questionViewController_createsControllerWithOptions() {

        let questions = Question.singleAnswer("Q1")
        let options = ["A1", "A2"]
        let sut = iOSViewControllerFactory(options: [questions: options])

        let controller = sut.questionViewController (
            for: Question.singleAnswer("Q1"), answerCallback: {
                _ in
            }
        ) as! QuestionViewController
        XCTAssertEqual(controller.options, options)
    }
}
