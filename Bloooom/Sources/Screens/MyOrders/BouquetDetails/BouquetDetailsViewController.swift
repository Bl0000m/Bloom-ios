import UIKit
import AnchoredBottomSheet

class BouquetDetailsViewController: UIViewController {

    private let viewModel: BouquetDetailsViewModelProtocol
    var model: BouquetDetailsModel?
    private let bouquetDetilsView = BouquetDetailsView()
    private var bottomSheetView: BottomSheetView!
    private lazy var closeButton = UIButton(btnImage: "closeButton")
    private lazy var shareButton = UIButton(btnImage: "share")
    private lazy var bagButton = UIButton(btnImage: "bag")
    
    private lazy var bouquetPhotosCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.itemSize = CGSize(width: view.frame.width, height: view.frame.height)
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.register(BouquetDetailsCell.self, forCellWithReuseIdentifier: BouquetDetailsCell.id)
        collectionView.isPagingEnabled = true
        collectionView.showsVerticalScrollIndicator = false
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        return collectionView
    }()
    
    private let id: Int
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupConfiguration()
        setupViews()
        setupLayout()
        bindViewModel()
        setupExtensions()
        DispatchQueue.main.async {
            self.bouquetDetilsView.tableView.reloadData()
        }
        view.backgroundColor = .white
    }
    
    init(viewModel: BouquetDetailsViewModelProtocol, id: Int) {
        self.viewModel = viewModel
        self.id = id
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        bottomSheetView.didSetupConstraints = true
    }
    
    private func setupViews() {
        view.addSubview(closeButton)
        view.addSubview(bagButton)
        view.addSubview(shareButton)
        view.addSubview(bouquetPhotosCollectionView)
        view.addSubview(bottomSheetView)
        bottomSheetView.translatesAutoresizingMaskIntoConstraints = false
    }
    
    private func setupLayout() {
        NSLayoutConstraint.activate([
            closeButton.topAnchor.constraint(equalTo: view.topAnchor, constant: 50),
            closeButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 21),
            closeButton.heightAnchor.constraint(equalToConstant: 24),
            closeButton.widthAnchor.constraint(equalToConstant: 24)
        ])
        
        NSLayoutConstraint.activate([
            bagButton.topAnchor.constraint(equalTo: view.topAnchor, constant: 50),
            bagButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -21),
            bagButton.heightAnchor.constraint(equalToConstant: 24),
            bagButton.widthAnchor.constraint(equalToConstant: 24)
        ])
        
        NSLayoutConstraint.activate([
            shareButton.topAnchor.constraint(equalTo: view.topAnchor, constant: 50),
            shareButton.trailingAnchor.constraint(equalTo: bagButton.leadingAnchor, constant: -10),
            shareButton.heightAnchor.constraint(equalToConstant: 24),
            shareButton.widthAnchor.constraint(equalToConstant: 24)
        ])
        
        NSLayoutConstraint.activate([
            bouquetPhotosCollectionView.topAnchor.constraint(equalTo: closeButton.bottomAnchor, constant: 16),
            bouquetPhotosCollectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            bouquetPhotosCollectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            bouquetPhotosCollectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            bottomSheetView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            bottomSheetView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            bottomSheetView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
        ])
    }
    
    private func setupConfiguration() {
        let config = BottomSheetViewConfiguration(
            contentView: bouquetDetilsView,
            parentViewController: self,
            defaultPosition: .bottom(height: 135),
            positions: [.top(), .customBottom(height: 135)],
            isSlidingToAppear: false,
            isPullIndicatorNeeded: true,
            isDismissAllowed: false,
            cornerRadius: 0
        )
        
        bottomSheetView = BottomSheetView(configuration: config)
        bottomSheetView.delegate = self
    }
    
    private func setData(model: BouquetDetailsModel) {
        bouquetDetilsView.bouquetAutor.text = "Автор: \(model.companyName)"
        bouquetDetilsView.compositionBouquetName.text = model.name
        bouquetDetilsView.compositionBouquetPrice.text = "\(model.price) BLM"
        bouquetDetilsView.tableView.reloadData()
    }
    
    private func setupExtensions() {
        bouquetPhotosCollectionView.dataSource = self
     //   bouquetPhotosCollectionView.delegate = self
        bouquetDetilsView.tableView.dataSource = self
        bouquetDetilsView.tableView.delegate = self
    }
    
    private func bindViewModel() {
        viewModel.onBouquetsUpdated = { [weak self] result in
            switch result {
            case .success(let bouquets):
                self?.model = bouquets
                self?.setData(model: bouquets)
                self?.bouquetPhotosCollectionView.reloadData()
                print("Инфо Букеты получены: \(bouquets)")
            case .failure(let error):
                print("Ошибка при получении подписок: \(error.localizedDescription)")
            }
        }
        
        viewModel.getBouquetPhotos(id: id)
    }
}

extension BouquetDetailsViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return model?.bouquetPhotos.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: BouquetDetailsCell.id, for: indexPath) as? BouquetDetailsCell else {
            return UICollectionViewCell()
        }
        if let bouquet = model?.bouquetPhotos[indexPath.row] {
            cell.configure(bouquet: bouquet)
        }
        return cell
    }
}

extension BouquetDetailsViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0:
            return model?.flowerVarietyInfo.count ?? 0
        case 1:
            return model?.additionalElements.count ?? 0
        default:
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.section {
        case 0:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: CompositionBouquetCell.compositionBouquetID, for: indexPath) as? CompositionBouquetCell,
                  let flowerModel = model?.flowerVarietyInfo[indexPath.row] else {
                return UITableViewCell()
            }
            cell.configure(model: flowerModel)
            return cell
        case 1:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: AdditionalElementsCell.additionalElementID, for: indexPath) as? AdditionalElementsCell,
                  let additionalElement = model?.additionalElements[indexPath.row] else {
                return UITableViewCell()
            }
            cell.configure(model: additionalElement)
            return cell
        default:
            return UITableViewCell()
        }
    }
}

extension BouquetDetailsViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = UIView()
        let titleLabel = UILabel()
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.textColor = .black
        titleLabel.font = UIFont.systemFont(ofSize: 12, weight: .regular)
        
        // Устанавливаем текст в зависимости от секции
        switch section {
        case 0:
            titleLabel.text = "СОСТАВ БУКЕТА"
        case 1:
            titleLabel.text = "ДОПОЛНИТЕЛЬНЫЕ ЭЛЕМЕНТЫ"
        default:
            titleLabel.text = ""
        }
        
        headerView.addSubview(titleLabel)
        
        NSLayoutConstraint.activate([
            titleLabel.leadingAnchor.constraint(equalTo: headerView.leadingAnchor),
            titleLabel.topAnchor.constraint(equalTo: headerView.topAnchor),
            titleLabel.bottomAnchor.constraint(equalTo: headerView.bottomAnchor, constant: -20)
        ])
        
        return headerView
    }
}

extension BouquetDetailsViewController: BottomSheetViewDelegate {
    func heightDidChange(to y: CGFloat) {
        print("Height did change to: \(y)")
    }
}

extension BottomSheetViewPosition {
    static func customBottom(height: CGFloat = 135) -> BottomSheetViewPosition {
        return .bottom(height: height)
    }
}
