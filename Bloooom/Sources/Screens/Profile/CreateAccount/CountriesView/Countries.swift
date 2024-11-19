import Foundation

struct Country: Codable {
    let nameEn: String
    let nameRu: String
    let flag: String
    let code: String
    let dialCode: String
    let size: String
    
    enum CodingKeys: String, CodingKey {
        case nameEn = "name_en"
        case nameRu = "name_ru"
        case flag
        case code
        case dialCode = "dial_code"
        case size
    }
}

