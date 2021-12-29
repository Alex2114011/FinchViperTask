//
//  AddScreenAddScreenAssembly.swift
//  FinchViperTask
//
//  Created by Alex on 04/11/2021.
//  Copyright © 2021 AlexanderIvanov. All rights reserved.
//

 import UIKit

 final class AddScreenAssembly {

    class func assembleModule(delegate: AddScreenDelegateProtocol?) -> UIViewController {

        let view = AddScreenViewController()
        let presenter = AddScreenPresenter()
        let router = AddScreenRouter(viewController: view)

        presenter.router = router
        presenter.view = view
        presenter.delegate = delegate

        view.presenter = presenter

        return view
    }

 }
