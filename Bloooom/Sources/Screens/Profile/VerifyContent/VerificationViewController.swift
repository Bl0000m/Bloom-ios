import UIKit

class VerificationViewController: UIViewController {
    
    private var model: VerificationViewContent
    var buttonAction: (() -> Void)?
    
    private let stackView = UIStackView(axis: .vertical, distribution: .fill, alignment: .center, spacing: 10)
    private let mainTitle = UILabel(text: "", font: 16, alignment: .center)
    private let subtitle = UILabel(text: "", font: 12, alignment: .center)
    private let image: UIImageView = {
        let image = UIImageView()
        image.contentMode = .scaleAspectFit
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    private lazy var button = UIButton(title: "")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        configure(model: model)
        subtitle.textColor = .lightGray
        view.backgroundColor = .white
    }
    
    init(model: VerificationViewContent, buttonAction: (() -> Void)?) {
        self.model = model
        self.buttonAction = buttonAction
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        [stackView, image, button].forEach { view.addSubview($0) }
        [mainTitle, subtitle].forEach { stackView.addArrangedSubview($0) }
        
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: view.topAnchor, constant: 200),
            stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 18),
            stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -18),
            stackView.heightAnchor.constraint(equalToConstant: 60)
        ])
        
        NSLayoutConstraint.activate([
            image.topAnchor.constraint(equalTo: stackView.bottomAnchor, constant: 40),
            image.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            image.heightAnchor.constraint(equalToConstant: 106),
            image.widthAnchor.constraint(equalToConstant: 106)
        ])
        
        NSLayoutConstraint.activate([
            button.topAnchor.constraint(equalTo: image.bottomAnchor, constant: 40),
            button.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            button.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            button.heightAnchor.constraint(equalToConstant: 32)
        ])
    }
    
    private func configure(model: VerificationViewContent) {
        mainTitle.text = model.title
        subtitle.text = model.subtitle
        image.image = UIImage(named: model.imageName)
        button.setTitle(model.buttonTitle, for: .normal)
    }
}
