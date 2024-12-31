import Foundation

struct CreateSubscribeModel: Codable {
    let userId: Int
    let name: String
    let subscriptionTypeId: Int
    let orderDates: [OrderDates]
}

struct OrderDates: Codable {
    let orderDate: String
    let orderStartTime: String
    let orderEndTime: String
}

struct ResponseData: Codable {
    let id: Int
    let name: String
    let userName: String
}
