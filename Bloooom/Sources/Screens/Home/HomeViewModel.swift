import Foundation

protocol HomeViewModelProtocol {
    var mainScreenCoordinator: HomeViewCoordinator { get set}
    var dataArray: [HomeModel] { get set }
    
    func fetchData(completion: @escaping () -> Void)
}

final class HomeViewModel: HomeViewModelProtocol {
    private let apiManager = ApiManager()
    
    var mainScreenCoordinator: HomeViewCoordinator
    var dataArray: [HomeModel] = []
    
    init(mainScreenCoordinator: HomeViewCoordinator) {
        self.mainScreenCoordinator = mainScreenCoordinator
    }
    
    func fetchData(completion: @escaping () -> Void) {
        apiManager.fetchData { [weak self] result in
            switch result {
            case .success(let data):
                self?.dataArray = data
            case .failure(let error):
                print("Failed fetch places \(error)")
            }
            completion()
        }
    }
}
