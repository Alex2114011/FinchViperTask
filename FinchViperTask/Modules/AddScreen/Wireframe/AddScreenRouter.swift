//
//  AddScreenAddScreenRouter.swift
//  FinchViperTask
//
//  Created by Alex on 04/11/2021.
//  Copyright © 2021 AlexanderIvanov. All rights reserved.
//

final class AddScreenRouter {

    // MARK: - Public Properties

    weak var viewController: AddScreenViewController!

    init(viewController: AddScreenViewController) {
        self.viewController = viewController
    }

}

// MARK: - AddScreenRouterInput 
extension AddScreenRouter: AddScreenRouterInput {
    func closeCurrentViewController() {
        viewController.navigationController?.popViewController(animated: true)
    }

}
