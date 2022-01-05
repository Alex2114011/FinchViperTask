//
//  ListScreenListScreenViewController.swift
//  FinchViperTask
//
//  Created by Alex on 04/11/2021.
//  Copyright © 2021 AlexanderIvanov. All rights reserved.
//

import UIKit
import SnapKit
final class ListScreenViewController: UIViewController {

    // MARK: - Public Properties

    var presenter: ListScreenViewOutput!

    // MARK: - Private Properties
    private var listTableView = UITableView()
    private let themeProvider = Style.DarkStyle

    // MARK: - LifeCircle
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter.loadNotes()
        setupTable()
        setupNavigationBar()
    }

    // MARK: - Private Methods
    private func setupTheme() {
        listTableView.backgroundColor = themeProvider.blackViewColor
    }

    private func setupTable() {
        // Delegate
        listTableView.dataSource = self
        listTableView.delegate = self
        // SetupUI Table
        view.addSubview(listTableView)
        listTableView.snp.makeConstraints { make in
            make.top.left.right.bottom.equalToSuperview()
        }
        // Register cell
//        listTableView.register(cell: ListTableViewCell.self)
        listTableView.registerCellClass(cell: ListTableViewCell.self)
        listTableView.separatorStyle = .none
    }

    private func setupNavigationBar() {
        navigationItem.title = "Главный экран"
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add,
                                                            target: self,
                                                            action: #selector(addRow(sender:)))
    }

    @objc private func addRow(sender: UIBarButtonItem) {
        presenter.addNoteScreen()
    }
}

// MARK: - ListScreenViewInput
extension ListScreenViewController: ListScreenViewInput {
    func reloadTableView() {
        listTableView.reloadData()
    }
}

// MARK: - UITableViewDataSource
extension ListScreenViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {

        guard let notes = presenter.notes else { return 0 }
        return notes.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.getCell(ListTableViewCell.self, indexPath)
        cell.selectionStyle = .none

        guard let items = presenter.notes else { return UITableViewCell()}
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
            let index = indexPath.row
            presenter?.deleteNote(with: index)
            listTableView.deleteRows(at: [indexPath], with: .fade)
        }
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        presenter.didTapToCell(with: Int(indexPath.row))
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 68
    }
}
