import Foundation

class ApiManager {
  let dataArray: [HomeModel] = [
    HomeModel(imageUrl: "1", isWhite: false, index: 0, categoryName: ""),
    HomeModel(imageUrl: "2", isWhite: true, index: 1, categoryName: "carouselIndicator1"),
    HomeModel(imageUrl: "3", isWhite: false, index: 2, categoryName: "carouselIndicator2"),
    HomeModel(imageUrl: "4", isWhite: true, index: 3, categoryName: "carouselIndicator3"),
    HomeModel(imageUrl: "5", isWhite: false, index: 4, categoryName: "")
  ]
  
  func fetchData(completion: @escaping(Result<[HomeModel], Error>) -> Void) {
    completion(.success(dataArray))
  }
}
