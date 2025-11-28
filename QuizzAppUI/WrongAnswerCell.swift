//
//  WrongAnswerCell.swift
//  QuizzAppUI
//
//  Created by Ives Murillo on 11/2/25.
//

import UIKit

class WrongAnswerCell: UITableViewCell {
    var questionLabel: UILabel!
    var correctAnswerLabel: UILabel!
    var wrongAnswerLabel: UILabel!

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
           super.init(style: style, reuseIdentifier: reuseIdentifier)
           setupUI()
       }

       required init?(coder: NSCoder) {
           super.init(coder: coder)
           setupUI()
       }

    private func setupUI() {
           // MARK: Create labels
           questionLabel = UILabel()
           questionLabel.font = UIFont.systemFont(ofSize: 16, weight: .semibold)
           questionLabel.numberOfLines = 0

           correctAnswerLabel = UILabel()
           correctAnswerLabel.font = UIFont.systemFont(ofSize: 14)
           correctAnswerLabel.textColor = .systemGreen
           correctAnswerLabel.numberOfLines = 0

           wrongAnswerLabel = UILabel()
           wrongAnswerLabel.font = UIFont.systemFont(ofSize: 14)
           wrongAnswerLabel.textColor = .systemRed
           wrongAnswerLabel.numberOfLines = 0

           // MARK: Add to contentView
           contentView.addSubview(questionLabel)
           contentView.addSubview(correctAnswerLabel)
           contentView.addSubview(wrongAnswerLabel)

           // MARK: Enable Auto Layout
           questionLabel.translatesAutoresizingMaskIntoConstraints = false
           correctAnswerLabel.translatesAutoresizingMaskIntoConstraints = false
           wrongAnswerLabel.translatesAutoresizingMaskIntoConstraints = false

           // MARK: Layout constraints
           NSLayoutConstraint.activate([
               // Question label at top
               questionLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
               questionLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
               questionLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),

               // Correct answer below question
               correctAnswerLabel.topAnchor.constraint(equalTo: questionLabel.bottomAnchor, constant: 4),
               correctAnswerLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
               correctAnswerLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),

               // Wrong answer below correct answer
               wrongAnswerLabel.topAnchor.constraint(equalTo: correctAnswerLabel.bottomAnchor, constant: 4),
               wrongAnswerLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
               wrongAnswerLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
               wrongAnswerLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -8)
           ])
       }
}

