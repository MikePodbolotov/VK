//
//  MyGroupTableViewController.swift
//  UI_Vkontakte
//
//  Created by Михаил Подболотов on 05.01.2021.
//

import UIKit

class MyGroupTableViewController: UITableViewController, UISearchBarDelegate {

    @IBOutlet weak var searchBar: UISearchBar!
    
    var groups: [String] = []
    
    var filterGroups: [String]!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        searchBar.delegate = self

        filterGroups = groups
        
    }

    // MARK: - Table view data source

//    override func numberOfSections(in tableView: UITableView) -> Int {
//        // #warning Incomplete implementation, return the number of sections
//        return 0
//    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows

        return groups.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as? MyGroupTableViewCell {
            cell.myGroupLabel.text = groups[indexPath.row]
            return cell
        }

        return UITableViewCell()
    }

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            groups.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }

    @IBAction func unwindFromTableViewController (_ segue: UIStoryboardSegue) {
        
        guard let tableViewController = segue.source as? AllGroupsTableViewController,
              let indexPath = tableViewController.tableView.indexPathForSelectedRow else { return }
        
        let group = tableViewController.groups[indexPath.row]
        
        if groups.contains(group) { return }
        
        groups.append(group)
        tableView.reloadData()
    }
    
    // MARK: - Search Bar Config
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        filterGroups = []
        
        if searchText == "" {
            filterGroups = groups
        } else {
            for group in groups {
                if group.lowercased().contains(searchText.lowercased()) {
                    filterGroups.append(group)
                }
            }
        }
        self.tableView.reloadData()
    }
}
    

