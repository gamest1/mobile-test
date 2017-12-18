//
//  ViewController.swift
//  EstebanTest
//
//  Created by Esteban on 2017-11-09.
//  Copyright © 2017 Transcriptics. All rights reserved.
//

import UIKit

class CategoriesTableVC: UITableViewController {
    
    var categories = [Category]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loadData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.setNavigationBarHidden(true, animated: true)
    }
    
    func loadData() {
        guard let path = Bundle.main.path(forResource: "categories", ofType: "json"),
            let data = try? Data(contentsOf: URL(fileURLWithPath: path), options: .alwaysMapped),
            let jsonObj = try? JSONSerialization.jsonObject(with: data, options: [])
            else { return }
        
        categories = Category.categoriesFromArray(array: jsonObj as! NSArray)
        
        tableView.reloadData()
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return categories.count
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "CATEGORIES"
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = Constants.friendlyDateFormat
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "CategoryCell", for: indexPath)
        cell.textLabel?.text = categories[indexPath.row].title
        cell.detailTextLabel?.text = dateFormatter.string(from: categories[indexPath.row].updated_at)
        
        return cell
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let cell = sender as? UITableViewCell {
            let i = self.tableView.indexPath(for: cell)!.row
            if segue.identifier == "ToResources" {
                let vc = segue.destination as! ResourcesTableVC
                vc.sourceURL = categories[i].type.lowercased()
            }
        }
    }
}

