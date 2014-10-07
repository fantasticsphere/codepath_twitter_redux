//
//  DrawerMenuViewController.swift
//  Twitter
//
//  Created by Paul Lo on 10/6/14.
//  Copyright (c) 2014 Paul Lo. All rights reserved.
//

import UIKit

class DrawerMenuViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet weak var menuTableView: UITableView!
    
    var menuItemSpec = [
        "profile": [
            "name": "My Profile"
        ],
        "home_timeline": [
            "name": "Home Timeline"
        ],
        "mentions": [
            "name": "Mentions"
        ]

    ]
    var menuItemOrder = ["profile", "home_timeline", "mentions"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.menuTableView.delegate = self
        self.menuTableView.dataSource = self
        self.menuTableView.rowHeight = UITableViewAutomaticDimension
    }

    func tableView(tableView: UITableView, estimatedHeightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 70.0
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return menuItemOrder.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCellWithIdentifier("DrawerMenuItemCell") as DrawerMenuItemCell
        var name = self.menuItemSpec[menuItemOrder[indexPath.row]]!["name"]!
        cell.menuItemLabel.text = name
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        switch menuItemOrder[indexPath.row] {
            case "profile":
                var profileNavigationController = self.storyboard!.instantiateViewControllerWithIdentifier("profileNavigationController") as UINavigationController
                var profileViewController = profileNavigationController.viewControllers[0] as ProfileViewController
                profileViewController.user = User.currentUser
                self.mm_drawerController.setCenterViewController(profileNavigationController, withFullCloseAnimation: true, completion: nil)
            case "home_timeline":
                var tweetsNavigationController = self.storyboard?.instantiateViewControllerWithIdentifier("TweetsNavigationViewController") as UINavigationController
                var tweetsViewController = tweetsNavigationController.viewControllers[0] as TweetsViewController
                tweetsViewController.tweetsFilter = .HomeTimeline
                tweetsViewController.navigationItem.title = "Home"
                self.mm_drawerController.setCenterViewController(tweetsNavigationController, withFullCloseAnimation: true, completion: nil)
            case "mentions":
                var tweetsNavigationController = self.storyboard?.instantiateViewControllerWithIdentifier("TweetsNavigationViewController") as UINavigationController
                var tweetsViewController = tweetsNavigationController.viewControllers[0] as TweetsViewController
                tweetsViewController.tweetsFilter = .Mentions
                tweetsViewController.navigationItem.title = "Mentions"
                self.mm_drawerController.setCenterViewController(tweetsNavigationController, withFullCloseAnimation: true, completion: nil)
            default:
                break
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue!, sender: AnyObject!) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
