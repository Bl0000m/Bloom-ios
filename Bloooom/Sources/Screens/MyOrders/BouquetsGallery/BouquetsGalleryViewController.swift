import UIKit

class BouquetsGalleryViewController: UIViewController {

    private let viewModel: BouquestsGalleryViewModelProtocol
    
    private lazy var backButton = UIButton(btnImage: "btnLeft")
    var model: [Bouquet] = []
    
    private lazy var galleryCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: (view.frame.width / 2) - 1, height: 352)
        layout.minimumInteritemSpacing = 0
        layout.minimumLineSpacing = 0
        layout.sectionInset = UIEdgeInsets(top: 16, left: 0, bottom: 16, right: 0)
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.register(BouquetCell.self, forCellWithReuseIdentifier: BouquetCell.id)
        collectionView.showsVerticalScrollIndicator = false
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        return collectionView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        setupLayout()
        bindViewModel()
        setupExtensions()
        setupAction()
        view.backgroundColor = .white
    }
    
    init(viewModel: BouquestsGalleryViewModelProtocol) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupAction() {
        backButton.addTarget(self, action: #selector(moveBack), for: .touchUpInside)
    }
    
    @objc private func moveBack() {
        viewModel.toBack()
    }
    
    private func setupViews() {
        [backButton, galleryCollectionView].forEach { view.addSubview($0) }
    }
    
    private func setupLayout() {
        NSLayoutConstraint.activate([
            backButton.topAnchor.constraint(equalTo: view.topAnchor, constant: 70),
            backButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 21),
            backButton.heightAnchor.constraint(equalToConstant: 24),
            backButton.widthAnchor.constraint(equalToConstant: 24)
        ])
        
        NSLayoutConstraint.activate([
            galleryCollectionView.topAnchor.constraint(equalTo: backButton.bottomAnchor, constant: 20),
            galleryCollectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            galleryCollectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            galleryCollectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
    
    private func setupExtensions() {
        galleryCollectionView.dataSource = self
        galleryCollectionView.delegate = self
    }
    
    private func bindViewModel() {
        viewModel.onBouquetsUpdated = { [weak self] result in
            switch result {
            case .success(let bouquets):
                self?.model = bouquets
                
                self?.galleryCollectionView.reloadData()
                print("Букеты получены: \(bouquets)")
            case .failure(let error):
                print("Ошибка при получении подписок: \(error.localizedDescription)")
            }
        }
        
        viewModel.fetchBouquets()
    }

}

extension BouquetsGalleryViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        model.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: BouquetCell.id, for: indexPath) as? BouquetCell else { return UICollectionViewCell() }
        let data = model[indexPath.row]
        cell.configure(with: data)
        return cell
    }
}

extension BouquetsGalleryViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let data = model[indexPath.row]
        viewModel.toDetails(id: data.id, price: data.price ?? 0.0)
    }
}
