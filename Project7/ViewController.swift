//
//  ViewController.swift
//  Project7
//
//  Created by Anna Shark on 5/9/22.
//

import UIKit

class ViewController: UITableViewController {
    var petitions = [Petition]()
    var filteredPetitions = [Petition]()
    

    override func viewDidLoad() {
        super.viewDidLoad()
        let urlString: String
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Credits", style: .plain, target: self, action: #selector(creditsTapped))
        
        let searchButton   = UIBarButtonItem(barButtonSystemItem: .search, target: self, action: #selector(searchTapped))
        let undoButton = UIBarButtonItem(barButtonSystemItem: .undo, target: self, action: #selector(undoSearch))
        
        navigationItem.leftBarButtonItems = [searchButton, undoButton]
        
        
        if navigationController?.tabBarItem.tag == 0 {
            urlString = "https://www.hackingwithswift.com/samples/petitions-1.json"
            //"https://api.whitehouse.gov/v1/petitions.json?limit=100"
        } else {
            urlString = "https://www.hackingwithswift.com/samples/petitions-2.json" //"https://api.whitehouse.gov/v1/petitions.json?signatureCountFloor=10000&limit=100"
        }
        
        
        if let url = URL(string: urlString) {
            if let data = try? Data(contentsOf: url) {
                parse(json: data)
                return
            }
        }
        showError()
    }
    
    func showError() {
        let ac = UIAlertController(title: "Loading error", message: "There was a problem loading the feed, please check your connection and try again", preferredStyle: .alert)
        ac.addAction(UIAlertAction(title: "OK", style: .default))
        present(ac, animated: true)
    }
    
    func parse(json: Data) {
        let decoder = JSONDecoder()
        print("inside parse outside decoder.decode ")
        if let jsonPetitions = try? decoder.decode(Petitions.self, from: json) {
            print("inside parse decoder.decode ")
            petitions = jsonPetitions.results
            filteredPetitions = petitions
            tableView.reloadData()
        }
            
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filteredPetitions.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        let petition = filteredPetitions[indexPath.row]
        cell.textLabel?.text = petition.title
        cell.detailTextLabel?.text = petition.body
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = DetailViewController()
        vc.detailItem = filteredPetitions[indexPath.row]
        navigationController?.pushViewController(vc, animated: true)
    }
    
    @objc func creditsTapped() {
            let ac = UIAlertController(title: "Credits", message: "The data comes from the We The People API of the Whitehouse", preferredStyle: .alert)
            let action = UIAlertAction(title: "OK", style: .default)
            ac.addAction(action)
            present(ac,animated: true)
        
    }
    
    @objc func searchTapped() {
        let ac = UIAlertController(title: "Search in petitions' titles", message: nil, preferredStyle: .alert)
        ac.addTextField()
        
        let searchAction = UIAlertAction(title: "Show results", style: .default) {
            [weak self, weak ac] action in
            guard let searchItem = ac?.textFields?[0].text else {return}
                self?.search(searchItem)
        }
        
        ac.addAction(searchAction)
        present(ac,animated: true)
    }
    
    func search (_ searchItem: String) {
        print("call from search")
        filteredPetitions.removeAll()
        
        for petition in petitions {
            if petition.title.contains(searchItem) {
                filteredPetitions.append(petition)
            }
        }
        tableView.reloadData()
    }
    
    @objc func undoSearch() {
        filteredPetitions = petitions
        tableView.reloadData()
    }

    
}

