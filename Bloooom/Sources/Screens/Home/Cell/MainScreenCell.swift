import UIKit

class MainScreenCell: UICollectionViewCell {

  static let screenID = "screnID"
  
  private let stackView: UIStackView = {
    let stack = UIStackView()
    stack.axis = .horizontal
    stack.distribution = .fill
    stack.spacing = 2
    stack.translatesAutoresizingMaskIntoConstraints = false
    return stack
  }()

  private let screenImage: UIImageView = {
    let image = UIImageView()
    image.contentMode = .scaleAspectFill
    image.translatesAutoresizingMaskIntoConstraints = false
    return image
  }()

  let searchView: UIView = {
    let view = UIView()
    view.layer.borderWidth = 1
    view.layer.borderColor = UIColor.black.cgColor
    view.translatesAutoresizingMaskIntoConstraints = false
    return view
  }()
  
  let searchButton: UIButton = {
    let button = UIButton()
    button.setTitle("ПОИСК", for: .normal)
    button.setTitleColor(.black, for: .normal)
    button.titleLabel?.font = .systemFont(ofSize: 14)
    button.translatesAutoresizingMaskIntoConstraints = false
    return button
  }()
  
  let couruselImg: UIImageView = {
    let image = UIImageView()
    image.contentMode = .scaleAspectFit
    image.translatesAutoresizingMaskIntoConstraints = false
    return image
  }()
  
  private let promotionLabel: UILabel = {
    let label = UILabel()
    label.text = "АКТИВИРУЙ СЧАСТЬЕ - ПОЛУЧИ ЦВЕТЫ"
    label.textColor = .black
    label.font = .systemFont(ofSize: 12)
    label.translatesAutoresizingMaskIntoConstraints = false
    return label
  }()
  
  private let separatorLabel: UILabel = {
    let label = UILabel()
    label.text = "|"
    label.font = .systemFont(ofSize: 8)
    label.textColor = .black
    label.translatesAutoresizingMaskIntoConstraints = false
    return label
  }()
  
  private let privacyLabel: UILabel = {
    let label = UILabel()
    label.text = "ПОЛИТИКА КОНФИДЕНЦИАЛЬНОСТИ "
    label.textColor = .black
    label.font = .systemFont(ofSize: 8)
    label.translatesAutoresizingMaskIntoConstraints = false
    return label
  }()
  
  private let privacyLabel2: UILabel = {
    let label = UILabel()
    label.text = " УСЛОВИЯ ПОКУПКИ"
    label.textColor = .black
    label.font = .systemFont(ofSize: 8)
    label.translatesAutoresizingMaskIntoConstraints = false
    return label
  }()
  override init(frame: CGRect) {
    super.init(frame: frame)
    addElementsToView()
    setConstraints()
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  override func prepareForReuse() {
    super.prepareForReuse()
    couruselImg.image = nil
    screenImage.image = nil
  }
  
  private func addElementsToView() {
    addSubview(screenImage)
    addSubview(couruselImg)
    addSubview(searchView)
    searchView.addSubview(searchButton)
    addSubview(promotionLabel)
    addSubview(stackView)
    [privacyLabel, separatorLabel, privacyLabel2].forEach { stackView.addArrangedSubview($0) }
  }
  
  private func setConstraints() {
    NSLayoutConstraint.activate([
      screenImage.topAnchor.constraint(equalTo: topAnchor),
      screenImage.leadingAnchor.constraint(equalTo: leadingAnchor),
      screenImage.trailingAnchor.constraint(equalTo: trailingAnchor),
      screenImage.bottomAnchor.constraint(equalTo: bottomAnchor)
    ])
    
    NSLayoutConstraint.activate([
      couruselImg.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
      couruselImg.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -150),
      couruselImg.widthAnchor.constraint(equalToConstant: 15)
    ])
    
    NSLayoutConstraint.activate([
      searchView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
      searchView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
      searchView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -113),
      searchView.heightAnchor.constraint(equalToConstant: 25)
    ])
    
    NSLayoutConstraint.activate([
      searchButton.centerYAnchor.constraint(equalTo: searchView.centerYAnchor),
      searchButton.trailingAnchor.constraint(equalTo: searchView.trailingAnchor, constant: -10),
      searchButton.heightAnchor.constraint(equalToConstant: 20)
    ])
    
    NSLayoutConstraint.activate([
      promotionLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
      promotionLabel.centerYAnchor.constraint(equalTo: centerYAnchor)
    ])
    
    NSLayoutConstraint.activate([
      stackView.topAnchor.constraint(equalTo: promotionLabel.bottomAnchor, constant: 200),
      stackView.centerXAnchor.constraint(equalTo: centerXAnchor),
    ])
  }
  
  func configure(screenImg: String, image: String) {
    screenImage.image = UIImage(named: screenImg)
    couruselImg.image = UIImage(named: image)
  }
  
  func configureSearchBtn(indexPath: Int) {
    switch indexPath {
    case 0:
      searchView.layer.borderColor = UIColor.black.cgColor
      searchButton.setTitleColor(.black, for: .normal)
      promotionLabel.isHidden = true
      privacyLabel.isHidden = true
      separatorLabel.isHidden = true
      privacyLabel2.isHidden = true
    case 1:
      searchView.layer.borderColor = UIColor.white.cgColor
      searchButton.setTitleColor(.white, for: .normal)
      promotionLabel.isHidden = true
      privacyLabel.isHidden = true
      separatorLabel.isHidden = true
      privacyLabel2.isHidden = true
    case 2:
      searchView.layer.borderColor = UIColor.black.cgColor
      searchButton.setTitleColor(.black, for: .normal)
      promotionLabel.isHidden = true
      privacyLabel.isHidden = true
      separatorLabel.isHidden = true
      privacyLabel2.isHidden = true
    case 3:
      searchView.layer.borderColor = UIColor.white.cgColor
      searchButton.setTitleColor(.white, for: .normal)
      promotionLabel.isHidden = true
      privacyLabel.isHidden = true
      separatorLabel.isHidden = true
      privacyLabel2.isHidden = true
    case 4:
      searchView.isHidden = true
      searchButton.isHidden = true
      promotionLabel.isHidden = false
      privacyLabel.isHidden = false
      separatorLabel.isHidden = false
      privacyLabel2.isHidden = false
    default:
      break
    }
  }
}
