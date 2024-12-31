import UIKit

class VerifyProfileCell: UITableViewCell {

    static let verifyProfileID = "verifyProfileID"
    
    private let profileImage: UIImageView = {
        let image = UIImageView()
        image.contentMode = .scaleAspectFit
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    private let profileTitle = UILabel(text: "", font: 12, textColor: .black)
    
    private let expandIcon: UIImageView = {
        let image = UIImageView()
        image.contentMode = .scaleAspectFit
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    private let seperator = UIView(backgroundColor: .lightGray)
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupViews()
        setupLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupViews() {
        [profileImage, profileTitle, expandIcon, seperator].forEach { addSubview($0) }
    }
    
    private func setupLayout() {
        NSLayoutConstraint.activate([
            profileImage.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 21),
            profileImage.centerYAnchor.constraint(equalTo: centerYAnchor),
            profileImage.widthAnchor.constraint(equalToConstant: 24),
            profileImage.heightAnchor.constraint(equalToConstant: 24)
        ])
        
        NSLayoutConstraint.activate([
            profileTitle.leadingAnchor.constraint(equalTo: profileImage.trailingAnchor, constant: 17),
            profileTitle.centerYAnchor.constraint(equalTo: centerYAnchor)
        ])
        
        NSLayoutConstraint.activate([
            expandIcon.leadingAnchor.constraint(equalTo: profileTitle.trailingAnchor, constant: 63),
            expandIcon.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -21),
            expandIcon.heightAnchor.constraint(equalToConstant: 24),
            expandIcon.widthAnchor.constraint(equalToConstant: 24),
            expandIcon.centerYAnchor.constraint(equalTo: centerYAnchor)
        ])
        
        NSLayoutConstraint.activate([
            seperator.bottomAnchor.constraint(equalTo: bottomAnchor),
            seperator.leadingAnchor.constraint(equalTo: leadingAnchor),
            seperator.trailingAnchor.constraint(equalTo: trailingAnchor),
            seperator.heightAnchor.constraint(equalToConstant: 1)
        ])
    }
    
    func configure(for model: VerifyProfileLocal) {
        profileImage.image = UIImage(named: model.profileCategoryImage)
        profileTitle.text = model.profileCategoryTitle
        expandIcon.image = UIImage(named: model.profileExpandImage)
    }
}
