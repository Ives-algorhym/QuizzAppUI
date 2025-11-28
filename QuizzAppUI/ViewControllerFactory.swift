//
//  ViewControllerFactory.swift
//  QuizzAppUI
//
//  Created by Ives Murillo on 11/26/25.
//
import UIKit
import QuizApp_iOS

protocol ViewControllerFactory {
    func questionViewController(for question: Question<String>,answerCallback: @escaping([String]) -> Void) -> UIViewController

    func resultsViewController(for result: Result<Question<String>, [String]>) -> UIViewController
}
