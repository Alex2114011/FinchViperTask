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
    }

    // MARK: - Private Methods

    // MARK: - SetupUI
    private func setupView() {
        view.backgroundColor = themeProvider.blackViewColor
    }

    private func setupNoteImageView() {
        view.addSubview(noteImageView)
        noteImageView.image = UIImage(named: "NoImage")
        noteImageView.contentMode = .scaleAspectFit
        noteImageView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            make.centerX.equalToSuperview()
            make.width.equalTo(view.safeAreaLayoutGuide.snp.width).multipliedBy(0.9)
            make.height.equalToSuperview().multipliedBy(0.3)
        }
    }

    private func setupTitleTF() {
        view.addSubview(titleTextField)
        titleTextField.font = UIFont.systemFont(ofSize: 14)
        titleTextField.borderStyle = .roundedRect
        titleTextField.layer.borderColor = themeProvider.borderColor.cgColor
        titleTextField.placeholder = "Ввести заголовок"
        titleTextField.snp.makeConstraints { make in
            make.top.equalTo(noteImageView.snp.bottom).offset(20)
            make.left.right.equalTo(view.safeAreaLayoutGuide).inset(10)
            make.height.equalTo(34)
        }
    }

    private func setupTextView() {
        view.addSubview(descriptionTextView)
        descriptionTextView.font = UIFont.systemFont(ofSize: 14)
        descriptionTextView.layer.borderWidth = 1
        descriptionTextView.layer.cornerRadius = 5
        descriptionTextView.text = "Ввести текст заметки"
        descriptionTextView.layer.borderColor = themeProvider.borderColor.cgColor
        descriptionTextView.snp.makeConstraints { make in
            make.left.right.equalTo(view.safeAreaLayoutGuide).inset(10)
            make.top.equalTo(titleTextField.snp.bottom).offset(10)
            make.bottom.equalTo(view.safeAreaLayoutGuide).inset(10)
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
            let keyboardFrame = view.convert(keyBoardRect, to: view.window)

            let bottomOfTextField = titleTextField.convert(titleTextField.bounds, to: self.view).maxY
            let topOfKeyboard = self.view.frame.height - keyBoardRect.height

            if bottomOfTextField > topOfKeyboard {
                self.view.frame.origin.y = -noteImageView.frame.height
            }

            if UIWindow.isLandscape {
                descriptionTextView.contentInset = UIEdgeInsets(
                    top: 0,
                    left: 0,
                    bottom: (
                        keyboardFrame.height - noteImageView.frame.height),
                    right: 0)
                descriptionTextView.scrollIndicatorInsets = descriptionTextView.contentInset
                descriptionTextView.scrollRangeToVisible(descriptionTextView.selectedRange)
            } else {
                descriptionTextView.contentInset = UIEdgeInsets(
                    top: 0,
                    left: 0,
                    bottom: keyboardFrame.height,
                    right: 0)

                descriptionTextView.scrollIndicatorInsets = descriptionTextView.contentInset
                descriptionTextView.scrollRangeToVisible(descriptionTextView.selectedRange)
            }

        if sender.name == UIResponder.keyboardWillHideNotification {
            descriptionTextView.contentInset = UIEdgeInsets.zero
            self.view.frame.origin.y = 0
        }
    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        titleTextField.resignFirstResponder()
        descriptionTextView.resignFirstResponder()
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
    }

    func textViewDidEndEditing(_ textView: UITextView) {
        if descriptionTextView.text.isEmpty {
            descriptionTextView.text = "Ввести текст заметки"
            descriptionTextView.textColor = themeProvider.placeHolderColor
        }
    }
}

// MARK: - UIImagePickerControllerDelegate, UINavigationControllerDelegate
extension AddScreenViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController,
                               didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey: Any]) {

        if let image = info[UIImagePickerController.InfoKey(
            rawValue: "UIImagePickerControllerEditedImage")] as? UIImage {
            noteImageView.image = image.withRoundedCorners(radius: 50)
        }
        picker.dismiss(animated: true, completion: nil)
    }

    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }
}
