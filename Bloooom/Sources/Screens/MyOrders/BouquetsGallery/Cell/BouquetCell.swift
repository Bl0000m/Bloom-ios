import UIKit
import Kingfisher

class BouquetCell: UICollectionViewCell {
    
    static let id = "bouquetID"
    
    private let bouquetImage: UIImageView = {
        let bouquetImg = UIImageView()
        bouquetImg.contentMode = .scaleToFill
        bouquetImg.translatesAutoresizingMaskIntoConstraints = false
        return bouquetImg
    }()
    
    private let addButton = UIButton(btnImage: "addIcon")
    
    private let bouquetName = UILabel(text: "", font: 12, textColor: .black)
    private let bouquetPrice = UILabel(text: "", font: 12, textColor: .black)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
        setupLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupViews() {
        [bouquetImage, addButton, bouquetName, bouquetPrice].forEach { addSubview($0) }
    }
    
    private func setupLayout() {
        NSLayoutConstraint.activate([
            bouquetImage.topAnchor.constraint(equalTo: topAnchor),
            bouquetImage.leadingAnchor.constraint(equalTo: leadingAnchor),
            bouquetImage.trailingAnchor.constraint(equalTo: trailingAnchor),
            bouquetImage.heightAnchor.constraint(equalToConstant: 291)
        ])
        
        NSLayoutConstraint.activate([
            addButton.centerXAnchor.constraint(equalTo: centerXAnchor),
            addButton.bottomAnchor.constraint(equalTo: bouquetImage.bottomAnchor, constant: -13),
            addButton.heightAnchor.constraint(equalToConstant: 17),
            addButton.widthAnchor.constraint(equalToConstant: 17)
        ])
        
        NSLayoutConstraint.activate([
            bouquetName.topAnchor.constraint(equalTo: bouquetImage.bottomAnchor, constant: 12),
            bouquetName.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 11),
            bouquetName.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -11)
        ])
        
        NSLayoutConstraint.activate([
            bouquetPrice.topAnchor.constraint(equalTo: bouquetName.bottomAnchor, constant: 10),
            bouquetPrice.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 11),
            bouquetPrice.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -13)
        ])
    }
    
    func configure(with bouquet: Bouquet) {
        bouquetName.text = bouquet.name
        bouquetPrice.text = "\(bouquet.price) BLM"
        if let bouquetPhotos = bouquet.bouquetPhotos.first {
            bouquetImage.kf.setImage(with: URL(string: bouquetPhotos.url))
        }
    }
}
