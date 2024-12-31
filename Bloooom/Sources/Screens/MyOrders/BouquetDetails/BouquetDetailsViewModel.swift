import Foundation

protocol BouquetDetailsViewModelProtocol: AnyObject {
    func getBouquetPhotos(id: Int)
    var onBouquetsUpdated: ((Result<BouquetDetailsModel, Error>) -> Void)? { get set }
    var onError: ((String) -> Void)? { get set }
}

class BouquetDetailsViewModel: BouquetDetailsViewModelProtocol {
    
    var onBouquetsUpdated: ((Result<BouquetDetailsModel, any Error>) -> Void)?
    var onError: ((String) -> Void)?
    private let coordinator: BouquetDetailsCoordinator
    
    init(coordinator: BouquetDetailsCoordinator) {
        self.coordinator = coordinator
    }
    
    func getBouquetPhotos(id: Int) {
        guard let accessToken = UserDefaults.standard.string(forKey: "userAccessToken") else { return }
        DetailOrdersService.shared.fetchBouquetPhoto(id: id, accessToken: accessToken) { [weak self] result in
            DispatchQueue.main.async {
                switch result {
                case .success:
                    self?.onBouquetsUpdated?(result)
                case .failure(let error):
                    self?.onError?(error.localizedDescription)
                }
            }
        }
    }
}
