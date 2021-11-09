//
//  ListScreenListScreenViewController.swift
//  FinchViperTask
//
//  Created by Alex on 04/11/2021.
//  Copyright © 2021 AlexanderIvanov. All rights reserved.
//

import UIKit

final class ListScreenViewController: UIViewController {

    // MARK: - Public Properties

    var presenter: ListScreenViewOutput?

    // MARK: - Private Properties
    private var listTableView = UITableView()

    // MARK: - LifeCircle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTable()
        setupNavigationBar()
    }

    // MARK: - Private Methods
    private func setupTable() {
        // Delegate
        listTableView.dataSource = self
        listTableView.delegate = self
        // SetupUI Table
        view.addSubview(listTableView)
        listTableView.translatesAutoresizingMaskIntoConstraints = false
        listTableView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        listTableView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        listTableView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        listTableView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        // Register cell
        listTableView.register(cell: ListTableViewCell.self)
        listTableView.separatorStyle = .none
    }

    private func setupNavigationBar() {
        navigationItem.title = "Главный экран"
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add,
                                                           target: self,
                                                           action: #selector(addRow(sender:)))
    }

    @objc private func addRow(sender: UIBarButtonItem) {
        presenter?.addNoteScreen()
    }
}

// MARK: - ListScreenViewInput
extension ListScreenViewController: ListScreenViewInput {

}

// MARK: - UITableViewDataSource
extension ListScreenViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {

        guard let notes = presenter?.notes else { return 0 }
        return notes.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.getCell(ListTableViewCell.self, indexPath)
        cell.selectionStyle = .none

        guard let items = presenter?.notes else { return UITableViewCell()}
        let item = items[indexPath.row]
        cell.updateUI(width: item)
        return cell
    }
}
// MARK: - UITableViewDelegate
extension ListScreenViewController: UITableViewDelegate {

    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }

    func tableView(_ tableView: UITableView,
                   commit editingStyle: UITableViewCell.EditingStyle,
                   forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // todo метод для удаления элементов
        }
    }
}
