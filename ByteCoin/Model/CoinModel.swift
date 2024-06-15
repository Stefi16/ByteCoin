import Foundation

struct CoinModel: Decodable {
    let rate: Double
    let currency: String
    
    enum CodingKeys: String, CodingKey {
        case rate
        case currency = "asset_id_quote"
    }
}
