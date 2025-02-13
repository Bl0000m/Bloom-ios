import UIKit

class UserAddressCell: UITableViewCell {
    
    static let addressId = "addressId"
    
    private let streetName = UILabel(text: "", font: 12, textColor: .black)
    private let cityName = UILabel(text: "", font: 12, textColor: .black)
    private let settingsButton = UIButton(btnImage: "meatballsMenu")
    private let seperator = UIView(backgroundColor: .black)
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupViews()
        setupLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupViews() {
        [streetName, cityName, seperator, settingsButton].forEach { addSubview($0) }
    }
    
    private func setupLayout() {
        NSLayoutConstraint.activate([
            streetName.topAnchor.constraint(equalTo: topAnchor, constant: 16),
            streetName.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 21)
        ])
        
        NSLayoutConstraint.activate([
            cityName.topAnchor.constraint(equalTo: streetName.bottomAnchor, constant: 10),
            cityName.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 21)
        ])
        
        NSLayoutConstraint.activate([
            settingsButton.centerYAnchor.constraint(equalTo: centerYAnchor),
            settingsButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -21),
            settingsButton.heightAnchor.constraint(equalToConstant: 24),
            settingsButton.widthAnchor.constraint(equalToConstant: 24)
        ])
        
        NSLayoutConstraint.activate([
            seperator.leadingAnchor.constraint(equalTo: leadingAnchor),
            seperator.trailingAnchor.constraint(equalTo: trailingAnchor),
            seperator.bottomAnchor.constraint(equalTo: bottomAnchor),
            seperator.heightAnchor.constraint(equalToConstant: 0.5)
        ])
    }
    
    func configure(cityNameText: String, streetNameText: String) {
        cityName.text = cityNameText
        streetName.text = streetNameText.uppercased()
    }
}
