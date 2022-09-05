//
//  ViewController.swift
//  Project7
//
//  Created by Anna Shark on 5/9/22.
//

import UIKit

class ViewController: UITableViewController {
    var petitions = [Petition]()
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let urlString = "https://www.hackingwithswift.com/samples/petitions-1.json"
        //"http://api. whitehouse.gov/v1/petitions.jsons?limit=100"
        
        if let url = URL(string: urlString) {
            if let data = try? Data(contentsOf: url) {
                parse(json: data)
            }
        }
    }
    
    func parse(json: Data) {
        let decoder = JSONDecoder()
        print("inside parse outside decoder.decode ")
        if let jsonPetitions = try? decoder.decode(Petitions.self, from: json) {
            print("inside parse decoder.decode ")
            petitions = jsonPetitions.results
            tableView.reloadData()
        }
            
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return petitions.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        let petition = petitions[indexPath.row]
        cell.textLabel?.text = petition.title
        cell.detailTextLabel?.text = petition.body
        return cell
    }
    
}

