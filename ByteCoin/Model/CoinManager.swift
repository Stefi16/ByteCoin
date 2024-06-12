//
//  CoinManager.swift
//  ByteCoin
//
//  Created by Angela Yu on 11/09/2019.
//  Copyright © 2019 The App Brewery. All rights reserved.
//

import Foundation

protocol CoinManagerDelegate {
    func didUpdatePrice(_ coinManager: CoinManager, coin: CoinModel)
    func didFinishWithError(_ error: Error)
}

struct CoinManager {
    
    private let baseURL = "https://rest.coinapi.io/v1/exchangerate/BTC"
    private let apiKey = "83943FD8-ECE8-4823-88D0-D25CDB9B65A6"
    
    let currencyArray = ["AUD", "BRL","CAD","CNY","EUR","GBP","HKD","IDR","ILS","INR","JPY","MXN","NOK","NZD","PLN","RON","RUB","SEK","SGD","USD","ZAR"]
    
    var coinManagerDelegate: CoinManagerDelegate?

    func getCoinPrice(for currency: String) {
        let finalUrlString = "https://rest.coinapi.io/v1/exchangerate/BTC/\(currency)?apikey=\(apiKey)"
        
        performRequest(with: finalUrlString)
    }
    
    
    func performRequest(with url: String) {
        let session = URLSession(configuration: .default)
        
        if let safeUrl = URL(string: url) {
            let task = session.dataTask(with: safeUrl) { data, response, error in
                if let safeData = data {
                    let result = parseJson(safeData)
                    
                    if let safeRsult = result {
                        coinManagerDelegate?.didUpdatePrice(self, coin: safeRsult)
                    }
                }
            }
            task.resume()
        }
    }
    
    private func parseJson(_ weatherData: Data) -> CoinModel? {
        let decoder = JSONDecoder()
        
        do {
            let decodedData = try decoder.decode(CoinModel.self, from: weatherData)
            
            let rate = decodedData.rate
            
            return CoinModel(rate: rate, currency: decodedData.currency)
            
        } catch {
            coinManagerDelegate?.didFinishWithError(error)
            return nil
        }
    }
}
