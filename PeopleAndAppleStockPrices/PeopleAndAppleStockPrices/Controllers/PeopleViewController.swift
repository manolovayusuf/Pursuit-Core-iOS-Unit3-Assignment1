//
//  ViewController.swift
//  PeopleAndAppleStockPrices
//
//  Created by Alex Paul on 12/7/18.
//  Copyright © 2018 Pursuit. All rights reserved.
//

import UIKit

class PeopleViewController: UIViewController {

    var contacts = [resultsWrapper]()
    var sortedContacts = [resultsWrapper]() {
        didSet {
            DispatchQueue.main.async {
                self.peopleTableView.reloadData()
            }
        }
    }
    
    @IBOutlet weak var peopleTableView: UITableView!
    @IBOutlet weak var searchBar: UISearchBar!
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let contactsIndexPath = peopleTableView.indexPathForSelectedRow,
            let contactDetails = segue.destination as? PeopleDetailedViewController else { return }
        let peopleContacts = sortedContacts[contactsIndexPath.row]
        contactDetails.contactDetailOfPerson = peopleContacts
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        peopleTableView.dataSource = self
        searchBar.delegate = self
        loadData()
    }
    func loadData() {
        if let path = Bundle.main.path(forResource: "userinfo", ofType: "json") {
            let url = URL.init(fileURLWithPath: path)
            if let data = try? Data.init(contentsOf: url) {
                do {
                    let contactDictionary = try JSONDecoder().decode(ContactInfo.self, from: data)
                   contacts = contactDictionary.results
                    sortedContacts = contacts.sorted(by: {$0.name.last < $1.name.last})
                } catch {
                    print("type: \(error)")
                }
            }
        }
    }
}

extension PeopleViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return sortedContacts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = peopleTableView.dequeueReusableCell(withIdentifier: "PeopleCell", for: indexPath)
        let contactsToSet = sortedContacts[indexPath.row]
        guard let image = URL.init(string: contactsToSet.picture.thumbnail) else { return UITableViewCell()}
        do {
            let data = try Data.init(contentsOf: image)
                cell.imageView?.image = UIImage.init(data: data)
        } catch {
            print(error)
        }
        cell.textLabel?.text = contactsToSet.name.fullName
        cell.detailTextLabel?.text = contactsToSet.location.state.capitalized
        return cell
    }
}

extension PeopleViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        guard let searchText = searchBar.text else { return }
        sortedContacts = sortedContacts.filter { $0.name.fullName.contains(searchText) }
        searchBar.resignFirstResponder()
    }
}
