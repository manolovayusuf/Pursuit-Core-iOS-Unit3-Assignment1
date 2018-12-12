//
//  PeopleDetailedViewController.swift
//  PeopleAndAppleStockPrices
//
//  Created by Manny Yusuf on 12/11/18.
//  Copyright © 2018 Pursuit. All rights reserved.
//

import UIKit

class PeopleDetailedViewController: UIViewController {

    var contactDetailOfPerson: resultsWrapper!
    
    @IBOutlet weak var personImage: UIImageView!
    @IBOutlet weak var personName: UILabel!
    @IBOutlet weak var personEmail: UILabel!
    @IBOutlet weak var personLocation: UILabel!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updatedContactInfo()
        do {
            let imageInfo = try Data(contentsOf: contactDetailOfPerson.picture.large)
            personImage.image = UIImage(data: imageInfo)
        } catch {
            print("wrong")
        }
    }
    
    func updatedContactInfo() {
        personName.text = contactDetailOfPerson.name.fullName
        personEmail.text = contactDetailOfPerson.email
        personLocation.text = contactDetailOfPerson.location.city
    }
}
