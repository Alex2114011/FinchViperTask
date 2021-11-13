//
//  ListScreenListScreenRouterInput.swift
//  FinchViperTask
//
//  Created by Alex on 04/11/2021.
//  Copyright © 2021 AlexanderIvanov. All rights reserved.
//

import Foundation

protocol ListScreenRouterInput: AnyObject {
    func routToAddScreenModule(delegate: AddScreenDelegateProtocol?)
    func routToDetailModule(with note: Note)
}
