//
//  TweetsViewController.swift
//  Twitter
//
//  Created by Paul Lo on 9/29/14.
//  Copyright (c) 2014 Paul Lo. All rights reserved.
//

import UIKit

class TweetsViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    var tweets: [Tweet]?
    var refreshControl: UIRefreshControl? = UIRefreshControl()
    
    @IBOutlet weak var tweetsTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.tweetsTableView.delegate = self
        self.tweetsTableView.dataSource = self
        self.tweetsTableView.rowHeight = UITableViewAutomaticDimension

        self.refreshControl?.addTarget(self, action: "loadTweetsFromSource", forControlEvents: .ValueChanged)
        self.tweetsTableView.addSubview(self.refreshControl!)
        
        // Do any additional setup after loading the view.
        self.loadTweetsFromSource()
    }
    
    func loadTweetsFromSource() {
        TwitterClient.sharedInstance.homeTimelineWithParams(["count": 20], completion: { (tweets, error) -> () in
            self.tweets = tweets
            if tweets != nil {
                for tweet in tweets! {
                    //println("tweet: \(tweet.text)")
                }
                println("Updated \(tweets!.count) rows")
                self.tweetsTableView.reloadData()
            }
            self.refreshControl!.endRefreshing()
        })
    }

    func tableView(tableView: UITableView, estimatedHeightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 70.0
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.tweets?.count ?? 0
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCellWithIdentifier("TweetCell") as TweetCell
        var tweet = self.tweets?[indexPath.row]
        cell.tweet = tweet
        if var user = tweet?.user {
            if user.profileImageUrl != nil {
                cell.thumbnailView.setImageWithURL(NSURL(string: user.profileImageUrl!))
            }
            if user.name != nil {
                cell.nameLabel.text = user.name!
            } else {
                cell.nameLabel.text = ""
            }
            if user.screenName != nil {
                cell.screenNameLabel.text = "@\(user.screenName!)"
            } else {
                cell.screenNameLabel.text = ""
            }
        }
        if tweet?.text != nil {
            cell.tweetTextLabel.text = tweet?.text!
        } else {
            cell.tweetTextLabel.text = ""
        }
        cell.timeLapsedLabel.text = tweet?.timeLapsedCreatedString
        
        return cell
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func onLogout(sender: AnyObject) {
        User.currentUser?.logout()
    }

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject!) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        if segue.identifier == "tweetSegue" {
            if var cell = sender as? TweetCell {
                var tweetNavigationController = segue.destinationViewController as UINavigationController
                var tweetViewController = tweetNavigationController.viewControllers[0] as TweetViewController
                tweetViewController.tweet = cell.tweet
            }
            
        }
    }

}
