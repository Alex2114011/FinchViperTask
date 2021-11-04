//
//  AddScreenAddScreenAssembly.swift
//  FinchViperTask
//
//  Created by Alex on 04/11/2021.
//  Copyright © 2021 AlexanderIvanov. All rights reserved.
//

import UIKit

final class AddScreenAssembly {

    class func assembleModule() -> UIViewController {

        let view = AddScreenViewController()
        let presenter = AddScreenPresenter()
        let interactor = AddScreenInteractor()
        let router = AddScreenRouter()

        interactor.presenter = presenter

        presenter.interactor = interactor
        presenter.router = router
        presenter.view = view

        view.presenter = presenter
        router.presenter = presenter

        return view
    }

}
