import Foundation

struct Bouquet: Codable {
    let id: Int
    let name: String
    let companyName: String?
    let bouquetPhotos: [BouquetsGalleryModel]
    let price: Double?
}

struct BouquetsGalleryModel: Codable {
    let id: Int
    let url: String
}

