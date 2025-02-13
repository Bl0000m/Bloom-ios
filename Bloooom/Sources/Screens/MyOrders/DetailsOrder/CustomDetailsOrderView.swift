import UIKit
class CustomDetailsOrderView: UIView {
    
    private var mainTitle: String = ""
    private var image: String = ""
    var descTitle: String = ""
    
    var moveToDetails: (() -> Void)?
    var moveToAddAdress: (() -> Void)?
    
    private var mainTitleText: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 12, weight: .regular)
        label.textColor = UIColor.black
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let selectTitleText: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 12, weight: .regular)
        label.textColor = UIColor.black
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let moveButton = UIButton(btnImage: "expandRight")
    
    private let topLine = UIView(backgroundColor: .black)
    private let bottomLine = UIView(backgroundColor: .black)
    
    private let mainView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var orderIcon: UIImageView = {
        let icon = createIcon(withImageName: image)
        icon.contentMode = .scaleAspectFit
        icon.translatesAutoresizingMaskIntoConstraints = false
        return icon
    }()
    
    required override init(frame: CGRect) {
        super.init(frame: frame)
        setTitles()
        setupViews()
        setupLayout()
        configureLines()
        setupAction()
    }
    
    init(mainTitle: String, image: String, descTitle: String) {
        super.init(frame: .zero)
        self.mainTitle = mainTitle
        self.image = image
        self.descTitle = descTitle
        
        setTitles()
        setupViews()
        setupLayout()
        configureLines()
        setupAction()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setTitles() {
        mainTitleText.text = mainTitle
        selectTitleText.text = descTitle
    }
    
    private func setupAction() {
        moveButton.addTarget(self, action: #selector(moveToDetail), for: .touchUpInside)
    }
    
    @objc func moveToDetail() {
        moveToDetails?()
        moveToAddAdress?()
    }
    
    private func createIcon(withImageName imageName: String) -> UIImageView {
        let icon = UIImageView()
        icon.image = UIImage(named: imageName)
        return icon
    }
    
    private func configureLines() {
        topLine.translatesAutoresizingMaskIntoConstraints = false
        bottomLine.translatesAutoresizingMaskIntoConstraints = false
    }
    
    private func setupViews() {
        [mainTitleText, mainView].forEach { addSubview($0) }
        [topLine, selectTitleText, orderIcon, moveButton, bottomLine].forEach { mainView.addSubview($0) }
    }
    
    private func setupLayout() {
        NSLayoutConstraint.activate([
            mainTitleText.topAnchor.constraint(equalTo: topAnchor, constant: 10),
            mainTitleText.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 21)
        ])
        
        NSLayoutConstraint.activate([
            mainView.topAnchor.constraint(equalTo: mainTitleText.bottomAnchor, constant: 20),
            mainView.leadingAnchor.constraint(equalTo: leadingAnchor),
            mainView.trailingAnchor.constraint(equalTo: trailingAnchor),
            mainView.heightAnchor.constraint(equalToConstant: 55)
        ])
        
        NSLayoutConstraint.activate([
            topLine.topAnchor.constraint(equalTo: mainView.topAnchor),
            topLine.leadingAnchor.constraint(equalTo: mainView.leadingAnchor),
            topLine.trailingAnchor.constraint(equalTo: mainView.trailingAnchor),
            topLine.heightAnchor.constraint(equalToConstant: 0.5)
        ])
        
        NSLayoutConstraint.activate([
            orderIcon.centerYAnchor.constraint(equalTo: mainView.centerYAnchor),
            orderIcon.leadingAnchor.constraint(equalTo: mainView.leadingAnchor, constant: 21),
            orderIcon.heightAnchor.constraint(equalToConstant: 24),
            orderIcon.widthAnchor.constraint(equalToConstant: 24)
        ])
        
        NSLayoutConstraint.activate([
            selectTitleText.centerYAnchor.constraint(equalTo: mainView.centerYAnchor),
            selectTitleText.leadingAnchor.constraint(equalTo: orderIcon.trailingAnchor, constant: 10)
        ])
        
        NSLayoutConstraint.activate([
            moveButton.centerYAnchor.constraint(equalTo: mainView.centerYAnchor),
            moveButton.trailingAnchor.constraint(equalTo: mainView.trailingAnchor, constant: -21),
            moveButton.heightAnchor.constraint(equalToConstant: 24),
            moveButton.widthAnchor.constraint(equalToConstant: 24)
        ])
        
        NSLayoutConstraint.activate([
            bottomLine.bottomAnchor.constraint(equalTo: mainView.bottomAnchor),
            bottomLine.leadingAnchor.constraint(equalTo: mainView.leadingAnchor),
            bottomLine.trailingAnchor.constraint(equalTo: mainView.trailingAnchor),
            bottomLine.heightAnchor.constraint(equalToConstant: 0.5)
        ])
    }
    
    func updateDescription(deliveryTime: String) {
        selectTitleText.text = deliveryTime
    }
    
    func updateAddress(streetName: String) {
        selectTitleText.text = streetName
    }
}


