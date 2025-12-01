//
//  Helpers.swift
//  QuizzAppUI
//
//  Created by Ives Murillo on 11/28/25.
//

@testable import QuizApp_iOS

extension Result: Hashable {

    public var hashValue: Int {
        return 1
    }

    public static func ==(lhs: Result<Question, Answer>, rhs: Result<Question, Answer>) -> Bool {
        return lhs.score == rhs.score
    }
}

