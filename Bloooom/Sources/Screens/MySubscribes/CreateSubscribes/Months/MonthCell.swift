import UIKit

class MonthCell: UICollectionViewCell {
    
    private let monthCellView = UIView(backgroundColor: .clear)
    private let monthTitle = UILabel(
        text: "",
        font: 12,
        textColor: .black
    )
    static let monthCellID = "monthCellID"
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
        setupLayout()
        monthCellView.layer.borderWidth = 0.5
        monthCellView.layer.borderColor = UIColor.black.cgColor
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupViews() {
        addSubview(monthCellView)
        monthCellView.addSubview(monthTitle)
    }
    
    private func setupLayout() {
        NSLayoutConstraint.activate([
            monthCellView.topAnchor.constraint(equalTo: topAnchor),
            monthCellView.leadingAnchor.constraint(equalTo: leadingAnchor),
            monthCellView.trailingAnchor.constraint(equalTo: trailingAnchor),
            monthCellView.bottomAnchor.constraint(equalTo: bottomAnchor),
            monthCellView.heightAnchor.constraint(equalToConstant: 25),
            monthCellView.widthAnchor.constraint(equalToConstant: 70)
        ])
        
        NSLayoutConstraint.activate([
            monthTitle.centerYAnchor.constraint(equalTo: monthCellView.centerYAnchor),
            monthTitle.leadingAnchor.constraint(equalTo: monthCellView.leadingAnchor, constant: 10),
            monthTitle.trailingAnchor.constraint(equalTo: monthCellView.trailingAnchor, constant: -10)
        ])
    }
    
    func configure(for month: String) {
        monthTitle.text = month
    }
}
