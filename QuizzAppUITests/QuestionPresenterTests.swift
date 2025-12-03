//
//  QuestionPresenterTests.swift
//  QuizzAppUITests
//
//  Created by Ives Murillo on 12/1/25.
//

import XCTest
@testable import QuizzAppUI

final class QuestionPresenterTests: XCTestCase {
    let question1 = Question.singleAnswer("A1")
    let question2 = Question.singleAnswer("A2")

    func test_title_forFirstQuestion_formatTitleForIndex() {
        let sut = QuestionPresenter(questions: [question1], question: question1)
        XCTAssertEqual(sut.title, "Question #1")
    }

    func test_title_forSecondQuestion_formatTitleForIndex() {
        let sut = QuestionPresenter(
            questions: [question1, question2],
            question: question2
        )

        XCTAssertEqual(sut.title, "Question #2")
    }

    func test_title_forUnexistentQuestion_isEmpty() {
        let sut = QuestionPresenter(
            questions: [],
            question: Question.singleAnswer("A1")
        )

        XCTAssertEqual(sut.title, "")
    }
}
