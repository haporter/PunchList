//
//  PunchListTableViewController.swift
//  PunchList
//
//  Created by Andrew Porter on 2/16/16.
//  Copyright © 2016 Andrew Porter. All rights reserved.
//

import UIKit

class PunchListTableViewController: UITableViewController {
    
    var building: Building?
    var punchList: PunchList?
    var unit: Int?

    override func viewDidLoad() {
        super.viewDidLoad()

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    // MARK: - TableView Data Source methods
//    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
//        if let punchList = punchList, categories = punchList.categories {
//            return categories.count
//        } else {
//            return 0
//        }
//    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let punchList = self.punchList {
            return punchList.items.count
        } else {
            return 0
        }
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("punchItemCell", forIndexPath: indexPath)
        let punchItem = punchList?.items[indexPath.row]
        
        cell.textLabel?.text = punchItem?.itemDescription
        return cell
    }
    
    // MARK: - Buttons
    @IBAction func plusButtonTapped(sender: UIBarButtonItem) {
        addNewPunchItemWithAlertController()
    }
    
    // MARK: - Functions
    func addNewPunchItemWithAlertController() {
        let alert = UIAlertController(title: "Add New Punch Item", message: "Enter Punch description", preferredStyle: .Alert)
        alert.addTextFieldWithConfigurationHandler(nil)
        let cancelAction = UIAlertAction(title: "Cancel", style: UIAlertActionStyle.Cancel, handler: nil)
        let addAction = UIAlertAction(title: "Add", style: UIAlertActionStyle.Default) { (_) -> Void in
            if let textFields = alert.textFields, description = textFields[0].text, punchList = self.punchList {
                let punchItem = PunchItem(itemDescription: description, units: punchList.units)
                if let building = self.building, punchList = self.punchList {
                    ProjectController.sharedController.addPunchItemToPunchListForBuilding(building, punchList: punchList, punchItem: punchItem)
                    self.tableView.reloadData()
                }
                
            }
        }
        alert.addAction(addAction)
        alert.addAction(cancelAction)
    
        presentViewController(alert, animated: true, completion: nil)
    }
    
}
