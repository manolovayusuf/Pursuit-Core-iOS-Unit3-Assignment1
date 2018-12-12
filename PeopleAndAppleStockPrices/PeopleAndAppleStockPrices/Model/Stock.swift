//
//  Stock.swift
//  PeopleAndAppleStockPrices
//
//  Created by Manny Yusuf on 12/11/18.
//  Copyright © 2018 Pursuit. All rights reserved.
//

import Foundation

struct StockInfo: Codable {
    var date: String
    var open: Int
    var high: Int
    var low: Int
    var close: Int
}
