import UIKit

final class BasketViewController: UIViewController {
    private let viewModel: BasketViewModel
    
    init(viewModel: BasketViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupDescriptionUI()
    }
    
    private func setupDescriptionUI() {
        let label = UILabel()
        label.text = "Basket"
        label.font = UIFont.systemFont(ofSize: 24, weight: .regular)
        label.textColor = .black
        label.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(label)
        
        NSLayoutConstraint.activate([
            label.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            label.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
    }
}

extension BasketViewController: TabView {
    var tabInfo: Tab {
        .basket
    }
}
