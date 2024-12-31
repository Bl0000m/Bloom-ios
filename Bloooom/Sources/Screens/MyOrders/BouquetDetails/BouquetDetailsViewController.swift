import UIKit

class BouquetDetailsViewController: UIViewController {

    private let viewModel: BouquetDetailsViewModelProtocol
    var model: BouquetDetailsModel?
    
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
        setupViews()
        setupLayout()
        bindViewModel()
        setupExtensions()
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
    
    private func setupViews() {
        view.addSubview(bouquetPhotosCollectionView)
    }
    
    private func setupLayout() {
        NSLayoutConstraint.activate([
            bouquetPhotosCollectionView.topAnchor.constraint(equalTo: view.topAnchor),
            bouquetPhotosCollectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            bouquetPhotosCollectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            bouquetPhotosCollectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
    
    private func setupExtensions() {
        bouquetPhotosCollectionView.dataSource = self
        bouquetPhotosCollectionView.delegate = self
    }
    
    private func bindViewModel() {
        viewModel.onBouquetsUpdated = { [weak self] result in
            switch result {
            case .success(let bouquets):
                self?.model = bouquets
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
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: BouquetDetailsCell.id, for: indexPath) as? BouquetDetailsCell else { return UICollectionViewCell() }
        guard let bouquet = model?.bouquetPhotos[indexPath.row] else { return UICollectionViewCell() }
        cell.configure(bouquet: bouquet)
        return cell
    }
}

extension BouquetDetailsViewController: UICollectionViewDelegateFlowLayout {
    
}
