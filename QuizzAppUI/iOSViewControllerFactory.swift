//
//  iOSViewControllerFactory.swift
//  QuizzAppUI
//
//  Created by Ives Murillo on 11/26/25.
//

import UIKit
import QuizApp_iOS

final class iOSViewControllerFactory: ViewControllerFactory {

    private let options: Dictionary<Question<String>, [String]>

    init(options: Dictionary<Question<String>, [String]>) {
        self.options = options
    }

    func questionViewController(for question: Question<String>, answerCallback: @escaping ([String]) -> Void) -> UIViewController {

        switch question {
        case .singleAnswer(let value):
            return QuestionViewController(question: value,options: options[question]!, selection: answerCallback)
        default:
            return UIViewController()
        }

    }

    func resultsViewController(for result: QuizApp_iOS.Result<Question<String>, [String]>) -> UIViewController {
        UIViewController()
    }
}
