//
//  DetailScreenDetailScreenViewInput.swift
//  FinchViperTask
//
//  Created by Alex on 04/11/2021.
//  Copyright © 2021 AlexanderIvanov. All rights reserved.
//

import UIKit

protocol DetailScreenViewInput: AnyObject {
    func assignUIElements(to imageData: Data, and title: String, and description: String )
}
