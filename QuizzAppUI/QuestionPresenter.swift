//
//  QuestionPresenter.swift
//  QuizzAppUI
//
//  Created by Ives Murillo on 12/1/25.
//

import Foundation
import QuizApp_iOS

struct QuestionPresenter {
    let questions: [Question<String>]
    let question: Question<String>

    var title: String {

        guard let index = questions.firstIndex(of: question) else {
            return ""
        }
        return "Question #\(index + 1)"
    }
}
