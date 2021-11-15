//
//  ListTableViewCell.swift
//  FinchViperTask
//
//  Created by Alex on 04.11.2021.
//

import UIKit

class ListTableViewCell: UITableViewCell {

    @IBOutlet private weak var noteImageView: UIImageView!
    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var descriptionLabel: UILabel!
    @IBOutlet private weak var cellContentView: UIView!
    @IBOutlet private weak var cellMainStackView: UIStackView!
    private let themeProvider = ThemeProvider.DarkStyle.self

    func updateUI(width note: Note) {
        self.noteImageView.image = UIImage(data: note.imageNote)
        self.titleLabel.text = note.titleNote
        self.descriptionLabel.text = note.descriptionNote
        setupTheme()
    }

   private func setupTheme() {
        cellContentView.backgroundColor = themeProvider.blackViewColor
        cellMainStackView.backgroundColor = themeProvider.greyViewColor
    }
}
