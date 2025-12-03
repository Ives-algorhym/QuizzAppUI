//
//  iOSViewControllerFactoryTests.swift
//  QuizzAppUITests
//
//  Created by Ives Murillo on 11/26/25.
//

import XCTest
@testable import QuizzAppUI
import QuizApp_iOS

class iOSViewControllerFactoryTests: XCTestCase {

    let singleAnswerQuestion = Question.singleAnswer("Q1")
    let multipleAnswerQuestion = Question.multipleAnswer("Q1")
    let options = ["A1", "A2"]

    func test_questionViewController_singleAnswer_createsControllerWithTitle() {
        let presenter = QuestionPresenter(
            questions: [singleAnswerQuestion],
            question: singleAnswerQuestion
        )
        XCTAssertEqual(
            makeQuestionController(question: singleAnswerQuestion).title,
            presenter.title
        )
    }

    func test_questionViewController_singleAnswer_createsControllerWithQuestion() {
        XCTAssertEqual(
            makeQuestionController(question: singleAnswerQuestion).question,
            "Q1"
        )
    }

    func test_questionViewController_singleAnswer_createsControllerWithOptions() {
        XCTAssertEqual(
            makeQuestionController(question: singleAnswerQuestion).options,
            options
        )
    }

    func test_questionViewController_singleAnswer_createsControllerWithSingleSelection() {

        let controller = makeQuestionController(
            question: singleAnswerQuestion
        )

        XCTAssertFalse(controller.allowsMultipleSelection)
    }

    // Multiple answers

    func test_questionViewController_multipleAnswer_createsControllerWithTitle() {
        let presenter = QuestionPresenter(
            questions: [singleAnswerQuestion, multipleAnswerQuestion],
            question: multipleAnswerQuestion
        )
        XCTAssertEqual(
            makeQuestionController(
                question: multipleAnswerQuestion
            ).title,
            presenter.title
        )
    }

    func test_questionViewController_multipleAnswer_createsControllerWithQuestion() {
        XCTAssertEqual(makeQuestionController(question: multipleAnswerQuestion).question, "Q1")
    }

    func test_questionViewController_multipleAnswer_createsControllerWithOptions() {
        XCTAssertEqual(
            makeQuestionController(question: multipleAnswerQuestion).options,
            options
        )
    }

    func test_questionViewController_multipleAnswer_createsControllerWithSingleSelection() {

        let controller = makeQuestionController(
            question: multipleAnswerQuestion
        )

        XCTAssertTrue(controller.allowsMultipleSelection)
    }

//    func test_resultViewController_createsController() {
//        let result = Result(answers: Dictionary<Question<String>, [String]>(), score: 0)
//        let sut = makeSUT(options: [:], correctAnswers: [:])
//        let controller = sut.resultsViewController(for: result) as? ResultsViewController
//        XCTAssertNotNil(controller)
//    }

    func test_resultViewController_createsViewControllerWithSummary() {
        let results = makeResults()

        XCTAssertEqual(results.controller.summary, results.presenter.summary)
    }

    func test_resultViewController_createsViewControllerWithPresentableAnswer() {
        let results = makeResults()
        
        XCTAssertEqual(results.controller.answers.count, results.presenter.presentableAnswers.count)
    }

    // MARK: Helpers

    func makeSUT(options: Dictionary<Question<String> , [String]> = [:], correctAnswers: Dictionary<Question<String>, [String]> = [:]) -> iOSViewControllerFactory {
        return iOSViewControllerFactory(
            questions: [singleAnswerQuestion, multipleAnswerQuestion],
            options: options,
            correctAnswers: correctAnswers
        )
    }

    func makeQuestionController(question: Question<String> = .singleAnswer("")) -> QuestionViewController {
        return makeSUT(options: [question: options])
            .questionViewController(
                for: question,
                answerCallback: {_ in
                }) as! QuestionViewController
    }

    func makeResults() -> (controller: ResultsViewController, presenter: ResultPresenter) {
        let userAnswers = [singleAnswerQuestion: ["A1"], multipleAnswerQuestion: ["A1", "A2"]]
        let correctAnswers = [singleAnswerQuestion: ["A1"], multipleAnswerQuestion: ["A1", "A2"]]

        let questions = [singleAnswerQuestion, multipleAnswerQuestion]
        let result = Result(answers: userAnswers, score: 2)

        let presenter = ResultPresenter(
            result: result,
            questions: questions,
            correctAnswers: correctAnswers
        )

        let sut = makeSUT(correctAnswers: correctAnswers)
        let controller = sut.resultsViewController(for: result) as! ResultsViewController

        return (controller, presenter)
    }
}
