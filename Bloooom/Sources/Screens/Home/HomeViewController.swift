import UIKit

final class HomeViewController: UIViewController {
    
    private var viewModel: HomeViewModelProtocol

    private var timer: Timer?
    private var currentIndex: Int = 0
    let isScrolling = false
    
    private let icon: UIImageView = {
        let icon = UIImageView()
        icon.image = UIImage(named: "logo1")
        icon.contentMode = .scaleAspectFill
        icon.translatesAutoresizingMaskIntoConstraints = false
        return icon
    }()
    
    private let mainScreenCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.register(MainScreenCell.self, forCellWithReuseIdentifier: MainScreenCell.screenID)
        collectionView.backgroundColor = .white
        collectionView.isPagingEnabled = true
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        return collectionView
    }()
    
    init(viewModel: HomeViewModelProtocol) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        startAutoScroll()
        setElementToView()
        setConstraints()
        fetchData()
        
        navigationController?.setNavigationBarHidden(true, animated: false)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        //startAutoScroll()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        stopAutoScroll()
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        .darkContent
    }
    
    private func fetchData() {
        viewModel.fetchData { [weak self] in
            DispatchQueue.main.async {
                self?.mainScreenCollectionView.reloadData()
            }
        }
    }
    
    private func setElementToView() {
        view.addSubview(mainScreenCollectionView)
        view.addSubview(icon)
        mainScreenCollectionView.delegate = self
        mainScreenCollectionView.dataSource = self
        mainScreenCollectionView.showsVerticalScrollIndicator = false
        mainScreenCollectionView.showsHorizontalScrollIndicator = false
    }
    
    private func startAutoScroll() {
        timer = Timer.scheduledTimer(timeInterval: 2.0, target: self, selector: #selector(scrollToNextItem), userInfo: nil, repeats: true)
    }
    
    private func stopAutoScroll() {
        timer?.invalidate()
        timer = nil
    }
    
    @objc private func scrollToNextItem() {
        let itemCount = mainScreenCollectionView.numberOfItems(inSection: 0)
        
        if currentIndex < itemCount - 1 {
            currentIndex += 1
        } else {
            currentIndex = 0
        }
        
        let indexPath = IndexPath(item: currentIndex, section: 0)
        mainScreenCollectionView.scrollToItem(at: indexPath, at: .centeredVertically, animated: true)
    }
    
    private func hideElements(in cell: MainScreenCell) {
        cell.searchView.isHidden = true
        cell.searchButton.isHidden = true
        cell.couruselImg.isHidden = true
    }
    
    private func showElements(in cell: MainScreenCell) {
        cell.searchView.isHidden = false
        cell.searchButton.isHidden = false
        cell.couruselImg.isHidden = false
    }
    
    private func setConstraints() {
        NSLayoutConstraint.activate([
            mainScreenCollectionView.topAnchor.constraint(equalTo: view.topAnchor),
            mainScreenCollectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            mainScreenCollectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            mainScreenCollectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 10)
        ])
        
        NSLayoutConstraint.activate([
            icon.topAnchor.constraint(equalTo: view.topAnchor, constant: 95),
            icon.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
    }
}

extension HomeViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.dataArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MainScreenCell.screenID,
                                                            for: indexPath) as? MainScreenCell else {
            return UICollectionViewCell()
        }
        
        if isScrolling {
            hideElements(in: cell)
        } else {
            showElements(in: cell)
        }
        
        let data = viewModel.dataArray[indexPath.row]
        
        cell.configure(screenImg: data.imageUrl, image: data.categoryName)
        cell.configureSearchBtn(indexPath: indexPath.row)
        return cell
    }
}

extension HomeViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let size = CGSize(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
        return size
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let visibleCells = mainScreenCollectionView.visibleCells
        
        if scrollView.contentOffset.y < 0 {
            scrollView.contentOffset.y = 0
        }
        
        for cell in visibleCells {
            guard let indexPath = mainScreenCollectionView.indexPath(for: cell) else { continue }
            
            let cellFrame = mainScreenCollectionView.layoutAttributesForItem(at: indexPath)?.frame ?? .zero
            let cellCenter = cellFrame.origin.y + cellFrame.height / 2
            let cellBottom = cellFrame.origin.y + cellFrame.height // Нижняя граница ячейки
            
            let offsetY = scrollView.contentOffset.y + scrollView.frame.height / 2
            
            let isNearCellCenter = abs(offsetY - cellCenter) < 50 // Близость к центру ячейки
            let isNearCellBottom = abs(offsetY - cellBottom) < 50 // Близость к нижней границе ячейки
            
            if isNearCellCenter || isNearCellBottom {
                // Устанавливаем логотип в зависимости от индекса ячейки (чётный или нечётный)
                icon.image = (indexPath.row % 2 == 0) ? UIImage(named: "logo1") : UIImage(named: "logo2")
                break
            }
        }
    }
    
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        stopAutoScroll()
        let visibleCells = mainScreenCollectionView.visibleCells
        
        for cell in visibleCells {
            guard let iconCell = cell as? MainScreenCell else { continue }
            hideElements(in: iconCell)
        }
    }
    
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        let visibleCells = mainScreenCollectionView.visibleCells
        
        for cell in visibleCells {
            guard let iconCell = cell as? MainScreenCell else { continue }
            showElements(in: iconCell)
        }
    }
}

extension HomeViewController: TabView {
    var tabInfo: Tab {
        .home
    }
}
