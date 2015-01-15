//
//  ProfileViewController.swift
//  Twitter
//
//  Created by Paul Lo on 10/6/14.
//  Copyright (c) 2014 Paul Lo. All rights reserved.
//

import UIKit

class ProfileViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    var user: User?
    var tweets: [Tweet]? = []
    var refreshControl: UIRefreshControl? = UIRefreshControl()
    
    @IBOutlet weak var profileTableView: UITableView!
    @IBOutlet weak var headerBackgroundImageView: UIImageView!
    @IBOutlet weak var headerThumbnailView: UIImageView!
    @IBOutlet weak var headerNameLabel: UILabel!
    @IBOutlet weak var headerUserNameLabel: UILabel!
    
    enum ProfileSection: Int {
        case Stats = 0
        case Tweets = 1
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.profileTableView.delegate = self
        self.profileTableView.dataSource = self
        self.profileTableView.rowHeight = UITableViewAutomaticDimension

        if var user = self.user {
            self.navigationItem.title = (user == User.currentUser ? "Me" : user.name)

            if user.profileBackgroundImageUrl != nil {
                headerBackgroundImageView.setImageWithURL(NSURL(string: user.profileBackgroundImageUrl!))
            }
            if user.profileImageUrl != nil {
                headerThumbnailView.setImageWithURL(NSURL(string: user.profileImageUrl!))
            }
            headerNameLabel.text = user.name
            headerUserNameLabel.text = "@\(user.screenName!)"
        }

        self.refreshControl?.addTarget(self, action: "loadTweetsFromSource", forControlEvents: .ValueChanged)
        self.profileTableView.addSubview(self.refreshControl!)
        
        self.loadTweetsFromSource()
    }

    func loadTweetsFromSource() {
        TwitterClient.sharedInstance.userTimelineWithParams(["user_id": self.user!.userId!, "count": 20], completion: { (tweets, error) -> () in
            self.tweets = tweets
            if tweets != nil {
                for tweet in tweets! {
                    //println("tweet: \(tweet.text)")
                }
                println("Updated \(tweets!.count) rows")
                self.profileTableView.reloadData()
            }
            self.refreshControl!.endRefreshing()
        })
    }

    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(tableView: UITableView, estimatedHeightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 70.0
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch ProfileSection(rawValue: section)! {
        case .Stats:
            return 1
        case .Tweets:
            return self.tweets!.count
        default:
            return 0
        }
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        switch ProfileSection(rawValue: indexPath.section)! {
        case .Stats:
            var cell = tableView.dequeueReusableCellWithIdentifier("ProfileStatsCell") as ProfileStatsCell
            cell.statusesCountLabel.text = "\(self.user!.statusesCount!)"
            cell.friendsCountLabel.text = "\(self.user!.friendsCount!)"
            cell.followersCountLabel.text = "\(self.user!.followersCount!)"

            return cell
        case .Tweets:
            var cell = tableView.dequeueReusableCellWithIdentifier("TweetCell") as TweetCell
            var tweet = self.tweets?[indexPath.row]
            cell.updateCellWithTweet(tweet)
            return cell
        }
    }
    
    @IBAction func onLeftDrawerToggle(sender: AnyObject) {
        self.mm_drawerController.toggleDrawerSide(.Left, animated: true, completion: nil)
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
