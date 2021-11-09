//
//  ListTableViewCell.swift
//  FinchViperTask
//
//  Created by Alex on 04.11.2021.
//

import UIKit

class ListTableViewCell: UITableViewCell {

    @IBOutlet weak var noteImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!

    func updateUI(width note: Note) {
        self.noteImageView.image = UIImage(data: note.imageNote)
        self.titleLabel.text = note.titleNote
        self.descriptionLabel.text = note.descriptionNote
    }
}
