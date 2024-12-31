import UIKit

class MySubscribesViewController: UIViewController {
    
    private let viewModel: MySubscribesViewModelProtocol
    
    private lazy var backButton = UIButton(btnImage: "btnLeft")
    private let mySubscribesTitle = UILabel(text: "МОИ ПОДПИСКИ", font: 16, textColor: .black)
    private let subscribeIcon: UIImageView = {
        let image = UIImageView()
        image.contentMode = .scaleAspectFit
        image.image = UIImage(named: "checkRing")
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    private let subscribeEmptyTitle = UILabel(text: "У ВАС ПОКА НЕТ АКТИВНЫХ ПОДПИСОК", font: 12, textColor: .black)
    private let subscribeSubtitle = UILabel(
        text: "Как только вы добавите подписки, они будут\nотображаться здесь.",
        font: 12,
        textColor: .lightGray
    )
    private lazy var addSubscribeButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .black
        button.setTitleColor(.white, for: .normal)
        button.setTitle("ДОБАВИТЬ", for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 12, weight: .regular)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private let subscribesTableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        subscribesTableView.isHidden = true
        setupViews()
        setupLayout()
        setupActions()
    }
    
    init(viewModel: MySubscribesViewModelProtocol) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupViews() {
        [backButton, mySubscribesTitle, subscribesTableView, subscribeIcon, subscribeEmptyTitle, subscribeSubtitle, addSubscribeButton].forEach { view.addSubview($0) }
    }
    
    private func setupActions() {
        backButton.addTarget(self, action: #selector(goBack), for: .touchUpInside)
        addSubscribeButton.addTarget(self, action: #selector(addSubscribe), for: .touchUpInside)
    }
    
    @objc private func goBack() {
        viewModel.moveToBack()
    }
    
    @objc private func addSubscribe() {
        viewModel.moveToCreateSubscribe()
    }
    
    private func setupLayout() {
        NSLayoutConstraint.activate([
            backButton.topAnchor.constraint(equalTo: view.topAnchor, constant: 100),
            backButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 21)
        ])
        
        NSLayoutConstraint.activate([
            mySubscribesTitle.topAnchor.constraint(equalTo: backButton.bottomAnchor, constant: 33),
            mySubscribesTitle.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 21),
            mySubscribesTitle.heightAnchor.constraint(equalToConstant: 19)
        ])
        
        NSLayoutConstraint.activate([
            subscribesTableView.topAnchor.constraint(equalTo: mySubscribesTitle.bottomAnchor, constant: 28),
            subscribesTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            subscribesTableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            subscribesTableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
        
        NSLayoutConstraint.activate([
            subscribeIcon.topAnchor.constraint(equalTo: mySubscribesTitle.bottomAnchor, constant: 93),
            subscribeIcon.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 21),
            subscribeIcon.heightAnchor.constraint(equalToConstant: 24)
        ])
        
        NSLayoutConstraint.activate([
            subscribeEmptyTitle.topAnchor.constraint(equalTo: subscribeIcon.bottomAnchor, constant: 28),
            subscribeEmptyTitle.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 21)
        ])
        
        NSLayoutConstraint.activate([
            subscribeSubtitle.topAnchor.constraint(equalTo: subscribeEmptyTitle.bottomAnchor, constant: 20),
            subscribeSubtitle.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 21)
        ])
        
        NSLayoutConstraint.activate([
            addSubscribeButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            addSubscribeButton.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            addSubscribeButton.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            addSubscribeButton.heightAnchor.constraint(equalToConstant: 40)
        ])
    }
}
