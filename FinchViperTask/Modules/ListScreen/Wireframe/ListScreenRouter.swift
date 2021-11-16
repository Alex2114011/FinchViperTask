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

    weak var viewController: ListScreenViewController!

    init(viewController: ListScreenViewController) {
        self.viewController = viewController
    }

}

// MARK: - ListScreenRouterInput 
extension ListScreenRouter: ListScreenRouterInput {
    func routToDetailModule(with note: Note) {
        let view = DetailScreenAssembly.assembleModule(with: note)
        viewController.navigationController?.pushViewController(view, animated: true)
    }

    func routToAddScreenModule(delegate: AddScreenDelegateProtocol?) {
        let view = AddScreenAssembly.assembleModule(delegate: delegate)
        viewController.navigationController?.pushViewController(view, animated: true)
    }
}
