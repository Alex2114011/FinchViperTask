//
//  ListScreenListScreenViewController.swift
//  FinchViperTask
//
//  Created by Alex on 04/11/2021.
//  Copyright © 2021 AlexanderIvanov. All rights reserved.
//

import UIKit

final class ListScreenViewController: UIViewController {

    // MARK: - Public Properties

    var presenter: ListScreenViewOutput?

    // MARK: - Private Properties

    // MARK: - LifeCircle

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .blue
    }

    // MARK: - Private Methods

}

// MARK: - ListScreenViewInput
extension ListScreenViewController: ListScreenViewInput {

}
