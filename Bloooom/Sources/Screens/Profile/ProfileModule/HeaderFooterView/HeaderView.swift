import UIKit

class HeaderView: UITableViewHeaderFooterView {
    
    static let headerID = "headerID"

    private let billStack = UIStackView(
        axis: .horizontal,
        distribution: .fillEqually,
        alignment: .leading,
        spacing: 5
    )
    
    private let mainView: UIView = {
        let view = UIView()
        view.layer.borderColor = UIColor.black.cgColor
        view.layer.borderWidth = 0.5
        view.backgroundColor = .white
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let myBill = UILabel(text: "МОИ СЧЕТ", font: 12, textColor: .black)
    private lazy var manageButton = UIButton(btnImage: "manage")
    private let balance = UILabel(text: "42.5", font: 35, textColor: .black)
    private let balanceTitle = UILabel(text: "BLM", font: 35, textColor: .black)
    private let cashbackTitle = UILabel(text: "Кэшбек 3% с каждого заказа", font: 12, textColor: .black)
    
    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        setupViews()
        setupLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupViews() {
        addSubview(mainView)
        [balance, balanceTitle].forEach { billStack.addArrangedSubview($0) }
        [myBill, manageButton, billStack, cashbackTitle].forEach { mainView.addSubview($0) }
    }
    
    private func setupLayout() {
        NSLayoutConstraint.activate([
            mainView.topAnchor.constraint(equalTo: topAnchor),
            mainView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 21),
            mainView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -21),
            mainView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -20),
           // mainView.heightAnchor.constraint(equalToConstant: 120)
        ])
        
        NSLayoutConstraint.activate([
            myBill.topAnchor.constraint(equalTo: mainView.topAnchor, constant: 13),
            myBill.leadingAnchor.constraint(equalTo: mainView.leadingAnchor, constant: 20)
        ])
        
        NSLayoutConstraint.activate([
            manageButton.topAnchor.constraint(equalTo: mainView.topAnchor, constant: 13),
            manageButton.trailingAnchor.constraint(equalTo: mainView.trailingAnchor, constant: -20),
            manageButton.heightAnchor.constraint(equalToConstant: 15)
        ])
        
        NSLayoutConstraint.activate([
            billStack.topAnchor.constraint(equalTo: myBill.bottomAnchor, constant: 20),
            billStack.leadingAnchor.constraint(equalTo: mainView.leadingAnchor, constant: 20),
            billStack.heightAnchor.constraint(equalToConstant: 42)
        ])
        
        NSLayoutConstraint.activate([
            cashbackTitle.topAnchor.constraint(equalTo: billStack.bottomAnchor, constant: 5),
            cashbackTitle.leadingAnchor.constraint(equalTo: mainView.leadingAnchor, constant: 20),
            cashbackTitle.trailingAnchor.constraint(equalTo: mainView.trailingAnchor, constant: -20),
            cashbackTitle.bottomAnchor.constraint(equalTo: mainView.bottomAnchor, constant: -13)
        ])
    }
}
