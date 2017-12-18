//
//  ResourcesTableVC.swift
//  EstebanTest
//
//  Created by Esteban on 2017-11-09.
//  Copyright © 2017 Transcriptics. All rights reserved.
//

import UIKit

class ResourcesTableVC: UITableViewController {
    var sourceURL : String!
    var resources = [Resource]()
    var sortingDirection = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadData()
        let sortItem = UIBarButtonItem(title: "Sort", style: .plain, target: self, action: #selector(sortList))
        self.navigationItem.rightBarButtonItem = sortItem;
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.setNavigationBarHidden(false, animated: true)
    }
    
    func loadData() {
        guard   let path = Bundle.main.path(forResource: sourceURL, ofType: "json"),
                let data = try? Data(contentsOf: URL(fileURLWithPath: path), options: .alwaysMapped),
                let jsonObj = try? JSONSerialization.jsonObject(with: data, options: [])
                else { return }
        
        resources = Resource.resourcesFromArray(array: jsonObj as! NSArray)
        sortList()
    }
    
    func sortList() {
        if sortingDirection {
            sortingDirection = false
            resources = resources.sorted { $0.title > $1.title }
        } else {
            sortingDirection = true
            resources = resources.sorted { $0.title < $1.title }
        }
        tableView.reloadData()
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return resources.count
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return sourceURL.uppercased()
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = Constants.friendlyDateFormat
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "ResourceCell", for: indexPath)
        cell.textLabel?.text = resources[indexPath.row].title
        cell.detailTextLabel?.text = dateFormatter.string(from: resources[indexPath.row].updated_at)
        
        return cell
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let cell = sender as? UITableViewCell {
            let i = self.tableView.indexPath(for: cell)!.row
            if segue.identifier == "ToDetails" {
                let vc = segue.destination as! ResourceDetailTableVC
                vc.resource = resources[i]
            }
        }
    }
    
}


