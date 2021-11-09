//
//  ListScreenListScreenViewOutput.swift
//  FinchViperTask
//
//  Created by Alex on 04/11/2021.
//  Copyright © 2021 AlexanderIvanov. All rights reserved.
//

protocol ListScreenViewOutput: AnyObject {
    var notes: [Note]? {get set}
    func addNoteScreen()
}
