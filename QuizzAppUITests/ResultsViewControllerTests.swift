//
//  ResultsViewControllerTests.swift
//  QuizzAppUITests
//
//  Created by Ives Murillo on 10/30/25.
//

import Foundation
import XCTest
@testable import QuizzAppUI

class ResultsViewControllerTests: XCTestCase {
    func test_viewDidload_renderSumary() {
        XCTAssertEqual(makeSUT(sumary: "a summary", answers: []).headerLabel.text, "a summary")
    }

    func test_viewDidaload_renderAnswers() {
        XCTAssertEqual(makeSUT(answers: []).tableView.numberOfRows(inSection: 0), 0)
        XCTAssertEqual(
            makeSUT(answers: [makeAnswer()]).tableView
                .numberOfRows(inSection: 0),
            1
        )
    }

    func test_viewDidLoad_withCorrectAnswer_configureCell() {
        let answer = makeAnswer(question: "Q1", answer: "A1")
        let sut = makeSUT(
            answers: [answer]
        )

        let cell = sut.tableView.cell(at: 0) as? CorrectAnswerCell
        XCTAssertNotNil(cell)
        XCTAssertEqual(cell?.questionLabel.text, "Q1")
        XCTAssertEqual(cell?.answerLabel.text, "A1")
    }

    func test_viewDidLoad_withWrongAnswer_configureCell() {
        let answer = makeAnswer(question: "Q1", answer: "A1", wrongAnswer: "wrong")
        let sut = makeSUT(
            answers: [answer]
        )

        let cell = sut.tableView.cell(at: 0) as? WrongAnswerCell
        XCTAssertNotNil(cell)
        XCTAssertEqual(cell?.questionLabel.text, "Q1")
        XCTAssertEqual(cell?.correctAnswerLabel.text, "A1")
        XCTAssertEqual(cell?.wrongAnswerLabel.text, "wrong")
    }


    // MARK: Helpers

    func makeSUT(sumary: String = "", answers: [PresentableAnswer] = []) -> ResultsViewController {
        let sut = ResultsViewController(sumary: sumary, answers: answers)
        _ = sut.view
        return sut
    }

    func makeAnswer(question: String = "", answer: String = "", wrongAnswer: String? = nil) -> PresentableAnswer {
        return PresentableAnswer(
            question: question,
            answer: answer,
            wrongAnswer: wrongAnswer
        )
    }
}
