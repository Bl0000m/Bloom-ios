import Foundation

protocol OrderDetailsViewModelProtocol {
    func moveToSubscribers()
    func fetchUserSubscriptions(id: Int)
    func goToOrderDetails()
    var onOrderDetailsUpdated: (([OrderDetailsModel]) -> Void)? { get set }
    var onError: (() -> Void)? { get set }
    var onSubscriptionsFetched: ((Result<[EditOrderDetailsModel], Error>) -> Void)? { get set }
    
    var orderDetails: [OrderDetailsModel] { get set }
}

class OrderDetailsViewModel: OrderDetailsViewModelProtocol {
    var onSubscriptionsFetched: ((Result<[EditOrderDetailsModel], Error>) -> Void)?
    var orderDetails: [OrderDetailsModel] = []
    var onOrderDetailsUpdated: (([OrderDetailsModel]) -> Void)?
    var onError: (() -> Void)?
    
    private let coordinator: OrderDetailsCoordinator
    
    init(coordinator: OrderDetailsCoordinator) {
        self.coordinator = coordinator
    }
    
    func moveToSubscribers() {
        coordinator.popToPreviousScreen(steps: 3)
    }
    
    func fetchUserSubscriptions(id: Int) {
        guard let accessToken = UserDefaults.standard.string(forKey: "userAccessToken") else { return }
        MySubscribeAPIManager.shared.fetchOrderDetails(orderId: id, accessToken: accessToken) { [weak self] result in
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
    
    func goToOrderDetails() {
        coordinator.moveToOrderDetails()
    }
}
