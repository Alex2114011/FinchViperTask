//
//  AddScreenAddScreenPresenter.swift
//  FinchViperTask
//
//  Created by Alex on 04/11/2021.
//  Copyright © 2021 AlexanderIvanov. All rights reserved.
//

import Foundation

protocol AddScreenDelegateProtocol: AnyObject {
    func passNoteToList(note: Note?)
}

final class AddScreenPresenter {

    // MARK: - Public Properties

    weak var view: AddScreenViewInput?
    var router: AddScreenRouterInput?
    weak var delegate: AddScreenDelegateProtocol?

}

// MARK: - AddScreenViewOutput
extension AddScreenPresenter: AddScreenViewOutput {
    func showErrorEmtyFields() {
        view?.showErrorEmtyText()
    }

    func goToPreviosViewController() {
        router?.closeCurrentViewController()
    }

    func saveNote(imageNote: Data, titleNote: String, descriptionNote: String) {
        let note = Note(imageNote: imageNote, titleNote: titleNote, descriptionNote: descriptionNote)
        delegate?.passNoteToList(note: note)
    }
}
