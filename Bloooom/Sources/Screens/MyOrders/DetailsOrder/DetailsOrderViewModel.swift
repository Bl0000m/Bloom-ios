import Foundation

protocol DetailsOrderViewModelProtocol: AnyObject {
    func goToGallery()
    func goToListOrders()
    func fetchUserSubscriptions(id: Int)
    var onSubscriptionsFetched: ((Result<EditOrderDetailsModel, Error>) -> Void)? { get set }
}

class DetailsOrderViewModel: DetailsOrderViewModelProtocol {

    var onSubscriptionsFetched: ((Result<EditOrderDetailsModel, Error>) -> Void)?
    private let coordinator: DetailsOrderCoordinator
    
    init(coordinator: DetailsOrderCoordinator) {
        self.coordinator = coordinator
    }
    
    func goToGallery() {
        coordinator.moveToGallery()
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
    
    func goToListOrders() {
        coordinator.moveToOrderList()
    }
}
