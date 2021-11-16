//
//  DetailScreenDetailScreenPresenter.swift
//  FinchViperTask
//
//  Created by Alex on 04/11/2021.
//  Copyright © 2021 AlexanderIvanov. All rights reserved.
//

import Foundation

final class DetailScreenPresenter {

    // MARK: - Public Properties

    weak var view: DetailScreenViewInput?
    var note: Note?
}

// MARK: - DetailScreenViewOutput
extension DetailScreenPresenter: DetailScreenViewOutput {
    func configureView() {
        guard let note = note else { return }
        view?.assignUIElements(to: note.imageNote, and: note.titleNote, and: note.descriptionNote)
    }
}
