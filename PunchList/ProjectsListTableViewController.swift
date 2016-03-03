//
//  ProjectsListTableViewController.swift
//  PunchList
//
//  Created by Andrew Porter on 12/2/15.
//  Copyright © 2015 Andrew Porter. All rights reserved.
//

import UIKit

class ProjectsListTableViewController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
//        if UserController.sharedController.currentUser == nil {
//            
//            performSegueWithIdentifier("loginscreen", sender: nil)
//
//        }

    }
    
    override func viewWillAppear(animated: Bool) {
        tableView.reloadData()
    }
    
    // MARK: - TableView Data Source methods
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return ProjectController.sharedController.projectsArray.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("projectCell", forIndexPath: indexPath)
        
        let project = ProjectController.sharedController.projectsArray[indexPath.row]
        
        cell.textLabel?.text = project.name
        
        return cell
    }
    
    // MARK: - Buttons
    
//    @IBAction func logoutButtonTapped(sender: AnyObject) {
//        
//        UserController.logoutCurrentUser()
//        performSegueWithIdentifier("loginscreen", sender: nil)
//    }

    // MARK: - Navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "toBuildingList" {
            let destinationViewController = segue.destinationViewController as? BuildingListTableViewController
            
            if let indexPath = tableView.indexPathForSelectedRow {
                let project = ProjectController.sharedController.projectsArray[indexPath.row]
                destinationViewController?.project = project
            }
        }
    }
}
