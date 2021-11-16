//
//  AddScreenAddScreenViewController.swift
//  FinchViperTask
//
//  Created by Alex on 04/11/2021.
//  Copyright © 2021 AlexanderIvanov. All rights reserved.
//

import UIKit

final class AddScreenViewController: UIViewController {

    // MARK: - Public Properties

    var presenter: AddScreenViewOutput?
    
    // MARK: - Private Properties

    @IBOutlet private weak var noteImageView: UIImageView!
    @IBOutlet private weak var titleTextField: UITextField!
    @IBOutlet private weak var descriptionTextView: UITextView!
    private let themeProvider = Style.DarkStyle

    // MARK: - LifeCircle

    override func viewDidLoad() {
        super.viewDidLoad()
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

    func setupTheme() {
        titleTextField.backgroundColor = themeProvider.greyViewColor
        descriptionTextView.backgroundColor = themeProvider.greyViewColor
        descriptionTextView.textColor = themeProvider.placeHolderColor
    }
    private func setKeybordNotification() {
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(keyboardWillShowHide(sender:)),
                                               name: UIResponder.keyboardDidShowNotification, object: nil)

        NotificationCenter.default.addObserver(self,
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

        if sender.name == UIResponder.keyboardWillHideNotification {
            descriptionTextView.contentInset = UIEdgeInsets.zero
            self.view.frame.origin.y = 0

        } else if UIWindow.isLandscape {
            descriptionTextView.contentInset = UIEdgeInsets(top: 0,
                                                            left: 0,
                                                            bottom: (keyboardFrame.height - noteImageView.frame.height),
                                                            right: 0)
            descriptionTextView.scrollIndicatorInsets = descriptionTextView.contentInset
            descriptionTextView.scrollRangeToVisible(descriptionTextView.selectedRange)
        } else {
            descriptionTextView.contentInset = UIEdgeInsets(top: 0,
                                                            left: 0,
                                                            bottom: keyboardFrame.height,
                                                            right: 0)

            descriptionTextView.scrollIndicatorInsets = descriptionTextView.contentInset
            descriptionTextView.scrollRangeToVisible(descriptionTextView.selectedRange)
        }
    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        titleTextField.resignFirstResponder()
        descriptionTextView.resignFirstResponder()
    }

    private func setupTextView() {
        descriptionTextView.layer.borderWidth = 1
        descriptionTextView.layer.cornerRadius = 5
        descriptionTextView.text = "Ввести текст заметки"
        descriptionTextView.layer.borderColor = themeProvider.borderColor.cgColor
    }

    private func setupNavigationBar() {
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .save,
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

    private func setupImageView() {
        noteImageView.isUserInteractionEnabled = true
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(addImage(sender:)))
        noteImageView.addGestureRecognizer(tapGesture)
    }

    @objc func addImage(sender: UITapGestureRecognizer) {
        let imageVC = UIImagePickerController()
        imageVC.sourceType = .photoLibrary
        imageVC.delegate = self
        imageVC.allowsEditing = true
        present(imageVC, animated: true)
    }
}

// MARK: - AddScreenViewInput
extension AddScreenViewController: AddScreenViewInput {
    func showErrorEmtyText() {
        let alertController = UIAlertController(title: "Ошибка",
                                                message: "Заполните все поля",
                                                preferredStyle: .alert)
        let action = UIAlertAction(title: "Ok",
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
        // swiftlint:disable line_length
        if let image = info[UIImagePickerController.InfoKey(rawValue: "UIImagePickerControllerEditedImage")] as? UIImage {
            noteImageView.image = image
        }
        picker.dismiss(animated: true, completion: nil)
    }
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }
}
