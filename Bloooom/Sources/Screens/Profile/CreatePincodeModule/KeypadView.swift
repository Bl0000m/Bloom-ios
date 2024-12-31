import UIKit

class KeypadView: UIView {
    
    var keypadButtonTapped: ((_ sended: UIButton) -> Void)?
    private let keypadView = UIView(backgroundColor: .clear)
    
    let lastRowStack = UIStackView(
        axis: .horizontal,
        distribution: .fillEqually,
        alignment: .leading,
        spacing: 29
    )
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
        setupLayout() 
        setupKeypad()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupView() {
        addSubview(keypadView)
    }
    
    private func setupLayout() {
        NSLayoutConstraint.activate([
            keypadView.topAnchor.constraint(equalTo: topAnchor),
            keypadView.leadingAnchor.constraint(equalTo: leadingAnchor),
            keypadView.trailingAnchor.constraint(equalTo: trailingAnchor),
            keypadView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
    
    private func setupKeypad() {
        let buttons = (1...9).map { createButton(withTitle: "\($0)") }
        var twoButtons = [UIButton]()
        twoButtons.append(createButton(withTitle: "0"))
        twoButtons.append(createButton(withTitle: "Удалить"))
        let grid = UIStackView()
        grid.axis = .vertical
        grid.distribution = .fillEqually
        grid.spacing = 17
        grid.translatesAutoresizingMaskIntoConstraints = false
        keypadView.addSubview(grid)
        
        for row in stride(from: 0, to: buttons.count, by: 3) {
            let rowStack = UIStackView(arrangedSubviews: Array(buttons[row..<min(row+3, buttons.count)]))
            rowStack.axis = .horizontal
            rowStack.distribution = .fillEqually
            rowStack.spacing = 29
            grid.addArrangedSubview(rowStack)
        }
        
       // lastRowStack.addArrangedSubview(UIView())
        twoButtons.forEach { lastRowStack.addArrangedSubview($0) }
        
        grid.addArrangedSubview(lastRowStack)
    }
    
    private func createButton(withTitle title: String) -> UIButton {
        let button = UIButton()
        if title == "Удалить" {
            button.setImage(UIImage(named: "removeButton"), for: .normal)
        }
        button.setTitle(title, for: .normal)
        button.layer.cornerRadius = 35
        button.layer.borderWidth = 0.5
        button.layer.borderColor = UIColor.black.cgColor
        button.backgroundColor = .white
        button.titleLabel?.font = .systemFont(ofSize: 24, weight: .regular)
        button.setTitleColor(.black, for: .normal)
        button.widthAnchor.constraint(equalToConstant: 70).isActive = true
        button.heightAnchor.constraint(equalToConstant: 70).isActive = true
        button.addTarget(self, action: #selector(keypadButtonTapped(_:)), for: .touchUpInside)
        return button
    }
    
    @objc private func keypadButtonTapped(_ sender: UIButton) {
        keypadButtonTapped?(sender)
    }
}
