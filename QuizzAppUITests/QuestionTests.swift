//
//  QuestionTests.swift
//  QuizzAppUITests
//
//  Created by Ives Murillo on 11/25/25.
//

import XCTest
@testable import QuizzAppUI

class QuestionTests: XCTest {
    func test_hashValue_singleAnswer_returnsTypeHash() {
        let type = "a string"

        let sut = Question.singleAnswer(type)

        XCTAssertEqual(sut.hashValue, type.hashValue)

    }
}
