//
//  ListScreenListScreenRouter.swift
//  FinchViperTask
//
//  Created by Alex on 04/11/2021.
//  Copyright © 2021 AlexanderIvanov. All rights reserved.
//
import UIKit
final class ListScreenRouter {

    // MARK: - Public Properties

    weak var presenter: ListScreenRouterOutput?
    weak var viewController: ListScreenViewController!

    init(viewController: ListScreenViewController) {
        self.viewController = viewController
    }

}

// MARK: - ListScreenRouterInput 
extension ListScreenRouter: ListScreenRouterInput {
    func routToAddScreenModule() {
        let view = AddScreenAssembly.assembleModule()
        viewController.navigationController?.pushViewController(view, animated: true)
    }
}
