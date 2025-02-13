import UIKit

class CompositionBouquetCell: UITableViewCell {

    static let compositionBouquetID = "compositionBouquetID"
    
    private let customView: UIView = {
        let view = UIView()
        view.layer.borderWidth = 0.5
        view.layer.borderColor = UIColor.black.cgColor
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let compostionBouquetName = UILabel(text: "", font: 12, textColor: .black)
    private let compostionBouquetNameCount = UILabel(text: "", font: 12, textColor: .black)
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupViews()
        setupLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupViews() {
        addSubview(customView)
        [compostionBouquetName, compostionBouquetNameCount].forEach { customView.addSubview($0) }
    }
    
    private func setupLayout() {
        NSLayoutConstraint.activate([
            customView.topAnchor.constraint(equalTo: topAnchor),
            customView.leadingAnchor.constraint(equalTo: leadingAnchor),
            customView.trailingAnchor.constraint(equalTo: trailingAnchor),
            customView.bottomAnchor.constraint(equalTo: bottomAnchor),
            customView.heightAnchor.constraint(equalToConstant: 30)
        ])
        
        NSLayoutConstraint.activate([
            compostionBouquetName.centerYAnchor.constraint(equalTo: customView.centerYAnchor),
            compostionBouquetName.leadingAnchor.constraint(equalTo: customView.leadingAnchor, constant: 13)
        ])
        
        NSLayoutConstraint.activate([
            compostionBouquetNameCount.centerYAnchor.constraint(equalTo: customView.centerYAnchor),
            compostionBouquetNameCount.trailingAnchor.constraint(equalTo: customView.trailingAnchor, constant: -13)
        ])
    }
    
    func configure(model: FlowerVariety) {
        compostionBouquetName.text = model.name
        compostionBouquetNameCount.text = "\(model.quantity) шт"
    }
}
