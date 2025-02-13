import Foundation

protocol FloristsViewModelProtocol: AnyObject {
    func getFlorists(id:  Int)
    func goBack()
    func postOrder(
        orderId: Int,
        bouquetId: Int,
        branchDivisionId: Int,
        assemblyCost: Double,
        address: String,
        completion: @escaping (Result<Florist, Error>) -> Void
    )
    func selectedFlorist(bouquetId: Int, branchId: Int)
    var onFloristsUpdated: ((Result<BouquetDetailsModel, Error>) -> Void)? { get set }
    var onError: ((String) -> Void)? { get set }
}

class FloristsViewModel:  FloristsViewModelProtocol {
    
    var onError: ((String) -> Void)?
    var onFloristsUpdated: ((Result<BouquetDetailsModel, Error>) -> Void)?
    
    private let coordinator: FloristsCoordinator
    
    init(coordinator: FloristsCoordinator) {
        self.coordinator = coordinator
    }
    
    func getFlorists(id: Int) {
        guard let accessToken = UserDefaults.standard.string(forKey: "userAccessToken") else { return }
        DetailOrdersService.shared.fetchBouquetPhoto(id: id, accessToken: accessToken) { [weak self] result in
            DispatchQueue.main.async {
                switch result {
                case .success:
                    self?.onFloristsUpdated?(result)
                case .failure(let error):
                    self?.onError?(error.localizedDescription)
                }
            }
        }
    }
    
    func goBack() {
        coordinator.goBack()
    }
    
    func selectedFlorist(bouquetId: Int, branchId: Int) {
        coordinator.selectedFlorists(bouquetId: bouquetId, branchId: branchId)
    }
    
    func postOrder(
        orderId: Int,
        bouquetId: Int,
        branchDivisionId: Int,
        assemblyCost: Double,
        address: String,
        completion: @escaping (Result<Florist, Error>) -> Void
    ) {
        let model = Florist(
            id: orderId,
            bouquetId: bouquetId,
            branchDivisionId: branchDivisionId,
            assemblyCost: assemblyCost,
            address: address
        )
        guard let token = UserDefaults.standard.string(forKey: "userAccessToken") else { return }
        DetailOrdersService.shared.postClientOrder(model: model, accessToken: token) { result in
            DispatchQueue.main.async {
                completion(result)
            }
        }
    }
}
