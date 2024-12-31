import UIKit

class MonthsViewController: UIViewController {

    private let viewModel: MonthsViewModelProtocol
    private var monthsArray: [String] = []
    private let mainView = UIView(backgroundColor: .white)
    private let selectMonthTitle = UILabel(text: "ВЫБЕРИТЕ МЕСЯЦ", font: 16, textColor: .black)
    private lazy var closeButton = UIButton(btnImage: "closeButton")
    private let monthsCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.register(MonthCell.self, forCellWithReuseIdentifier: MonthCell.monthCellID)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        return collectionView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupView()
        setupLayout()
        setupExtensions()
        updateUI(for: Date())
        mainView.layer.borderWidth = 0.5
        mainView.layer.borderColor = UIColor.black.cgColor
    }
    
    init(viewModel: MonthsViewModelProtocol) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupView() {
        view.addSubview(mainView)
        [selectMonthTitle, closeButton, monthsCollectionView].forEach { mainView.addSubview($0) }
    }
    
    private func setupLayout() {
        NSLayoutConstraint.activate([
            mainView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            mainView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            mainView.heightAnchor.constraint(equalToConstant: 270),
            mainView.widthAnchor.constraint(equalToConstant: 348)
        ])
        
        NSLayoutConstraint.activate([
            selectMonthTitle.topAnchor.constraint(equalTo: mainView.topAnchor, constant: 20),
            selectMonthTitle.leadingAnchor.constraint(equalTo: mainView.leadingAnchor, constant: 18)
        ])
        
        NSLayoutConstraint.activate([
            closeButton.topAnchor.constraint(equalTo: mainView.topAnchor, constant: 20),
            closeButton.trailingAnchor.constraint(equalTo: mainView.trailingAnchor, constant: -18),
            closeButton.heightAnchor.constraint(equalToConstant: 24)
        ])
        
        NSLayoutConstraint.activate([
            monthsCollectionView.topAnchor.constraint(equalTo: selectMonthTitle.bottomAnchor, constant: 20),
            monthsCollectionView.leadingAnchor.constraint(equalTo: mainView.leadingAnchor, constant: 18),
            monthsCollectionView.trailingAnchor.constraint(equalTo: mainView.trailingAnchor, constant: -18),
            monthsCollectionView.bottomAnchor.constraint(equalTo: mainView.bottomAnchor, constant: -37)
        ])
    }
    
    private func updateUI(for currentDate: Date) {
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "ru_RU")
        
        let allMonths = formatter.monthSymbols?.map { $0.uppercased() } ?? []
        monthsArray = allMonths
        
        formatter.dateFormat = "MMMM"
        let currentMonth = formatter.string(from: currentDate).uppercased()
        
        if let currentMonthIndex = monthsArray.firstIndex(of: currentMonth) {
            let indexPath = IndexPath(item: currentMonthIndex, section: 0)
            monthsCollectionView.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
        }
            
        monthsCollectionView.reloadData()
    }

    private func setupExtensions() {
        monthsCollectionView.delegate = self
        monthsCollectionView.dataSource = self
    }
}

extension MonthsViewController: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        monthsArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: MonthCell.monthCellID,
            for: indexPath
        ) as? MonthCell else { return UICollectionViewCell()
        }
        let monthTitle = monthsArray[indexPath.row]
        cell.configure(for: monthTitle)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let selectedMonth = monthsArray[indexPath.item]
       // viewModel.selectedMonth(month: selectedMonth)
    }
}
