//
//  MyGroupTableViewController.swift
//  UI_Vkontakte
//
//  Created by Михаил Подболотов on 05.01.2021.
//

import UIKit
import RealmSwift

class MyGroupTableViewController: UITableViewController, UISearchBarDelegate {

    @IBOutlet weak var searchBar: UISearchBar!
    
    var groups: [VKGroup]?
    var filterGroups: [VKGroup]?
    
    private var groupsRealm: Results<VKGroup>? {
        let groupsRealm: Results<VKGroup>? = realmManager?.getObjects()
        return groupsRealm?.sorted(byKeyPath: "name", ascending: true)
    }
    
    private let networkManager = NetworkService.shared
    private let realmManager = RealmManager.shared
    
    override func viewDidLoad() {
        super.viewDidLoad()

        searchBar.delegate = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
            super.viewWillAppear(animated)
            
        if realmManager!.phoneOnLine {
            NetworkService.loadGroups(token: token) { [weak self] (groupResponse) in
                self?.groups = groupResponse.response.items
                
                guard let groups = self?.groups else { return }
                
                self?.filterGroups = self?.groups
                
                DispatchQueue.main.async {
                    try? self?.realmManager?.add(objects: groups)
                    self?.tableView.reloadData()
                }
            }
        } else {
            guard groupsRealm != nil || groupsRealm?.count ?? 0 > 0 else { return }
            var tempArr = [VKGroup]()
            for group in groupsRealm! {
                tempArr.append(group)
            }
            self.filterGroups = tempArr
            
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }

    // MARK: - Table view data source
//    override func numberOfSections(in tableView: UITableView) -> Int {
//        // #warning Incomplete implementation, return the number of sections
//        return 0
//    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows

        return filterGroups?.count ?? 0
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as? MyGroupTableViewCell {
            
            if let filterGroups = filterGroups {
                cell.myGroupLabel.text = filterGroups[indexPath.row].name
                cell.downLoadImage(from: filterGroups[indexPath.row].photo50)
            }
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
            if realmManager!.phoneOnLine {
                groups?.remove(at: indexPath.row)
                filterGroups?.remove(at: indexPath.row)
                tableView.deleteRows(at: [indexPath], with: .fade)
            } else {
                try? realmManager?.delete(object: (filterGroups?[indexPath.row])!)
                filterGroups?.remove(at: indexPath.row)
                tableView.deleteRows(at: [indexPath], with: .fade)
            }
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }
    }

    @IBAction func unwindFromTableViewController (_ segue: UIStoryboardSegue) {
        
        guard let tableViewController = segue.source as? AllGroupsTableViewController,
              let indexPath = tableViewController.tableView.indexPathForSelectedRow else { return }

//        let group = tableViewController.groups[indexPath.row]

//        if groups.contains(group) { return }
//        groups?.append(group)
//        filterGroups?.append(group)
        tableView.reloadData()
    }
    
    // MARK: - Search Bar Config
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        filterGroups = []
        
        if searchText == "" {
            filterGroups = groups
        } else {
            for group in groups! {
                if group.name.lowercased().contains(searchText.lowercased()) {
                    filterGroups?.append(group)
                }
            }
        }
        self.tableView.reloadData()
    }
}
    

