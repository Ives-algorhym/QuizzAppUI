//
//  Question.swift
//  QuizzAppUI
//
//  Created by Ives Murillo on 11/25/25.
//


enum Question<T: Hashable> : Hashable {
    case singleAnswer(T)
    case multipleAnswer(T)

    static func ==(lhs: Question<T>, rhs: Question<T>) -> Bool {
        switch (lhs, rhs) {
        case(.singleAnswer(let a), .singleAnswer(let b)):
            return a == b
        case(.multipleAnswer(let a), .multipleAnswer(let b)):
            return a == b
        default:
            return false
        }
    }
}