import UIKit

class FaceIDViewController: UIViewController {

    private let viewModel: FaceIDViewModelProtocol
    
    private let goBackButton = UIButton(btnImage: "btnLeft")
    private let closeButton = UIButton(btnImage: "closeButton")
    
    private let faceIdLabel = UILabel(text: "FACE ID", font: 16, textColor: .black)
    
    private let faceIdImage: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(named: "faceID")
        image.contentMode = .scaleAspectFill
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    private let useFaceIDLabel = UILabel(
        text: "ИСПОЛЬЗОВАТЬ FACE ID ДЛЯ БЫСТРОГО\nВХОДА В ПРИЛОЖЕНИЕ?",
        font: 12,
        textColor: .black
    )
    
    private let useFaceIdButton = UIButton(title: "ИСПОЛЬЗОВАТЬ")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupLayout()
        actionButton()
        faceIdLabel.textAlignment = .center
        useFaceIDLabel.textAlignment = .center
    }
    
    init(viewModel: FaceIDViewModelProtocol) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func actionButton() {
        useFaceIdButton.addTarget(self, action: #selector(moveToPincode), for: .touchUpInside)
    }
    
    @objc private func moveToPincode() {
        viewModel.goPincode()
    }
    
    private func setupLayout() {
        [goBackButton, closeButton, faceIdLabel, faceIdImage, useFaceIDLabel, useFaceIdButton].forEach { view.addSubview($0) }
        
        NSLayoutConstraint.activate([
            goBackButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 50),
            goBackButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 21),
            goBackButton.heightAnchor.constraint(equalToConstant: 24),
            goBackButton.widthAnchor.constraint(equalToConstant: 24),
            
            closeButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 50),
            closeButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -21),
            closeButton.heightAnchor.constraint(equalToConstant: 24),
            closeButton.widthAnchor.constraint(equalToConstant: 24),
            
            faceIdLabel.topAnchor.constraint(equalTo: goBackButton.bottomAnchor, constant: 50),
            faceIdLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            faceIdImage.topAnchor.constraint(equalTo: faceIdLabel.bottomAnchor, constant: 130),
            faceIdImage.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            useFaceIDLabel.topAnchor.constraint(equalTo: faceIdImage.bottomAnchor, constant: 40),
            useFaceIDLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            useFaceIdButton.topAnchor.constraint(equalTo: useFaceIDLabel.bottomAnchor, constant: 134),
            useFaceIdButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 21),
            useFaceIdButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -21),
            useFaceIdButton.heightAnchor.constraint(equalToConstant: 32)
        ])
    }
}
