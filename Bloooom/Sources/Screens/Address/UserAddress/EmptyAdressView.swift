import UIKit

class EmptyAdressView: UIView {

    private let pinImage: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(named: "pin")
        image.contentMode = .scaleAspectFill
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    private let emptyAddressMainTitle = UILabel(
        text: "У ВАС ПОКА НЕТ СОХРАНЕННЫХ АДРЕСОВ",
        font: 12,
        textColor: .black
    )
    
    private let emptyAddressSubTitle = UILabel(
        text: "Как только появятся новые адреса, они будут\nотображаться здесь.",
        font: 12,
        textColor: .gray
    )
    
    private let emptyAddressStack = UIStackView(
        axis: .vertical,
        distribution: .fill,
        alignment: .leading,
        spacing: 20
    )
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
        setupLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupViews() {
        [pinImage, emptyAddressStack].forEach { addSubview($0) }
        [emptyAddressMainTitle, emptyAddressSubTitle].forEach { emptyAddressStack.addArrangedSubview($0) }
    }

    private func setupLayout() {
        NSLayoutConstraint.activate([
            pinImage.topAnchor.constraint(equalTo: topAnchor),
            pinImage.leadingAnchor.constraint(equalTo: leadingAnchor),
            pinImage.heightAnchor.constraint(equalToConstant: 24),
            pinImage.widthAnchor.constraint(equalToConstant: 24)
        ])
        
        NSLayoutConstraint.activate([
            emptyAddressStack.topAnchor.constraint(equalTo: pinImage.bottomAnchor, constant: 26),
            emptyAddressStack.leadingAnchor.constraint(equalTo: leadingAnchor),
            emptyAddressStack.trailingAnchor.constraint(equalTo: trailingAnchor),
            emptyAddressStack.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
}
