//
//  ListScreenListScreenPresenter.swift
//  FinchViperTask
//
//  Created by Alex on 04/11/2021.
//  Copyright © 2021 AlexanderIvanov. All rights reserved.
//

import Foundation
import CoreData

final class ListScreenPresenter {

    // MARK: - Public Properties

    weak var view: ListScreenViewInput?
    var router: ListScreenRouterInput?

    var notes: [Note]?
}

// MARK: - ListScreenViewOutput
extension ListScreenPresenter: ListScreenViewOutput {

    func loadNotes() {
        let noteFetch: NSFetchRequest<Note> = Note.fetchRequest()

        do {
            notes = try CoreDataStack.shared.managedContext.fetch(noteFetch)
        } catch let error as NSError {
            print("Could not fetch. \(error), \(error.userInfo)")
        }
    }

    func didTapToCell(with index: Int) {
        guard let notes = notes else { return }
        let note: Note = notes[index]
        router?.routToDetailModule(with: note)
    }

    func deleteNote(with index: Int) {
        guard let noteToRemove = notes?[index] else { return }

        notes?.remove(at: index)

        CoreDataStack.shared.managedContext.delete(noteToRemove)
        CoreDataStack.shared.saveContext()
    }

    func addNoteScreen() {
        router?.routToAddScreenModule(delegate: self)
    }
}

// MARK: - AddScreenDelegateProtocol
extension ListScreenPresenter: AddScreenDelegateProtocol {
    func passNoteToList(note: Note?) {
        guard let note = note else { return }
        notes?.append(note)
        view?.reloadTableView()
    }
}
