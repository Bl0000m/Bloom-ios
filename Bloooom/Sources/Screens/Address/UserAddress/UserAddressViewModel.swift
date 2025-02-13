import Foundation

protocol UserAddressViewModelProtocol: AnyObject {
    func moveToAnotherAddress()
    func fetchAddresses(id: Int)
    var onAddressUpdated: ((Result<[AnotherAddressModel], Error>) -> Void)? { get set }
    var onAddressError: ((String) -> Void)? { get set }
}

class UserAddressViewModel: UserAddressViewModelProtocol {
  
    var onAddressUpdated: ((Result<[AnotherAddressModel], Error>) -> Void)?
    var onAddressError: ((String) -> Void)?
    
    private let coordinator: UserAddressCoordinator
    
    init(coordinator: UserAddressCoordinator) {
        self.coordinator = coordinator
    }
    
    func moveToAnotherAddress() {
        coordinator.goToAnotherAddress()
    }
    
    func fetchAddresses(id: Int) {
        guard let accessToken = UserDefaults.standard.string(forKey: "userAccessToken") else { return }
        AddressService.shared.getAddress(id: id, accessToken: accessToken) { [weak self] result in
            DispatchQueue.main.async {
                switch result {
                case .success:
                    self?.onAddressUpdated?(result)
                case .failure(let error):
                    self?.onAddressError?(error.localizedDescription)
                }
            }

        }
    }
    
}
