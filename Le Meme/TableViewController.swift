//
//  TableViewController.swift
//  Le Meme
//
//  Created by Jesse on 8/6/17.
//  Copyright © 2017 Jesse. All rights reserved.
//

import UIKit

class TableViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var tableView: UITableView!
    
    let sectionTrump:[String] = ["Great Big Wall", "test"]
    let sectionKim:[String] = ["Nuclear Attack", "test"]
    let sectionPutin:[String] = ["Computer Hack", "test", "test2"]
    let sectionSheen:[String] = ["Sheenous", "10 pound Rock", "I'm a rockstar"]
    
    let userdefaults = UserDefaults()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.backgroundColor = UIColor.black
        tableView.separatorColor = UIColor.black
        
        self.tableView.delegate = self
        self.tableView.dataSource = self
        
        // self.clearsSelectionOnViewWillAppear = false
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }
    
    // MARK: - Table view data source
    
    func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 4
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return sectionTrump.count
        }
        else if section == 1 {
            return sectionKim.count
        }
        else if section == 2 {
            return sectionPutin.count
        }
        else {
            return sectionSheen.count
        }
    }
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if section == 0 {
            return "Donald Trump"
        }
        else if section == 1 {
            return "Kim Jung Wo"
        }
        else if section == 2 {
            return "Vladimir Putin"
        }
        else {
            return "Charlie Sheen"
        }
    }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if section == 0 {
            return 25
        }
        else {
            return 10
        }
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        if indexPath.section == 0 {
            cell.textLabel?.text = sectionTrump[indexPath.row]
        }
        else if indexPath.section == 1 {
            cell.textLabel?.text = sectionKim[indexPath.row]
        }
        else if indexPath.section == 2 {
            cell.textLabel?.text = sectionPutin[indexPath.row]
        }
        else {
            cell.textLabel?.text = sectionSheen[indexPath.row]
        }
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "main", sender: self)
    }
}
