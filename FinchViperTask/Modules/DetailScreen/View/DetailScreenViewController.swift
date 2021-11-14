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

    // MARK: - LifeCircle

    override func viewDidLoad() {
        super.viewDidLoad()
        presenter?.configureView()
        setupUI()
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
