import UIKit

class BouquetDetailsCell: UICollectionViewCell {
    
    static let id = "bouquetID"
    
    private let bouquetImage: UIImageView = {
        let bouquetIcon = UIImageView()
        bouquetIcon.contentMode = .scaleToFill
        bouquetIcon.translatesAutoresizingMaskIntoConstraints = false
        return bouquetIcon
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
        setupLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupViews() {
        addSubview(bouquetImage)
    }
    
    func setupLayout() {
        NSLayoutConstraint.activate([
            bouquetImage.topAnchor.constraint(equalTo: topAnchor),
            bouquetImage.leadingAnchor.constraint(equalTo: leadingAnchor),
            bouquetImage.trailingAnchor.constraint(equalTo: trailingAnchor),
            bouquetImage.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
    
    func configure(bouquet: BouquetPhotos) {
        bouquetImage.kf.setImage(with: URL(string: bouquet.url))
        
    }
}
