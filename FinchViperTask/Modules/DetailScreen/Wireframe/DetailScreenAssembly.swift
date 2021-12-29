//
//  DetailScreenDetailScreenAssembly.swift
//  FinchViperTask
//
//  Created by Alex on 04/11/2021.
//  Copyright © 2021 AlexanderIvanov. All rights reserved.
//

 import UIKit

 final class DetailScreenAssembly {

    class func assembleModule(with note: Note) -> UIViewController {

        let view = DetailScreenViewController()
        let presenter = DetailScreenPresenter()

        presenter.view = view
        presenter.note = note

        view.presenter = presenter

        return view
    }

 }
