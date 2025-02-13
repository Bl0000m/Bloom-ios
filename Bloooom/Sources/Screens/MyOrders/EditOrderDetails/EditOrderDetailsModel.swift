import Foundation

struct EditOrderDetailsModel: Codable {
    let id: Int
    let orderCode: Int?
    let address: Address?
    let bouquetInfo: BouquetEditInfo?
    let branchDivisionInfoDto: BranchDivisionInfo?
    let assemblyCost: Double?
    let deliveryDate: String
    let deliveryStartTime: String
    let deliveryEndTime: String
    let orderStatus: String?
}

struct Address: Codable {
    let id: Int
    let street: String
    let building: String
    let apartment: String
    let entrance: String
    let intercom: String
    let floor: Int?
    let city: String
    let postalCode: String?
    let latitude: Int?
    let longitude: Int?
    let recipientPhone: String
    let comment: String
}

struct BouquetEditInfo: Codable {
    let id: Int
    let name: String
    let bouquetPhotos: [BouquetEditPhoto]
}

struct BouquetEditPhoto: Codable {
    let id: Int
    let url: String
}

struct BranchDivisionInfo: Codable {
    let id: Int
    let address: String?
    let divisionType: String
    let phoneNumber: String
    let email: String
}
