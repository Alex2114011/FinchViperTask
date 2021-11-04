//
//  DetailScreenDetailScreenPresenter.swift
//  FinchViperTask
//
//  Created by Alex on 04/11/2021.
//  Copyright © 2021 AlexanderIvanov. All rights reserved.
//

final class DetailScreenPresenter {

    // MARK: - Public Properties

    weak var view: DetailScreenViewInput?
    var interactor: DetailScreenInteractorInput?
    var router: DetailScreenRouterInput?
}

// MARK: - DetailScreenViewOutput
extension DetailScreenPresenter: DetailScreenViewOutput {
}

// MARK: - DetailScreenInteractorOutput
extension DetailScreenPresenter: DetailScreenInteractorOutput {

}

// MARK: - DetailScreenRouterOutput
extension DetailScreenPresenter: DetailScreenRouterOutput {

}
