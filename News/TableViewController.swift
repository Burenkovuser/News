//
//  TableViewController.swift
//  News
//
//  Created by Vasilii on 26.11.2019.
//  Copyright © 2019 Vasilii Burenkov. All rights reserved.
//

import UIKit

class TableViewController: UITableViewController {
    
    //"https://chroniclingamerica.loc.gov/lccn/sn86069873.json"
    
    private let identifier = "cell"
    //    private var urlNews = "https://chroniclingamerica.loc.gov/lccn/sn86069873.json"
    //private var base = "https://chroniclingamerica.loc.gov/lccn/"
    //private var id = "sn86069873"
    //private var extention = ".json"
    
    
    
    var issues: [Issue] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchData()
    }
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return issues.count
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: identifier, for: indexPath)
        
        let issue = issues[indexPath.row]
        cell.textLabel?.text = issue.url
        cell.detailTextLabel?.text = issue.dateIssued

        
        return cell
    }
    
    func fetchData() {
        let urlString = "https://chroniclingamerica.loc.gov/lccn/"
            + "sn86069873"
            + ".json"
        
        guard let url = URL(string: urlString) else { return }
        
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            
            if let error = error {
                print(error.localizedDescription)
                return
            }
            if let response = response {
                print(response)
            }
            
            guard let data = data else { return }
            
            do {
                let welcome = try JSONDecoder().decode(Welcome.self, from: data)
                
                self.issues = welcome.issues
                
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
            } catch let error {
                print(error.localizedDescription)
            }
            
        }.resume()
    }

}
