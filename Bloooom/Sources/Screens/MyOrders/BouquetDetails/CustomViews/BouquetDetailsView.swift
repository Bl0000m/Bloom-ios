import UIKit

class BouquetDetailsView: UIView {
    
    var selectFloristAction: (() -> Void)?
    var selectBookmarkAction: (() -> Void)?
    
    private let compostionBouquetStack = UIStackView(
        axis: .vertical,
        distribution: .fillEqually,
        alignment: .leading,
        spacing: 10
    )
    
    let compositionBouquetName = UILabel(text: "", font: 12, textColor: .black)
    private lazy var bookmarkButton = UIButton(btnImage: "bookmark")
    let compositionBouquetPrice = UILabel(text: "", font: 12, textColor: .black)
    private lazy var selectButton = UIButton(title: "ВЫБРАТЬ")
    let bouquetAutor = UILabel(text: "", font: 12, textColor: .black)
    private let selectedUs = UILabel(text: "Выбрали нас: 350 раз", font: 12, textColor: .black)
    
    let tableView: UITableView = {
        let tableView = UITableView()
        tableView.register(CompositionBouquetCell.self, forCellReuseIdentifier: CompositionBouquetCell.compositionBouquetID)
        tableView.register(AdditionalElementsCell.self, forCellReuseIdentifier: AdditionalElementsCell.additionalElementID)
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 30
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
        setupLayout()
        setupActions()
        tableView.reloadData()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupViews() {
        [compostionBouquetStack, bookmarkButton, selectButton, bouquetAutor, selectedUs, tableView].forEach { addSubview($0) }
        [compositionBouquetName, compositionBouquetPrice].forEach { compostionBouquetStack.addArrangedSubview($0) }
    }
    
    private func setupLayout() {
        NSLayoutConstraint.activate([
            compostionBouquetStack.topAnchor.constraint(equalTo: topAnchor),
            compostionBouquetStack.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 21)
        ])
        
        NSLayoutConstraint.activate([
            bookmarkButton.topAnchor.constraint(equalTo: topAnchor),
            bookmarkButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -21),
            bookmarkButton.heightAnchor.constraint(equalToConstant: 20),
            bookmarkButton.widthAnchor.constraint(equalToConstant: 20)
        ])
        
        NSLayoutConstraint.activate([
            selectButton.topAnchor.constraint(equalTo: compostionBouquetStack.bottomAnchor, constant: 20),
            selectButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 21),
            selectButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -21),
            selectButton.heightAnchor.constraint(equalToConstant: 32)
        ])
        
        NSLayoutConstraint.activate([
            bouquetAutor.topAnchor.constraint(equalTo: selectButton.bottomAnchor, constant: 20),
            bouquetAutor.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 21)
        ])
        
        NSLayoutConstraint.activate([
            selectedUs.topAnchor.constraint(equalTo: selectButton.bottomAnchor, constant: 20),
            selectedUs.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -21)
        ])
        
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: bouquetAutor.bottomAnchor, constant: 20),
            tableView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 21),
            tableView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -21),
            tableView.heightAnchor.constraint(equalToConstant: 350),
            tableView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
    
    private func setupActions() {
        selectButton.addTarget(self, action: #selector(selectFlorist), for: .touchUpInside)
        bookmarkButton.addTarget(self, action: #selector(selectBookmark), for: .touchUpInside)
    }
    
    @objc private func selectFlorist() {
        selectFloristAction?()
    }
    
    @objc private func selectBookmark() {
        selectBookmarkAction?()
    }
}
