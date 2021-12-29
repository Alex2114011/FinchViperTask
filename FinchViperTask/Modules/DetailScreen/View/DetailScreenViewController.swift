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

    // MARK: - Private Properties

    private let themeProvider = Style.DarkStyle

    private var rootScrollView = UIScrollView()
    private var contentView = UIView()
    private var noteImageView = UIImageView()
    private var titleLabel = UILabel()
    private var descriptionTextView = UITextView()

    // MARK: - LifeCircle

    override func viewDidLoad() {
        super.viewDidLoad()
        presenter?.configureView()
        setupUI()
        setupTheme()
    }

    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        setupTitleLabel()
        setupTextView()
    }

    // MARK: - AppEnvirement

    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        super.traitCollectionDidChange(previousTraitCollection)
        descriptionTextView.layer.borderColor = themeProvider.borderColor.cgColor
        titleLabel.layer.borderColor = themeProvider.borderColor.cgColor
    }

    // MARK: - SetupDarkTheme

   private func setupTheme() {
        view.backgroundColor = themeProvider.blackViewColor
        rootScrollView.backgroundColor = themeProvider.blackViewColor
        contentView.backgroundColor = themeProvider.blackViewColor
        titleLabel.backgroundColor = themeProvider.greyViewColor
        descriptionTextView.backgroundColor = themeProvider.greyViewColor
        descriptionTextView.textColor = themeProvider.label
        titleLabel.textColor = themeProvider.label
        descriptionTextView.layer.borderColor = themeProvider.borderColor.cgColor
        titleLabel.layer.borderColor = themeProvider.borderColor.cgColor
    }

    // MARK: - SetupUI
    private func setupUI() {
        setupScrollView()
        setupNoteImage()
        setupTitleLabel()
        setupTextView()
    }

    private func setupScrollView() {
        rootScrollView.translatesAutoresizingMaskIntoConstraints = false
        contentView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(rootScrollView)
        rootScrollView.addSubview(contentView)
        let guide = view.safeAreaLayoutGuide
        NSLayoutConstraint.activate([rootScrollView.topAnchor.constraint(equalTo: guide.topAnchor),
                                     rootScrollView.leftAnchor.constraint(equalTo: guide.leftAnchor),
                                     rootScrollView.rightAnchor.constraint(equalTo: guide.rightAnchor),
                                     rootScrollView.bottomAnchor.constraint(equalTo: guide.bottomAnchor),

                                     contentView.topAnchor.constraint(equalTo: rootScrollView.topAnchor),
                                     contentView.leftAnchor.constraint(equalTo: rootScrollView.leftAnchor),
                                     contentView.rightAnchor.constraint(equalTo: rootScrollView.rightAnchor),
                                     contentView.bottomAnchor.constraint(equalTo: rootScrollView.bottomAnchor),
                                     contentView.widthAnchor.constraint(equalTo: rootScrollView.widthAnchor)])
    }

    private func setupNoteImage() {
        noteImageView.layer.cornerRadius = 8
        noteImageView.clipsToBounds = true
        guard let image = noteImageView.image else { return }
        let aspectR = image.size.width / image.size.height
        noteImageView.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(noteImageView)

        NSLayoutConstraint.activate([noteImageView.topAnchor.constraint(equalTo: contentView.topAnchor,
                                                                        constant: 20),
                                     noteImageView.leftAnchor.constraint(equalTo: contentView.leftAnchor,
                                                                         constant: 50),
                                     noteImageView.rightAnchor.constraint(equalTo: contentView.rightAnchor,
                                                                          constant: -50),
                                     noteImageView.heightAnchor.constraint(equalTo: noteImageView.widthAnchor,
                                                                           multiplier: 1/aspectR)])
    }

    private func setupTitleLabel() {
        titleLabel.numberOfLines = 0
        titleLabel.layer.borderWidth = 1
        titleLabel.layer.cornerRadius = 5
        titleLabel.clipsToBounds = true
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(titleLabel)

        NSLayoutConstraint.activate([titleLabel.topAnchor.constraint(equalTo: noteImageView.bottomAnchor,
                                                                     constant: 20),
                                     titleLabel.leftAnchor.constraint(equalTo: contentView.leftAnchor,
                                                                      constant: 10),
                                     titleLabel.rightAnchor.constraint(equalTo: contentView.rightAnchor,
                                                                       constant: -10),
                                     titleLabel.heightAnchor.constraint(equalToConstant: 34)])
    }

    private func setupTextView() {
        descriptionTextView.isScrollEnabled = false
        descriptionTextView.isEditable = false
        descriptionTextView.isSelectable = true
        descriptionTextView.font = UIFont.systemFont(ofSize: 14)
        descriptionTextView.layer.borderWidth = 1
        descriptionTextView.layer.cornerRadius = 5
        descriptionTextView.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(descriptionTextView)

        NSLayoutConstraint.activate([descriptionTextView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor,
                                                                              constant: 20),
                                     descriptionTextView.leftAnchor.constraint(equalTo: contentView.leftAnchor,
                                                                               constant: 10),
                                     descriptionTextView.rightAnchor.constraint(equalTo: contentView.rightAnchor,
                                                                                constant: -10),
                                     descriptionTextView.heightAnchor.constraint(greaterThanOrEqualToConstant: 250),
                                     descriptionTextView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)])

        let height =  contentView.heightAnchor.constraint(equalTo: rootScrollView.heightAnchor,
                                                          multiplier: 1,
                                                          constant: -10)
        height.priority = .defaultLow
        height.isActive = true
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
