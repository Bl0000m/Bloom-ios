import Foundation

protocol EditOrderDetailsViewModelProtocol: AnyObject {
    func moveToFlowersGallery()
    func fetchUserSubscriptions(id: Int)
    func getBoquetInfo(id: Int)
    func goToAddress()
    func goToListOrders()
    var onSubscriptionsFetched: ((Result<EditOrderDetailsModel, Error>) -> Void)? { get set }
    var onBouquetInfoUpdated: ((Result<BouquetDetailsModel, Error>) -> Void)? { get set }
    var onError: ((String) -> Void)? { get set }
}

class EditOrderDetailsViewModel: EditOrderDetailsViewModelProtocol {
    var onSubscriptionsFetched: ((Result<EditOrderDetailsModel, Error>) -> Void)?
    var onBouquetInfoUpdated: ((Result<BouquetDetailsModel, Error>) -> Void)?
    let coordinator: EditOrderDetailsCoordinator
    var onError: ((String) -> Void)?
    
    init(coordinator: EditOrderDetailsCoordinator) {
        self.coordinator = coordinator
    }
    
    func fetchUserSubscriptions(id: Int) {
        guard let accessToken = UserDefaults.standard.string(forKey: "userAccessToken") else { return }
        MySubscribeAPIManager.shared.fetchUserOrder(orderId: id, accessToken: accessToken) { [weak self] result in
            DispatchQueue.main.async {
                switch result {
                case .success:
                    self?.onSubscriptionsFetched?(result)
                case .failure(let error):
                    print("Error - \(error.localizedDescription)")
                }
            }
        }
    }
    
    func getBoquetInfo(id: Int) {
        guard let accessToken = UserDefaults.standard.string(forKey: "userAccessToken") else { return }
        DetailOrdersService.shared.fetchBouquetPhoto(id: id, accessToken: accessToken) { [weak self] result in
            DispatchQueue.main.async {
                switch result {
                case .success:
                    self?.onBouquetInfoUpdated?(result)
                case .failure(let error):
                    self?.onError?(error.localizedDescription)
                }
            }
        }
    }
    
    func goToAddress() {
        coordinator.goToAddress()
    }
    
    func goToListOrders() {
        coordinator.goToOrdersList()
    }
    
    func moveToFlowersGallery() {
        coordinator.goToGallery()
    }
}
