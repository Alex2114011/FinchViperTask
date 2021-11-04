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

}

// MARK: - ListScreenViewOutput
extension ListScreenPresenter: ListScreenViewOutput {

}

// MARK: - ListScreenInteractorOutput
extension ListScreenPresenter: ListScreenInteractorOutput {

}

// MARK: - ListScreenRouterOutput
extension ListScreenPresenter: ListScreenRouterOutput {

}
