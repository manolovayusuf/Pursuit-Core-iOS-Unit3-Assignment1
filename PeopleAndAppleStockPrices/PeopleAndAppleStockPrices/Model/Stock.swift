//
//  Stock.swift
//  PeopleAndAppleStockPrices
//
//  Created by Manny Yusuf on 12/11/18.
//  Copyright © 2018 Pursuit. All rights reserved.
//

import Foundation

struct StockInfo: Codable {
    let date: String
    let open: Double
    let high: Double
    let low: Double
    let close: Double
    let volume: Int
    let unadjustedVolume: Int
    let change: Double
    let changePercent: Double
    let vwap: Double
    let label: String
    let changeOverTime: Double
    var sectionName: String {
      let components = date.components(separatedBy: "-")
      let year = components[0]
      let month = components[1]
        return "\(monthsDictionary[month]!) \(year)"
    }
    
    let monthsDictionary = ["01":"January", "02":"February", "03":"March", "04":"April", "05":"May", "06":"June", "07":"July", "08":"August", "09":"September", "10":"October", "11":"November", "12":"December" ]
}
