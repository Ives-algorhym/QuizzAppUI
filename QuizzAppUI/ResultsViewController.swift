//
//  ResultsViewController.swift
//  QuizzAppUI
//
//  Created by Ives Murillo on 10/30/25.
//

import Foundation
import UIKit

final class ResultsViewController: UIViewController, UITableViewDataSource {
    private var sumary: String = ""
    private var answers = [PresentableAnswer]()

    var headerLabel: UILabel!
    var tableView: UITableView!

    convenience init(sumary: String, answers: [PresentableAnswer]) {
        self.init()
        self.sumary = sumary
        self.answers = answers
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        headerLabel = UILabel()
        headerLabel.text = sumary

        tableView = UITableView()
        tableView.dataSource = self
        tableView.register(CorrectAnswerCell.self)
        tableView.register(WrongAnswerCell.self)

        setupUI()
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return answers.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let answer = answers[indexPath.row]
        if answer.wrongAnswer == nil {
            return correctAnswerCell(for: answer)
        }

        return  wrongAnswerCell(for: answer)
    }

    private func correctAnswerCell(for answer: PresentableAnswer) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(CorrectAnswerCell.self)!
        cell.questionLabel.text = answer.question
        cell.answerLabel.text = answer.answer
        return cell
    }

    private func wrongAnswerCell(for answer: PresentableAnswer) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(WrongAnswerCell.self)!
        cell.questionLabel.text = answer.question
        cell.correctAnswerLabel.text = answer.answer
        cell.wrongAnswerLabel.text = answer.wrongAnswer
        return cell
    }

    private func setupUI() {
        view.backgroundColor = .systemBackground
        view.addSubview(headerLabel)
        view.addSubview(tableView)
        headerLabel.translatesAutoresizingMaskIntoConstraints = false
        tableView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            headerLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            headerLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor),

            // Place tableView below label, centered, and fill remaining space
            tableView.topAnchor.constraint(equalTo: headerLabel.bottomAnchor, constant: 30),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -40)
        ])
    }
}
