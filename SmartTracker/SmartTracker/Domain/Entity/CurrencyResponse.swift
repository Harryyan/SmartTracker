//
//  CurrencyResponse.swift
//  CurrencyResponse
//
//  Created by Harry Yan on 18/08/21.
//

import Foundation

struct CurrencyResponse: Decodable {
    let success: Bool
    let terms: String
    let privacy: String
    let timestamp: TimeInterval
    let source: String
    let quotes: [String: Double]
    
    // Hard code here for now
    static let url = URL(string: APP_LINK + "?access_key=\(APP_SECRET)" + "&currencies=NZD,USD")!
}
