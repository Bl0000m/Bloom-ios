import UIKit

class EditOrderDetailsCustom: UIView {

    private let bouquetView: UIView = {
        let view = UIView()
        view.layer.borderColor = UIColor.black.cgColor
        view.layer.borderWidth = 0.5
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    private let bouquetInfoStack = UIStackView(
        axis: .vertical,
        distribution: .fillEqually,
        alignment: .leading,
        spacing: 15
    )
    private let bouquetImage: UIImageView = {
        let image = UIImageView()
        image.contentMode = .scaleToFill
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    private lazy var switchButton = UIButton(btnImage: "closeButton")
    private let orderCodeLabel = UILabel(text: "", font: 12, textColor: .black)
    private let bouquetNameLabel = UILabel(text: "", font: 12, textColor: .black)
    private let floristCompanyName = UILabel(text: "", font: 12, textColor: .black)
    private let bouquetPriceLabel = UILabel(text: "", font: 12, textColor: .black)
    private let bouquetOrderStatus = UILabel(text: "", font: 12, textColor: .black)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
        setupLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupViews() {
        addSubview(bouquetView)
        [orderCodeLabel, bouquetNameLabel, floristCompanyName, bouquetPriceLabel, bouquetOrderStatus].forEach { bouquetInfoStack.addArrangedSubview($0) }
        [bouquetImage, switchButton, bouquetInfoStack].forEach { addSubview($0) }
    }
    
    private func setupLayout() {
        NSLayoutConstraint.activate([
            bouquetView.topAnchor.constraint(equalTo: topAnchor),
            bouquetView.leadingAnchor.constraint(equalTo: leadingAnchor),
            bouquetView.trailingAnchor.constraint(equalTo: trailingAnchor),
            bouquetView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
        
        NSLayoutConstraint.activate([
            bouquetImage.topAnchor.constraint(equalTo: bouquetView.topAnchor, constant: 1),
            bouquetImage.leadingAnchor.constraint(equalTo: bouquetView.leadingAnchor),
            bouquetImage.bottomAnchor.constraint(equalTo: bouquetView.bottomAnchor, constant: -1),
            bouquetImage.widthAnchor.constraint(equalToConstant: 194)
        ])
        
        NSLayoutConstraint.activate([
            switchButton.topAnchor.constraint(equalTo: bouquetView.topAnchor, constant: 15),
            switchButton.trailingAnchor.constraint(equalTo: bouquetView.trailingAnchor, constant: -13),
            switchButton.heightAnchor.constraint(equalToConstant: 24),
            switchButton.widthAnchor.constraint(equalToConstant: 24)
        ])
        
        NSLayoutConstraint.activate([
            bouquetInfoStack.topAnchor.constraint(equalTo: switchButton.bottomAnchor, constant: 15),
            bouquetInfoStack.leadingAnchor.constraint(equalTo: bouquetImage.trailingAnchor, constant: 10),
            bouquetInfoStack.trailingAnchor.constraint(equalTo: bouquetView.trailingAnchor, constant: -10),
            bouquetInfoStack.heightAnchor.constraint(equalToConstant: 200)
        ])
    }
    
    func configure(_ model: EditOrderDetailsModel, _ price: Double) {
        orderCodeLabel.text = "\(model.orderCode ?? 0)"
        bouquetOrderStatus.text = model.orderStatus
        bouquetNameLabel.text = model.bouquetInfo?.name
        bouquetImage.kf.setImage(with: URL(string: model.bouquetInfo?.bouquetPhotos.first?.url ?? ""))
        floristCompanyName.text = model.branchDivisionInfoDto?.divisionType
        bouquetPriceLabel.text = "\(price) BLM"
    }
}
