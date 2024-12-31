import UIKit

class CompleteOrderViewController: UIViewController {

    private let closeButton = UIButton(btnImage: "closeButton")
    private let completeDetailsView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.layer.borderWidth = 0.5
        view.layer.borderColor = UIColor.black.cgColor
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let completeOrderTitle = UILabel(
        text: "ЗАПОЛНИТЕ ДЕТАЛИ ЗАКАЗА",
        font: 16,
        textColor: .black
    )
    
    private let completeOrderDescTitle = UILabel(
        text: "Пожалуйста, укажите все необходимые данные\nдля оформления, чтобы мы могли обработать\nваш заказ без задержек. Точные и полные\nдетали помогут обеспечить своевременную\nдоставку.",
        font: 12,
        textColor: .black
    )
    
    private lazy var completeButton = UIButton(text: "ПОДТВЕРДИТЬ", textColor: .white, font: 12)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        setupLayouts()
        setupActions()
        view.backgroundColor = .white.withAlphaComponent(0.75)
        completeButton.backgroundColor = .black
    }

    private func setupViews() {
        view.addSubview(completeDetailsView)
        [closeButton, completeOrderTitle, completeOrderDescTitle, completeButton].forEach { completeDetailsView.addSubview($0) }
    }
    
    private func setupLayouts() {
        NSLayoutConstraint.activate([
            completeDetailsView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            completeDetailsView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            completeDetailsView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 21),
            completeDetailsView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -21),
            completeDetailsView.heightAnchor.constraint(equalToConstant: 190)
        ])
        
        NSLayoutConstraint.activate([
            completeOrderTitle.topAnchor.constraint(equalTo: completeDetailsView.topAnchor, constant: 20),
            completeOrderTitle.leadingAnchor.constraint(equalTo: completeDetailsView.leadingAnchor, constant: 18),
            completeOrderTitle.trailingAnchor.constraint(equalTo: closeButton.leadingAnchor, constant: -10)
        ])
        
        NSLayoutConstraint.activate([
            closeButton.topAnchor.constraint(equalTo: completeDetailsView.topAnchor, constant: 18),
            closeButton.trailingAnchor.constraint(equalTo: completeDetailsView.trailingAnchor, constant: -12)
        ])
        
        NSLayoutConstraint.activate([
            completeOrderDescTitle.topAnchor.constraint(equalTo: completeOrderTitle.bottomAnchor, constant: 15),
            completeOrderDescTitle.leadingAnchor.constraint(equalTo: completeDetailsView.leadingAnchor, constant: 18),
            completeOrderDescTitle.trailingAnchor.constraint(equalTo: completeDetailsView.trailingAnchor, constant: -45)
        ])
        
        NSLayoutConstraint.activate([
            completeButton.topAnchor.constraint(equalTo: completeOrderDescTitle.bottomAnchor, constant: 10),
            completeButton.trailingAnchor.constraint(equalTo: completeDetailsView.trailingAnchor),
            completeButton.bottomAnchor.constraint(equalTo: completeDetailsView.bottomAnchor),
            completeButton.heightAnchor.constraint(equalToConstant: 46),
            completeButton.widthAnchor.constraint(equalToConstant: 183)
        ])
    }
    
    private func setupActions() {
        closeButton.addTarget(self, action: #selector(closeAction), for: .touchUpInside)
        completeButton.addTarget(self, action: #selector(moveToMySubscribes), for: .touchUpInside)
    }
    
    @objc private func closeAction() {
        dismiss(animated: true)
    }
    
    @objc private func moveToMySubscribes() {
        dismiss(animated: true)
    }
}
