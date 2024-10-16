import Foundation

class ApiManager {
  let dataArray: [MainScreenModel] = [
    MainScreenModel(imageUrl: "1", isWhite: false, index: 0, categoryName: ""),
    MainScreenModel(imageUrl: "2", isWhite: true, index: 1, categoryName: "carouselIndicator1"),
    MainScreenModel(imageUrl: "3", isWhite: false, index: 2, categoryName: "carouselIndicator2"),
    MainScreenModel(imageUrl: "4", isWhite: true, index: 3, categoryName: "carouselIndicator3"),
    MainScreenModel(imageUrl: "5", isWhite: false, index: 4, categoryName: "")
  ]
  
  func fetchData(completion: @escaping(Result<[MainScreenModel], Error>) -> Void) {
    completion(.success(dataArray))
  }
}
