import Foundation

protocol BouquestsGalleryViewModelProtocol: AnyObject {
    var onBouquetsUpdated: ((Result<[Bouquet], Error>) -> Void)? { get set }
    var onError: ((String) -> Void)? { get set }
    
    func fetchBouquets()
    func toDetails(id: Int)
}

class BouquestsGalleryViewModel: BouquestsGalleryViewModelProtocol {
    var onBouquetsUpdated: ((Result<[Bouquet], Error>) -> Void)?
    var onError: ((String) -> Void)?
    
    private let coordinator: BouquestsGalleryCoordinator
    
    init(coordinator: BouquestsGalleryCoordinator) {
        self.coordinator = coordinator
    }
    
    func fetchBouquets() {
        guard let accessToken = UserDefaults.standard.string(forKey: "userAccessToken") else { return }
        DetailOrdersService.shared.fetchBouquets(accessToken: accessToken) { [weak self] result in
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
    
    func toDetails(id: Int) {
        coordinator.goToDetails(id: id)
    }
}

extension Array {
    subscript(safe index: Int) -> Element? {
        return indices.contains(index) ? self[index] : nil
    }
}
