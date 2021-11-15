//
//  DetailScreenDetailScreenViewController.swift
//  FinchViperTask
//
//  Created by Alex on 04/11/2021.
//  Copyright © 2021 AlexanderIvanov. All rights reserved.
//

import UIKit

final class DetailScreenViewController: UIViewController {

    // MARK: - Public Properties

    var presenter: DetailScreenViewOutput?

    var rootScrollView = UIScrollView()
    var contentView = UIView()
    var noteImageView = UIImageView()
    var titleLabel = UILabel()
    var descriptionTextView = UITextView()
    // MARK: - Private Properties
    private let themeProvider = Style.DarkStyle

    // MARK: - LifeCircle

    override func viewDidLoad() {
        super.viewDidLoad()
        presenter?.configureView()
        setupUI()
        setupTheme()
    }

    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        super.traitCollectionDidChange(previousTraitCollection)
        descriptionTextView.layer.borderColor = themeProvider.borderColor.cgColor
        titleLabel.layer.borderColor = themeProvider.borderColor.cgColor

    }

    func setupTheme() {
        view.backgroundColor = themeProvider.blackViewColor
        rootScrollView.backgroundColor = themeProvider.blackViewColor
        contentView.backgroundColor = themeProvider.blackViewColor
        titleLabel.backgroundColor = themeProvider.greyViewColor
        descriptionTextView.backgroundColor = themeProvider.greyViewColor
        descriptionTextView.textColor = themeProvider.label
        titleLabel.textColor = themeProvider.label
    }

}

// MARK: - DetailScreenViewInput
extension DetailScreenViewController: DetailScreenViewInput {
    func assignUIElements(to imageData: Data, and title: String, and description: String) {
        guard let image = UIImage(data: imageData) else {return}
        noteImageView.image = image
        titleLabel.text = title
        descriptionTextView.text = description
    }
}
