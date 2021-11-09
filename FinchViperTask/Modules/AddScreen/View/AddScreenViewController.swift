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

    // MARK: - LifeCircle

    override func viewDidLoad() {
        super.viewDidLoad()
        setupNotify()
        descriptionTextView.delegate = self
        setupTextView()
        setupNavigationBar()
        setupImageView()
    }

    // MARK: - Private Methods
    private func setupNotify() {
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(updateTextView(sender:)),
                                               name: UIResponder.keyboardDidShowNotification, object: nil)

        NotificationCenter.default.addObserver(self,
                                               selector: #selector(updateTextView(sender:)),
                                               name: UIResponder.keyboardWillHideNotification, object: nil)
    }

    @objc private func updateTextView(sender: Notification) {
        let userInfo = sender.userInfo
        let keyBoardRect = (userInfo![UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)!.cgRectValue
        let keyboardFrame = view.convert(keyBoardRect, to: view.window)

        if sender.name == UIResponder.keyboardWillHideNotification {
            descriptionTextView.contentInset = UIEdgeInsets.zero
        } else {
            descriptionTextView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: keyboardFrame.height, right: 0)
            descriptionTextView.scrollIndicatorInsets = descriptionTextView.contentInset
        }
        descriptionTextView.scrollRangeToVisible(descriptionTextView.selectedRange)
    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        titleTextField.resignFirstResponder()
        descriptionTextView.resignFirstResponder()
    }

    private func setupTextView() {
        descriptionTextView.layer.borderWidth = 1
        descriptionTextView.layer.borderColor = #colorLiteral(red: 0.9137255549, green: 0.9137255549, blue: 0.9137255549, alpha: 1)
        descriptionTextView.layer.cornerRadius = 5
        descriptionTextView.text = "Ввести текст заметки"
        descriptionTextView.textColor = .lightGray
    }

    private func setupNavigationBar() {
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .save,
                                                            target: self,
                                                            action: #selector(saveAndGoBack(sender:)))
    }

    @objc private func saveAndGoBack(sender: UIBarButtonItem) {
        if titleTextField.text != "" && descriptionTextView.text != "Ввести текст заметки" {
            print("go to main")
        } else {
            showErrorEmtyText()
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

    private func showErrorEmtyText() {
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

// MARK: - AddScreenViewInput
extension AddScreenViewController: AddScreenViewInput {

}

// MARK: - UITextViewDelegate
extension AddScreenViewController: UITextViewDelegate {

    func textViewDidBeginEditing(_ textView: UITextView) {
        if descriptionTextView.textColor == UIColor.lightGray {
            descriptionTextView.text = nil
            descriptionTextView.textColor = .black
        }
    }

    func textViewDidEndEditing(_ textView: UITextView) {
        if descriptionTextView.text.isEmpty {
            descriptionTextView.text = "Ввести текст заметки"
            descriptionTextView.textColor = .lightGray
        }
    }
}
// MARK: - UIImagePickerControllerDelegate, UINavigationControllerDelegate
extension AddScreenViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController,
                               didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey: Any]) {
    if let image = info[UIImagePickerController.InfoKey(rawValue: "UIImagePickerControllerEditedImage")] as? UIImage {
            noteImageView.image = image
        }
        picker.dismiss(animated: true, completion: nil)
    }
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }
}
