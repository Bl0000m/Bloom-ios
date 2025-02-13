import Foundation

protocol AnotherAddressViewModelProtocol: AnyObject {
    func fetchAddress(id: Int)
    func moveToDetailOrder()
    func sendAddressData(city: String,
                         street: String,
                         building: String,
                         appartment: String?,
                         entrance: String?,
                         intercom: String?,
                         floor: Int?,
                         phoneNumber: String,
                         comment: String?,
                         postalCode: String?,
                         long: Int?,
                         lati: Int?,
                         orderId: Int)
    func selectionCountryCode(delegate: CountrySelectionDelegate)
    func goBack()
    var onAddressUpdated: ((Result<EditOrderDetailsModel, Error>) -> Void)? { get set }
    var onAddressError: ((String) -> Void)? { get set }
    var didSignUpSuccess: (() -> Void)? { get set }
    var didSignUpFailure: ((String) -> Void)? { get set }
}

class AnotherAddressViewModel: AnotherAddressViewModelProtocol {
    
    var didSignUpSuccess: (() -> Void)?
    var didSignUpFailure: ((String) -> Void)?
    var onAddressError: ((String) -> Void)?
    var onAddressUpdated: ((Result<EditOrderDetailsModel, Error>) -> Void)?
    
    private let coordinator: AnotherAddressCoordinator
    
    init(coordinator: AnotherAddressCoordinator) {
        self.coordinator = coordinator
    }
    
    func fetchAddress(id: Int) {
        guard let accessToken = UserDefaults.standard.string(forKey: "userAccessToken") else { return }
        
        MySubscribeAPIManager.shared.fetchUserOrder(orderId: id, accessToken: accessToken) { [weak self] result in
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
    
    func selectionCountryCode(delegate: CountrySelectionDelegate) {
        coordinator.startCountrySelectionFlow(delegate: delegate)
    }
    
    func sendAddressData(
        city: String,
        street: String,
        building: String,
        appartment: String?,
        entrance: String?,
        intercom: String?,
        floor: Int?,
        phoneNumber: String,
        comment: String?,
        postalCode: String?,
        long: Int?,
        lati: Int?,
        orderId: Int
    ) {
        let model = AddressModel(
            street: street,
            building: building,
            apartment: appartment,
            entrance: entrance,
            intercom: intercom,
            floor: floor,
            city: city,
            postalCode: postalCode,
            latitude: lati,
            longitude: long,
            orderId: orderId,
            recipientPhone: phoneNumber,
            comment: comment
        )
        
        guard let accessToken = UserDefaults.standard.string(forKey: "userAccessToken") else { return }
        
        do {
            let encoder = JSONEncoder()
            let jsonData = try encoder.encode(model)

            AddressService.shared.createNewAddress(to: "/address/order", accessToken: accessToken, parameters: jsonData) { [weak self] result in
                switch result {
                case .success(let response):
                    if let responseString = String(data: response, encoding: .utf8) {
                        print("Response JSON: \(responseString)")
                    }
                    self?.didSignUpSuccess?()
                case .failure(let error):
                    print("Error", error.localizedDescription)
                    self?.didSignUpFailure?(error.localizedDescription)
                }
            }
        } catch {
            print("Error encoding parameters: \(error.localizedDescription)")
        }
    }
    
    func moveToDetailOrder() {
        coordinator.goToDetailOrder()
    }
    
    func goBack() {
        coordinator.goBack()
    }
}
