import Foundation

struct OrderDetailsModel: Codable {
    let id: Int
    var orderCode: Int? = nil
    var address: String? = nil
    var bouquetInfo: BouquetInfo? = nil
    let deliveryDate, deliveryStartTime, deliveryEndTime: String
    var orderStatus: String? = nil
}

struct BouquetInfo: Codable {
    let id: Int
    let name: String
    let description: String
    let companyName: String
    let bouquetPhotos: [BouquetPhoto]
    let price: Double
    let addition: String
}

struct BouquetPhoto: Codable {
    let id: Int
    let url: String
}
