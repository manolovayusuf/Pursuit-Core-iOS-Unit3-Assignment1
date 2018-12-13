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
    
    
    @IBOutlet weak var stocksTableView: UITableView!
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let indexPath = stocksTableView.indexPathForSelectedRow,
            let cellStock = segue.destination as? StockDetailedViewController else
        { fatalError("no index path") }
        let stockSelected = stockPrices[indexPath.row]
        cellStock.stockDetailOfPerson = stockSelected
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        stocksTableView.dataSource = self
        loadData()
        dump(stockPrices)
        

    }
    func loadData() {
        if let path = Bundle.main.path(forResource: "applstockinfo", ofType: "json") {
            let url = URL.init(fileURLWithPath: path)
            if let data = try? Data.init(contentsOf: url) {
                do {
                    let stockDictonary = try JSONDecoder().decode([StockInfo].self, from: data)
                    stockPrices = stockDictonary
                } catch {
                    print(error)
                }
            }
        }
        
        
    }
}
extension StockViewController: UITableViewDataSource {
    
    //set the number of sections
    func numberOfSections(in tableView: UITableView) -> Int {
        //return StocksByMonth.count
    }
    
    //set the title for each section
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        //get the proper monthStocks
        return "Hello Stocks"
    }
    
    //set the number of rows for each section
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return stockPrices.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = stocksTableView.dequeueReusableCell(withIdentifier: "StockCell", for: indexPath)
        let stocksToSet = stockPrices[indexPath.row]
        cell.textLabel?.text = stocksToSet.date
        cell.detailTextLabel?.text = "$" + String(format: "%.2f", stocksToSet.open)
        return cell
    }
}
