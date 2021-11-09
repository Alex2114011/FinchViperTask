//
//  AddScreenAddScreenPresenter.swift
//  FinchViperTask
//
//  Created by Alex on 04/11/2021.
//  Copyright © 2021 AlexanderIvanov. All rights reserved.
//

import Foundation
final class AddScreenPresenter {

    // MARK: - Public Properties

    weak var view: AddScreenViewInput?
    var interactor: AddScreenInteractorInput?
    var router: AddScreenRouterInput?
    var notes: [Note]?

}

// MARK: - AddScreenViewOutput
extension AddScreenPresenter: AddScreenViewOutput {

}

// MARK: - AddScreenInteractorOutput
extension AddScreenPresenter: AddScreenInteractorOutput {

}

// MARK: - AddScreenRouterOutput
extension AddScreenPresenter: AddScreenRouterOutput {

}
