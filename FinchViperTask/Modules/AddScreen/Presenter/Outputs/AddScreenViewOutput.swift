//
//  AddScreenAddScreenViewOutput.swift
//  FinchViperTask
//
//  Created by Alex on 04/11/2021.
//  Copyright © 2021 AlexanderIvanov. All rights reserved.
//
 import Foundation

 protocol AddScreenViewOutput: AnyObject {
    func saveNote(imageNote: Data, titleNote: String, descriptionNote: String)
    func goToPreviosViewController()
    func showErrorEmtyFields()
 }
