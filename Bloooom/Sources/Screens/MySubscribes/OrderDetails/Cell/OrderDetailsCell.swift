
import UIKit

class OrderDetailsCell: UITableViewCell {

    static let orderDetailsID = "orderDetailsID"
    
    var settingTap: (() -> Void)?
    private let settingsButton = UIButton(btnImage: "meatballsMenu")
    
    private let image: UIImageView = {
        let image = UIImageView()
        image.contentMode = .scaleAspectFit
        image.image = UIImage(named: "plus")
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    private let viewForImage: UIView = {
        let view = UIView()
        view.layer.borderWidth = 0.5
        view.layer.borderColor = UIColor.black.cgColor
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let timeDeliveryTitle = UILabel(text: "", font: 14, textColor: .black)
    private let deliveryInfoTitle = UILabel(text: "Уточните детали для заказа", font: 12, textColor: .lightGray)
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupViews()
        setupLayout()
        settingsButton.isHidden = true
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupViews() {
        [viewForImage, timeDeliveryTitle, deliveryInfoTitle, settingsButton].forEach { addSubview($0) }
        viewForImage.addSubview(image)
    }
    
    private func setupAction() {
        settingsButton.addTarget(self, action: #selector(tapSetting), for: .touchUpInside)
    }
    
    @objc private func tapSetting() {
        settingTap?()
    }
    
    private func setupLayout() {
        NSLayoutConstraint.activate([
            viewForImage.topAnchor.constraint(equalTo: topAnchor, constant: 20),
            viewForImage.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            viewForImage.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -20),
            viewForImage.heightAnchor.constraint(equalToConstant: 50),
            viewForImage.widthAnchor.constraint(equalToConstant: 100)
        ])
        
        NSLayoutConstraint.activate([
            image.centerXAnchor.constraint(equalTo: viewForImage.centerXAnchor),
            image.centerYAnchor.constraint(equalTo: viewForImage.centerYAnchor)
        ])
        
        NSLayoutConstraint.activate([
            timeDeliveryTitle.topAnchor.constraint(equalTo: topAnchor, constant: 22),
            timeDeliveryTitle.leadingAnchor.constraint(equalTo: viewForImage.trailingAnchor, constant: 10)
        ])
        
        NSLayoutConstraint.activate([
            deliveryInfoTitle.topAnchor.constraint(equalTo: timeDeliveryTitle.bottomAnchor, constant: 5),
            deliveryInfoTitle.leadingAnchor.constraint(equalTo: viewForImage.trailingAnchor, constant: 10)
        ])
        
        NSLayoutConstraint.activate([
            settingsButton.centerYAnchor.constraint(equalTo: centerYAnchor),
            settingsButton.leadingAnchor.constraint(equalTo: timeDeliveryTitle.trailingAnchor, constant: 5),
            settingsButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -19)
        ])
    }
    
    func configure(timeDelivery: String) {
        timeDeliveryTitle.text = timeDelivery
    }
}
