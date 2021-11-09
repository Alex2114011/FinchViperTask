//
//  ListScreenListScreenAssembly.swift
//  FinchViperTask
//
//  Created by Alex on 04/11/2021.
//  Copyright © 2021 AlexanderIvanov. All rights reserved.
//

import UIKit

final class ListScreenAssembly {

    class func assembleModule() -> UIViewController {

        let view = ListScreenViewController()
        let presenter = ListScreenPresenter()
        let interactor = ListScreenInteractor()
        let router = ListScreenRouter(viewController: view)

        interactor.presenter = presenter

        presenter.interactor = interactor
        presenter.router = router
        presenter.view = view

        view.presenter = presenter
        router.presenter = presenter

        return view
    }

}
