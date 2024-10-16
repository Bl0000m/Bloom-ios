import Foundation

class MainScreenViewModel {
  var dataArray: [MainScreenModel] = []
  private let apiManager = ApiManager()
  
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
