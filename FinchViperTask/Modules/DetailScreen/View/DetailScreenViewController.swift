//
//  DetailScreenDetailScreenViewController.swift
//  FinchViperTask
//
//  Created by Alex on 04/11/2021.
//  Copyright © 2021 AlexanderIvanov. All rights reserved.
//

 import UIKit
 import SnapKit
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

        rootScrollView.snp.makeConstraints { make in
            make.edges.equalTo(view.safeAreaLayoutGuide)
        }

        contentView.snp.makeConstraints { make in
            make.edges.equalTo(rootScrollView)
            make.width.equalTo(rootScrollView)
        }
    }

    private func setupNoteImage() {
        noteImageView.layer.cornerRadius = 8
        noteImageView.clipsToBounds = true
        guard let image = noteImageView.image else { return }
        let aspectR = image.size.width / image.size.height
        contentView.addSubview(noteImageView)

        noteImageView.snp.makeConstraints { make in
            make.top.equalTo(contentView).inset(20)
            make.left.right.equalTo(contentView).inset(50)
            make.height.equalTo(noteImageView.snp.width).multipliedBy(1/aspectR)
        }
    }

    private func setupTitleLabel() {
        titleLabel.numberOfLines = 0
        titleLabel.layer.borderWidth = 1
        titleLabel.layer.cornerRadius = 5
        titleLabel.clipsToBounds = true
        contentView.addSubview(titleLabel)

        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(noteImageView.snp.bottom).offset(20)
            make.left.rightMargin.equalTo(contentView).inset(10)
            make.height.equalTo(34)
        }
    }

    private func setupTextView() {
        descriptionTextView.isScrollEnabled = false
        descriptionTextView.isEditable = false
        descriptionTextView.isSelectable = true
        descriptionTextView.font = UIFont.systemFont(ofSize: 14)
        descriptionTextView.layer.borderWidth = 1
        descriptionTextView.layer.cornerRadius = 5
        contentView.addSubview(descriptionTextView)

        descriptionTextView.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(20)
            make.left.right.equalTo(contentView).inset(10)
            make.height.greaterThanOrEqualTo(250).offset(10).priority(.low)
            make.bottom.equalTo(contentView)
        }
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
