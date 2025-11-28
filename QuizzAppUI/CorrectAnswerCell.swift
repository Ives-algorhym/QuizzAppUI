//
//  CorrectAnswerCell.swift
//  QuizzAppUI
//
//  Created by Ives Murillo on 11/2/25.
//

import UIKit

class CorrectAnswerCell: UITableViewCell {
    var questionLabel: UILabel!
    var answerLabel: UILabel!

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
           super.init(style: style, reuseIdentifier: reuseIdentifier)
           setupUI()
       }

       required init?(coder: NSCoder) {
           super.init(coder: coder)
           setupUI()
       }

       private func setupUI() {
           questionLabel = UILabel()
           questionLabel.font = UIFont.systemFont(ofSize: 16, weight: .semibold)
           questionLabel.numberOfLines = 0
           questionLabel.translatesAutoresizingMaskIntoConstraints = false
           contentView.addSubview(questionLabel)

           answerLabel = UILabel()
           answerLabel.font = UIFont.systemFont(ofSize: 14)
           answerLabel.textColor = .systemGreen
           answerLabel.numberOfLines = 0
           answerLabel.translatesAutoresizingMaskIntoConstraints = false
           contentView.addSubview(answerLabel)

           // Set constraints
                  NSLayoutConstraint.activate([
                      // Question label at top
                      questionLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
                      questionLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
                      questionLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),

                      // Answer label below question
                      answerLabel.topAnchor.constraint(equalTo: questionLabel.bottomAnchor, constant: 4),
                      answerLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
                      answerLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
                      answerLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -8)
                  ])


       }
}
