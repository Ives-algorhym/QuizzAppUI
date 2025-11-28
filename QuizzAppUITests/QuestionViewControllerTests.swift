//
//  QuestionViewControllerTests.swift
//  QuizzAppUITests
//
//  Created by Ives Murillo on 10/27/25.
//

import Foundation
import XCTest
@testable import QuizzAppUI

class QuestionViewControllerTests: XCTestCase {
    func test_viewDidload_renderQuestionHeaderText(){
        XCTAssertEqual(makeSUT(question: "Q1").headerLabel.text, "Q1")
    }

    func test_viewDidLoad_withdNoOpnions_renderZeroOptions() {
        XCTAssertEqual(makeSUT(options: []).tableView.numberOfRows(inSection: 0), 0)
    }

    func test_viewDidLoad_withdOneOpnions_renderOneOption() {
        let sut = makeSUT(options: ["A1"])
        XCTAssertEqual(sut.tableView.numberOfRows(inSection: 0), 1)
    }

    func test_viewDidLoad_withdTwoOpnions_renderTwoOption() {
        let sut = makeSUT(options: ["A1", "A2"])
        XCTAssertEqual(sut.tableView.numberOfRows(inSection: 0), 2)
    }

    func test_viewDidLoad_withOneOption_renderOneOptionText() {
        let sut = makeSUT(options: ["A1"])
        XCTAssertEqual(sut.tableView.title(at: 0), "A1")
    }

    func test_viewDidLoad_withTwoOption_renderTwoOptionText() {
        let sut = makeSUT(options: ["A1", "A2"])
        XCTAssertEqual(sut.tableView.title(at: 1), "A2")
    }

    func test_optionSelected_withTwoOptions_notifyDelegateWithLastSelection() {
        var receiveAnswer = [String]()
        let sut = makeSUT(options: ["A1", "A2"]) {
            receiveAnswer = $0
        }

        sut.tableView.select(row: 0)
        XCTAssertEqual(receiveAnswer, ["A1"])

        sut.tableView.select(row: 1)
        XCTAssertEqual(receiveAnswer, ["A2"])
    }

    func test_optionSelected_withSingleleSelections_notifyDelegateWithEmptySelection() {
        var callbackCount = 0
        let sut = makeSUT(options: ["A1", "A2"]) {_ in 
            callbackCount += 1
        }

        sut.tableView.select(row: 0)
        XCTAssertEqual(callbackCount, 1)

        sut.tableView.deselect(row: 0)
        XCTAssertEqual(callbackCount, 1)
    }

    func test_optionSelected_withMultipleSelections_notifyDelegateWithLastSelection() {
        var receiveAnswer = [String]()
        let sut = makeSUT(options: ["A1", "A2"]) {
            receiveAnswer = $0
        }
        sut.tableView.allowsMultipleSelection = true
        sut.tableView.select(row: 0)
        XCTAssertEqual(receiveAnswer, ["A1"])

        sut.tableView.select(row: 1)
        XCTAssertEqual(receiveAnswer, ["A1", "A2"])
    }

    func test_optionDeselected_withMultipleSelectionsEnabled_notifyDelegate() {
        var receiveAnswer = [String]()
        let sut = makeSUT(options: ["A1", "A2"]) {
            receiveAnswer = $0
        }
        sut.tableView.allowsMultipleSelection = true
        sut.tableView.select(row: 0)
        XCTAssertEqual(receiveAnswer, ["A1"])

        sut.tableView.deselect(row: 0)
        XCTAssertEqual(receiveAnswer, [])
    }

    // MARK: - Helpers

    func makeSUT(
        question: String = "",
        options: [String] = [],
    selection: @escaping ([String]) -> Void = { _ in }
    ) -> QuestionViewController {
        let sut = QuestionViewController(
            question: question,
            options: options,
            selection: selection
        )
        _ = sut.view
        return sut
    }
}


