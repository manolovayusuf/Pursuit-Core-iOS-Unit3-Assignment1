//
//  StockDetailedViewController.swift
//  PeopleAndAppleStockPrices
//
//  Created by Manny Yusuf on 12/11/18.
//  Copyright © 2018 Pursuit. All rights reserved.
//

import UIKit

class StockDetailedViewController: UIViewController {
    
    var stockDetailOfPerson: StockInfo!
    
    
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var stockImage: UIImageView!
    @IBOutlet weak var openLabel: UILabel!
    @IBOutlet weak var closeLabel: UILabel!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        updatedStockInfo()
        print(stockDetailOfPerson.date)
        
        
    }
    
    
    func updatedStockInfo() {
        dateLabel.text = stockDetailOfPerson.date
        openLabel.text = "$" + String(format: "%.2f", stockDetailOfPerson.open)
        closeLabel.text = "$" + String(format: "%.2f", stockDetailOfPerson.close)
        
        if stockDetailOfPerson.open < stockDetailOfPerson.close {
            stockImage.image = UIImage(named: "thumbsUp")
            self.view.backgroundColor = .green
        } else {
            stockImage.image = UIImage(named: "thumbsDown")
            self.view.backgroundColor = .red
        }
    }
}
