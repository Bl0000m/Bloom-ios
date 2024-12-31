import UIKit

class CalendarCell: UICollectionViewCell {
   
    static let calendarCellID = "calendarCellID"
    
    let label: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.font = .systemFont(ofSize: 16, weight: .regular)
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
        setupLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupViews() {
        contentView.addSubview(label)
    }
    
    private func setupLayout() {
        label.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            label.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            label.centerYAnchor.constraint(equalTo: contentView.centerYAnchor)
        ])
        
        contentView.layer.cornerRadius = 22
        contentView.layer.masksToBounds = true
    }
    
    func configure(with day: Int, isSelected: Bool) {
        label.text = "\(day)"
        contentView.backgroundColor = isSelected ? .black : .clear
        label.textColor = isSelected ? .white : .black
    }

    func clear() {
        label.text = ""
        contentView.backgroundColor = .clear
    }
}
