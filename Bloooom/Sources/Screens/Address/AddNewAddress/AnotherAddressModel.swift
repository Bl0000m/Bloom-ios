import Foundation

struct AnotherAddressModel: Codable {
    let id: Int
    let street: String
    let building: String
    let apartment: String?
    let entrance: String?
    let intercom: String?
    let floor: Int?
    let city: String
    let postalCode: String?
    let latitude: Int?
    let longitude: Int?
}

struct AddressModel: Codable {
    let street: String
    let building: String
    let apartment: String?
    let entrance: String?
    let intercom: String?
    let floor: Int?
    let city: String
    let postalCode: String?
    let latitude: Int?
    let longitude: Int?
    let orderId: Int
    let recipientPhone: String
    let comment: String?
}


