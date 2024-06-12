//
//  CoinModel.swift
//  ByteCoin
//
//  Created by Stefka Krachunova on 12.06.24.
//  Copyright © 2024 The App Brewery. All rights reserved.
//

import Foundation

struct CoinModel: Decodable {
    let rate: Double
    let currency: String
    
    enum CodingKeys: String, CodingKey {
        case rate
        case currency = "asset_id_quote"
    }
}
