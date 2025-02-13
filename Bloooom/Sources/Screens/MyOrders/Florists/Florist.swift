import Foundation

struct Florist: Codable {
    let id: Int
    let bouquetId: Int
    let branchDivisionId: Int
    let assemblyCost: Double
    let address: String?
}
