//
//  ListScreenListScreenPresenter.swift
//  FinchViperTask
//
//  Created by Alex on 04/11/2021.
//  Copyright © 2021 AlexanderIvanov. All rights reserved.
//

final class ListScreenPresenter {

    // MARK: - Public Properties

    weak var view: ListScreenViewInput?
    var interactor: ListScreenInteractorInput?
    var router: ListScreenRouterInput?

    var notes: [Note]?
}

// MARK: - ListScreenViewOutput
extension ListScreenPresenter: ListScreenViewOutput {
    func addNoteScreen() {
        router?.routToAddScreenModule()
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
    func goToAddScreen() {
//        router?.routToAddScreenModule()
    }
}
