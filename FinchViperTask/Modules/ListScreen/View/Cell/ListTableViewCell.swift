import UIKit

class ListTableViewCell: UITableViewCell {

    private var noteImageView = UIImageView()
    private var titleLabel = UILabel()
    private var descriptionLabel = UILabel()
    private var cellContentView = UIView()
    private let themeProvider = ThemeProvider.DarkStyle.self

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
        setupTheme()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupUI() {
        contentView.addSubview(cellContentView)
        cellContentView.snp.makeConstraints { make in
            make.centerY.equalTo(contentView.snp.centerY)
            make.left.right.equalToSuperview().inset(4)
            make.height.equalTo(60)
        }

        cellContentView.addSubview(noteImageView)
        noteImageView.layer.cornerRadius = 8
        noteImageView.clipsToBounds = true
        noteImageView.contentMode = .scaleAspectFit

        cellContentView.addSubview(titleLabel)
        titleLabel.font = UIFont.systemFont(ofSize: 18)
        titleLabel.snp.makeConstraints { make in
            make.left.equalTo(noteImageView.snp.right).offset(5)
            make.right.equalToSuperview().inset(5)
            make.top.equalTo(noteImageView.snp.top)
            make.height.equalTo(noteImageView.snp.height).multipliedBy(0.5)
        }

        cellContentView.addSubview(descriptionLabel)
        descriptionLabel.font = UIFont.systemFont(ofSize: 15)
        descriptionLabel.snp.makeConstraints { make in
            make.left.equalTo(noteImageView.snp.right).offset(5)
            make.right.equalToSuperview().inset(5)
            make.top.equalTo(titleLabel.snp.bottom)
            make.height.equalTo(noteImageView.snp.height).multipliedBy(0.5)
        }
    }

    func updateUI(width note: Note) {
        guard let imageData = note.imageNote else { return }
        noteImageView.image = UIImage(data: imageData)
        guard let image = noteImageView.image else { return }
        let aspectR = image.size.height/image.size.width
        noteImageView.snp.remakeConstraints { make in
            make.top.left.bottom.equalToSuperview().inset(4)
            make.width.equalTo(self.noteImageView.snp.height).multipliedBy(1/aspectR)
        }
        self.titleLabel.text = note.titleNote
        self.descriptionLabel.text = note.descriptionNote
    }

    private func setupTheme() {
        cellContentView.backgroundColor = themeProvider.greyViewColor
    }
}
