//
//  AddScreenAddScreenViewController.swift
//  FinchViperTask
//
//  Created by Alex on 04/11/2021.
//  Copyright © 2021 AlexanderIvanov. All rights reserved.
//

import UIKit
import SnapKit

final class AddScreenViewController: UIViewController {

    // MARK: - Public Properties

    var presenter: AddScreenViewOutput?

    // MARK: - Private Properties

    private var noteImageView = UIImageView()
    private var titleTextField = UITextField()
    private var descriptionTextView = UITextView()
    private let themeProvider = Style.DarkStyle
    private let mainScrollView = UIScrollView(frame: .zero)
    private let contentView = UIView()

    // MARK: - LifeCircle

    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        setupNoteImageView()
        setupTitleTF()
        setupTheme()
        setKeybordNotification()
        descriptionTextView.delegate = self
        setupTextView()
        setupNavigationBar()
        setupImageView()
    }

    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        super.traitCollectionDidChange(previousTraitCollection)
        descriptionTextView.layer.borderColor = themeProvider.borderColor.cgColor
        setNoteImageConstraints()
    }

    // MARK: - Private Methods

    // MARK: - SetupUI
    private func setupView() {
        view.addSubview(mainScrollView)

        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(backgroundTap))
        self.contentView.addGestureRecognizer(tapGestureRecognizer)

        mainScrollView.isScrollEnabled = true
        mainScrollView.snp.makeConstraints({ make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom)
            make.left.right.equalToSuperview()
        })

        mainScrollView.addSubview(contentView)
        contentView.snp.makeConstraints({ make in
            make.top.bottom.equalToSuperview()
            make.left.right.equalToSuperview()
            make.width.equalTo(view.snp.width)
            make.height.equalTo(getOriginalHeight()).priority(.low)
        })
        view.backgroundColor = themeProvider.blackViewColor

    }

    private func setupNoteImageView() {
        contentView.addSubview(noteImageView)
        noteImageView.image = UIImage(named: "NoImage")
        noteImageView.contentMode = .scaleAspectFill
        noteImageView.layer.cornerRadius = 8
        noteImageView.clipsToBounds = true
        setNoteImageConstraints()
    }

    private func setNoteImageConstraints() {
        guard let image = noteImageView.image else { return }
        let imageHeigth = image.size.height / UIScreen.main.scale
        let imageWidth = image.size.width / UIScreen.main.scale

        let aspectRatio = imageWidth/imageHeigth
        noteImageView.snp.removeConstraints()
        noteImageView.snp.makeConstraints({ make in
            make.top.equalToSuperview()
            make.centerX.equalToSuperview()
            make.width.equalTo(getOriginalWidth() - 32)
            make.height.equalTo(noteImageView.snp.width).multipliedBy(1/aspectRatio)
        })
    }

    private func getOriginalWidth() -> CGFloat {
        if UIScreen.main.bounds.width > UIScreen.main.bounds.height {
            return UIScreen.main.bounds.height
        } else {
            return UIScreen.main.bounds.width
        }
    }

    private func getOriginalHeight() -> CGFloat {
        if UIScreen.main.bounds.width < UIScreen.main.bounds.height {
            return UIScreen.main.bounds.height
        } else {
            return UIScreen.main.bounds.width
        }
    }

    private func setupTitleTF() {
        contentView.addSubview(titleTextField)
        titleTextField.font = UIFont.systemFont(ofSize: 14)
        titleTextField.borderStyle = .roundedRect
        titleTextField.layer.borderColor = themeProvider.borderColor.cgColor
        titleTextField.placeholder = "Ввести заголовок"
        titleTextField.snp.makeConstraints { make in
            make.top.equalTo(noteImageView.snp.bottom).offset(20)
            make.left.right.equalTo(contentView.safeAreaLayoutGuide).inset(10)
            make.height.equalTo(34)
        }
    }

    private func setupTextView() {
        contentView.addSubview(descriptionTextView)
        descriptionTextView.font = UIFont.systemFont(ofSize: 14)
        descriptionTextView.layer.borderWidth = 1
        descriptionTextView.layer.cornerRadius = 5
        descriptionTextView.text = "Ввести текст заметки"
        descriptionTextView.isScrollEnabled = false
        descriptionTextView.layer.borderColor = themeProvider.borderColor.cgColor
        descriptionTextView.snp.makeConstraints { make in
            make.left.right.equalTo(contentView.safeAreaLayoutGuide).inset(10)
            make.top.equalTo(titleTextField.snp.bottom).offset(10)
            make.height.greaterThanOrEqualTo(250)
        }
    }

    private func setupImageView() {
        noteImageView.isUserInteractionEnabled = true
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(addImage(sender:)))
        noteImageView.addGestureRecognizer(tapGesture)
    }

    @objc private func addImage(sender: UITapGestureRecognizer) {
        let imageVC = UIImagePickerController()
        imageVC.sourceType = .photoLibrary
        imageVC.delegate = self
        imageVC.allowsEditing = true
        present(imageVC, animated: true)
    }

    @objc private func backgroundTap(_ sender: UITapGestureRecognizer) {
        self.view.endEditing(true)
    }

    private func setupNavigationBar() {
        navigationItem.rightBarButtonItem = UIBarButtonItem(
            barButtonSystemItem: .save,
            target: self,
            action: #selector(saveAndGoBack(sender:)))
    }

    @objc private func saveAndGoBack(sender: UIBarButtonItem) {
        if titleTextField.text != "" &&
            descriptionTextView.text != "Ввести текст заметки" {

            guard let image = noteImageView.image else { return }
            guard let imageData = UIImage.pngData(image)() else { return }
            presenter?.saveNote(imageNote: imageData,
                                titleNote: titleTextField.text!,
                                descriptionNote: descriptionTextView.text)
            presenter?.goToPreviosViewController()
        } else {
            presenter?.showErrorEmtyFields()
        }
    }

    private func setupTheme() {
        titleTextField.backgroundColor = themeProvider.greyViewColor
        descriptionTextView.backgroundColor = themeProvider.greyViewColor
        descriptionTextView.textColor = themeProvider.placeHolderColor
    }

    // MARK: - SetKeybordNotification
    private func setKeybordNotification() {
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(keyboardWillShowHide(sender:)),
            name: UIResponder.keyboardDidShowNotification, object: nil)

        NotificationCenter.default.addObserver(
            self,
            selector: #selector(keyboardWillShowHide(sender:)),
            name: UIResponder.keyboardWillHideNotification, object: nil)
    }

    @objc private func keyboardWillShowHide(sender: Notification) {

        let userInfo = sender.userInfo
        let keyBoardRect = (userInfo![UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)!.cgRectValue

        switch sender.name {
        case UIResponder.keyboardDidShowNotification:
            let contentInsets = UIEdgeInsets(top: 0.0, left: 0.0, bottom: keyBoardRect.height + 30, right: 0.0)
            mainScrollView.contentInset = contentInsets
            mainScrollView.scrollIndicatorInsets = contentInsets
        case  UIResponder.keyboardWillHideNotification:
            let contentInsets = UIEdgeInsets(top: 0.0, left: 0.0, bottom: 0.0, right: 0.0)
            mainScrollView.contentInset = contentInsets
            mainScrollView.scrollIndicatorInsets = contentInsets
        default:
            break
        }
    }

    deinit {
        NotificationCenter.default.removeObserver(
            self,
            name: UIResponder.keyboardDidShowNotification,
            object: nil)
        NotificationCenter.default.removeObserver(
            self,
            name: UIResponder.keyboardWillHideNotification,
            object: nil)
    }
}

// MARK: - AddScreenViewInput
extension AddScreenViewController: AddScreenViewInput {
    func showErrorEmtyText() {
        let alertController = UIAlertController(
            title: "Ошибка",
            message: "Заполните все поля",
            preferredStyle: .alert)

        let action = UIAlertAction(
            title: "Ok",
            style: .default,
            handler: nil)
        alertController.addAction(action)
        self.present(alertController, animated: true, completion: nil)
    }
}

// MARK: - UITextViewDelegate
extension AddScreenViewController: UITextViewDelegate {

    func textViewDidBeginEditing(_ textView: UITextView) {
        if descriptionTextView.textColor == themeProvider.placeHolderColor {
            descriptionTextView.text = nil
            descriptionTextView.textColor = themeProvider.label
        }

        let scrollPoint: CGPoint = CGPoint.init(x: 0, y: textView.frame.origin.y/2)
        self.mainScrollView.setContentOffset(scrollPoint, animated: true)
    }

    func textViewDidEndEditing(_ textView: UITextView) {
        if descriptionTextView.text.isEmpty {
            descriptionTextView.text = "Ввести текст заметки"
            descriptionTextView.textColor = themeProvider.placeHolderColor
        }

        self.mainScrollView.setContentOffset(CGPoint.zero, animated: true)
    }
}

// MARK: - UIImagePickerControllerDelegate, UINavigationControllerDelegate
extension AddScreenViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController,
                               didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey: Any]) {

        if let image = info[UIImagePickerController.InfoKey(
            rawValue: "UIImagePickerControllerEditedImage")] as? UIImage {
            noteImageView.image = image
            setNoteImageConstraints()

        }
        picker.dismiss(animated: true, completion: nil)
    }

    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }
}
