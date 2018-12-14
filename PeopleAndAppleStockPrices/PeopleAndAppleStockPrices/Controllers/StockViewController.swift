//
//  StockViewController.swift
//  PeopleAndAppleStockPrices
//
//  Created by Manny Yusuf on 12/11/18.
//  Copyright © 2018 Pursuit. All rights reserved.
//

import UIKit

class StockViewController: UIViewController {

    private var stockPrices = [StockInfo]()
    var stocksByYear = [[StockInfo]]()
    var stockMonth = [[StockInfo]]()
    var sectionNames = [String]()
    
    
    @IBOutlet weak var stocksTableView: UITableView!
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let DetailedViewController = segue.destination as? StockDetailedViewController,
            let cellSelected = stocksTableView.indexPathForSelectedRow else {return}
        let sectionStocks = self.stockBySections(intSection: cellSelected.section)
        let myStock = sectionStocks[cellSelected.row]
        DetailedViewController.stockDetailOfPerson = myStock
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        stocksTableView.dataSource = self
        stocksTableView.delegate = self
        loadData()
        getSectionNames()
    }
    func getSectionNames() {
        for stock in stockPrices {
            if !sectionNames.contains(stock.sectionName) {
                sectionNames.append(stock.sectionName)
            }
        }
    }
    func stockBySections(intSection: Int) -> [StockInfo] {
        return stockPrices.filter({$0.sectionName == sectionNames[intSection]})
    }
    
    func headerDetails() {
        for yearNum in 2016...2018 {
            let yearStock = stockPrices.filter { (StockInfo) -> Bool in
            let dateSeparated = StockInfo.date.components(separatedBy: "-")
            let currentStockYear = dateSeparated[0]
                if Int(currentStockYear) == yearNum {
                    return true
                } else {
                    return false
    }
}
                stocksByYear.append(yearStock)
}
    
        for arrYearStocks in stocksByYear {
            for monthNum in 1...12 {
                let stockMonthArr = arrYearStocks.filter { (StockInfo) -> Bool in
                let dateSeparated = StockInfo.date.components(separatedBy: "-")
                let currentStockMonth = dateSeparated[1]
                    if Int(currentStockMonth) == monthNum {
                        return true
                    } else {
                        return false
        }
    }
                    if !stockMonthArr.isEmpty {
                        stockMonth.append(stockMonthArr)
            }
        }
    }
}
    
    func loadData() {
        if let path = Bundle.main.path(forResource: "applstockinfo", ofType: "json") {
            let url = URL.init(fileURLWithPath: path)
            if let data = try? Data.init(contentsOf: url) {
                do {
                    let stocksArray = try JSONDecoder().decode([StockInfo].self, from: data)
                    stockPrices = stocksArray.sorted(by: { (stockOne, stockTwo) -> Bool in
                        return stockOne.date < stockTwo.date
                    })
                } catch {
                    print(error)
                }
            }
        }
    }
}
extension StockViewController: UITableViewDataSource, UITableViewDelegate {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return sectionNames.count
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        let thisSection = sectionNames[section]
        let stocksInThisSection = stockPrices.filter({$0.sectionName == thisSection})
        var sum = 0.0
        for stock in stocksInThisSection {
            sum += stock.open
        }
        let average = sum / Double(stocksInThisSection.count)
        return sectionNames[section] + "              " + "Average \(String(format: "%.2f", average))"
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return stockBySections(intSection: section).count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = stocksTableView.dequeueReusableCell(withIdentifier: "StockCell", for: indexPath)
        let stockInThisSection = stockBySections(intSection: indexPath.section)
        let stocksToSet = stockInThisSection[indexPath.row]
        cell.textLabel?.text = stocksToSet.date
        cell.detailTextLabel?.text = "$" + String(format: "%.2f", stocksToSet.open)
        return cell
    }
}
