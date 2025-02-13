import Foundation

import Foundation

struct BouquetDetailsModel: Codable {
    let id: Int
    let name: String
    let author: String
    let bouquetPhotos: [BouquetPhotos]
    let branchBouquetInfo: [BranchBouquetInfo]
    let price: Double?
    let bouquetStyle: String
    let flowerVarietyInfo: [FlowerVariety]
    let additionalElements: [AdditionalElement]
}

struct BranchBouquetInfo: Codable {
    let branchId: Int
    let divisionType: String
    let price: Double
    let address: String?
    let phoneNumber: String
    let email: String
}

struct BouquetPhotos: Codable {
    let id: Int
    let url: String
}

struct FlowerVariety: Codable {
    let id: Int
    let name: String
    var image: String?
    var quantity: Int
}

struct AdditionalElement: Codable {
    var id: Int
    let name: String
    var quantity: Int
    let color: String?
}
