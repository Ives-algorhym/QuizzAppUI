//
//  QuestionViewController.swift
//  QuizzAppUITests
//
//  Created by Ives Murillo on 10/27/25.
//

import Foundation
import UIKit

class QuestionViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    private(set) var question = ""
    private(set) var options = [String]()
    private(set) var allowsMultipleSelection = false
    private var selection: (([String]) -> Void)? = nil
    private let reusableIdentifier = "Cell"

    var headerLabel: UILabel!
    var tableView: UITableView!

    convenience init(question: String, options: [String], allowsMultipleSelection: Bool, selection: @escaping ([String]) -> Void) {
        self.init()
        self.question = question
        self.options = options
        self.allowsMultipleSelection = allowsMultipleSelection
        self.selection = selection
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        headerLabel = UILabel()
        headerLabel.text = question

        tableView = UITableView()
        tableView.dataSource = self
        tableView.delegate = self
        tableView.allowsMultipleSelection = allowsMultipleSelection

        setupUI()
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return options.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = dequeueCell(in: tableView)
        cell.textLabel?.text = options[indexPath.row]
        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selection?(selectedOptions(in: tableView))
    }

    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        if tableView.allowsMultipleSelection {
            selection?(selectedOptions(in: tableView))
        }
    }

    private func selectedOptions(in tableView: UITableView) -> [String] {
        guard let indexPath = tableView.indexPathsForSelectedRows else {
            return []
        }
        return indexPath.map {
            options[ $0.row]
        }
    }

    private func dequeueCell(in tableView: UITableView) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(
            withIdentifier: reusableIdentifier
        ) {
            return cell
        }
        return UITableViewCell(
            style: .default,
            reuseIdentifier: reusableIdentifier
        )
    }

    func setupUI() {
        view.backgroundColor = .systemBackground

        // Add subviews
        view.addSubview(headerLabel)
        view.addSubview(tableView)

        // Enable Auto Layout
        headerLabel.translatesAutoresizingMaskIntoConstraints = false
        tableView.translatesAutoresizingMaskIntoConstraints = false

        // Style headerLabel
        headerLabel.textAlignment = .center
        headerLabel.numberOfLines = 0
        headerLabel.font = UIFont.systemFont(ofSize: 22, weight: .bold)

        // Define constraints
        NSLayoutConstraint.activate([
            // Center headerLabel horizontally, and position it near top center
            headerLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            headerLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 80),
            headerLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            headerLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),

            // Place tableView below label, centered, and fill remaining space
            tableView.topAnchor.constraint(equalTo: headerLabel.bottomAnchor, constant: 30),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -40)
        ])
    }
}
