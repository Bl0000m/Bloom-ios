import UIKit

class FloristCell: UITableViewCell {

    static let floristsID = "floristsID"
    
    var selectFlorist: (() -> Void)?
    
    private let stackView = UIStackView(
        axis: .horizontal,
        distribution: .fill,
        alignment: .leading,
        spacing: 5
    )
    private let companyName = UILabel(text: "", font: 16, textColor: .black)
    private let bouquetPrice = UILabel(text: "", font: 16, textColor: .black)
    private lazy var selectButton = UIButton(title: "выбрать")
    private let starImg: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(named: "star")
        image.contentMode = .scaleAspectFill
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    private let ratingLabel = UILabel(text: "4.7", font: 12, textColor: .black)
    private lazy var feedbackButton = UIButton(text: "отзывы (\(12))", textColor: .black, font: 12)
    private let seperatorLine = UIView(backgroundColor: .black)
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupViews()
        setupLayout()
        setupActions()
        setupBtn()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupViews() {
        [starImg, ratingLabel].forEach { stackView.addArrangedSubview($0) }
        [companyName, selectButton, stackView, feedbackButton, seperatorLine, bouquetPrice].forEach { contentView.addSubview($0) }
    }
    
    private func setupLayout() {
        NSLayoutConstraint.activate([
            companyName.topAnchor.constraint(equalTo: topAnchor, constant: 5),
            companyName.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 21)
        ])
        
        NSLayoutConstraint.activate([
            selectButton.topAnchor.constraint(equalTo: topAnchor, constant: 10),
            selectButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -21),
            selectButton.heightAnchor.constraint(equalToConstant: 26),
            selectButton.widthAnchor.constraint(equalToConstant: 67)
        ])
        
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: companyName.bottomAnchor, constant: 11),
            stackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 21),
            stackView.widthAnchor.constraint(equalToConstant: 40),
            stackView.heightAnchor.constraint(equalToConstant: 14)
        ])
        
        NSLayoutConstraint.activate([
            feedbackButton.topAnchor.constraint(equalTo: companyName.bottomAnchor, constant: 11),
            feedbackButton.leadingAnchor.constraint(equalTo: stackView.trailingAnchor, constant: 5),
            feedbackButton.heightAnchor.constraint(equalToConstant: 14),
            feedbackButton.widthAnchor.constraint(equalToConstant: 69)
        ])
        
        NSLayoutConstraint.activate([
            seperatorLine.topAnchor.constraint(equalTo: feedbackButton.bottomAnchor, constant: 1),
            seperatorLine.leadingAnchor.constraint(equalTo: stackView.trailingAnchor, constant: 5),
            seperatorLine.widthAnchor.constraint(equalToConstant: 69),
            seperatorLine.heightAnchor.constraint(equalToConstant: 0.5)
        ])
        
        NSLayoutConstraint.activate([
            bouquetPrice.topAnchor.constraint(equalTo: stackView.bottomAnchor, constant: 10),
            bouquetPrice.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 21),
            bouquetPrice.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -10)
        ])
    }
    
    private func setupBtn() {
        selectButton.backgroundColor = .black
        selectButton.setTitleColor(.white, for: .normal)
        selectButton.isUserInteractionEnabled = true
    }
    
    private func setupActions() {
        selectButton.addTarget(self, action: #selector(selectedFlorist), for: .touchUpInside)
    }
    
    @objc private func selectedFlorist() {
        print("OK")
        selectFlorist?()
    }
    
    func configure(model: BranchBouquetInfo) {
        companyName.text = model.divisionType
        bouquetPrice.text = "\(model.price) BLM"
    }

}
