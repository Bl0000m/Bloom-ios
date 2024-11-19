import UIKit

class CountriesCodesCell: UITableViewCell {

    static let countriesCellID = "countriesCellID"
    
    private let countryFlagImage = UILabel(text: "", font: 12, textColor: .black)
    private let countryCodeLabel = UILabel(text: "", font: 12, textColor: .black)
    private let countryNameLabel = UILabel(text: "", font: 12, textColor: .black)
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        [countryFlagImage, countryCodeLabel, countryNameLabel].forEach { addSubview($0) }
        
        NSLayoutConstraint.activate([
            countryFlagImage.centerYAnchor.constraint(equalTo: centerYAnchor),
            countryFlagImage.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16)
        ])
        
        NSLayoutConstraint.activate([
            countryCodeLabel.centerYAnchor.constraint(equalTo: centerYAnchor),
            countryCodeLabel.leadingAnchor.constraint(equalTo: countryFlagImage.trailingAnchor, constant: 10)
        ])
        NSLayoutConstraint.activate([
            countryNameLabel.centerYAnchor.constraint(equalTo: centerYAnchor),
            countryNameLabel.leadingAnchor.constraint(equalTo: countryCodeLabel.trailingAnchor, constant: 16),
            countryNameLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16)
        ])
    }
    
    func configure(country: Country) {
        countryFlagImage.text = country.flag
        countryCodeLabel.text = country.dialCode
        countryNameLabel.text = country.nameRu
        
    }
    
}
