//
//  ListScreenListScreenPresenter.swift
//  FinchViperTask
//
//  Created by Alex on 04/11/2021.
//  Copyright © 2021 AlexanderIvanov. All rights reserved.
//

import Foundation

final class ListScreenPresenter {

    // MARK: - Public Properties

    weak var view: ListScreenViewInput?
    var interactor: ListScreenInteractorInput?
    var router: ListScreenRouterInput?
    var notes: [Note]? = []
}

// MARK: - ListScreenViewOutput
extension ListScreenPresenter: ListScreenViewOutput {
    func didTapToCell(with index: Int) {
        guard let notes = notes else { return }
        let note: Note = notes[index]
        router?.routToDetailModule(with: note)
    }

    func deleteNote(with index: Int) {
        if notes != nil {
        notes?.remove(at: index)
        }
    }

    func addNoteScreen() {
        router?.routToAddScreenModule(delegate: self)
    }
}

// MARK: - ListScreenInteractorOutput
extension ListScreenPresenter: ListScreenInteractorOutput {
    func rawNotes(note: [Note]) {
        self.notes = note
    }
}

// MARK: - ListScreenRouterOutput
extension ListScreenPresenter: ListScreenRouterOutput {

}

extension ListScreenPresenter: AddScreenDelegateProtocol {
    func passNoteToList(note: Note?) {
        guard let note = note else { return }
        notes?.append(note)
        view?.reloadTableView()
    }

}
