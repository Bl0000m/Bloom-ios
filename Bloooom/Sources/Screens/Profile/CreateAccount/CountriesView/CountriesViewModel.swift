import Foundation

protocol CountriesViewModelProtocol {
    var reloadTableView: (() -> Void)? { get set }
    func numberOfCountries() -> Int
    func countryName(at index: Int) -> Country
}

final class CountriesViewModel: CountriesViewModelProtocol {
    
    private(set) var countries: [Country] = []
    var reloadTableView: (() -> Void)?
    private weak var countriesCoordinator: CountriesCoordinator?
    
    init(countriesCoordinator: CountriesCoordinator?) {
        self.countriesCoordinator = countriesCoordinator
        fetchCountries()
    }
    
    func numberOfCountries() -> Int {
        return countries.count
    }
    
    func countryName(at index: Int) -> Country {
        return countries[index]
    }
    
    private func fetchCountries() {
        UserAPIManager.shared.loadCountries { [weak self] result in
            switch result {
            case .success(let countries):
                self?.countries = countries
                self?.reloadTableView?()
            case .failure(let error):
                print("Failed to load countries: \(error)")
            }
        }
    }
}
