//
//  TweetViewController.swift
//  Twitter
//
//  Created by Paul Lo on 9/29/14.
//  Copyright (c) 2014 Paul Lo. All rights reserved.
//

import UIKit

class TweetViewController: UIViewController {

    var tweet: Tweet?
    
    @IBOutlet weak var thumbnailView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var screenNameLabel: UILabel!
    @IBOutlet weak var tweetTextLabel: UILabel!
    @IBOutlet weak var timestampLabel: UILabel!
    @IBOutlet weak var retweetButton: UIButton!
    @IBOutlet weak var favoriteButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        if let url = tweet?.user?.profileImageUrl {
            self.thumbnailView.setImageWithURL(NSURL(string: url))
        }
        self.nameLabel.text = tweet?.user?.name
        var screenName = tweet?.user?.screenName
        self.screenNameLabel.text = screenName != nil ? "@\(screenName!)" : ""
        self.tweetTextLabel.text = tweet?.text

        var formatter = NSDateFormatter()
        formatter.dateFormat = "M/d/yy hh:mm:ss a"
        self.timestampLabel.text = formatter.stringFromDate(tweet!.createdAt!)
        
        self.refreshRetweetButton()
        self.refreshFavoriteButton()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    func refreshRetweetButton() {
        if self.tweet?.retweeted ?? false {
            self.retweetButton.setImage(UIImage(named: "retweeted"), forState: .Normal)
        } else {
            self.retweetButton.setImage(UIImage(named: "retweet"), forState: .Normal)
            
        }
    }

    @IBAction func toggleRetweet(sender: AnyObject) {
        self.tweet?.retweeted = !(self.tweet?.retweeted ?? false)
        self.refreshRetweetButton()
    }

    func refreshFavoriteButton() {
        if self.tweet?.favorited ?? false {
            self.favoriteButton.setImage(UIImage(named: "favorited"), forState: .Normal)
        } else {
            self.favoriteButton.setImage(UIImage(named: "favorite"), forState: .Normal)
        }
    }

    @IBAction func toggleFavorite(sender: AnyObject) {
        self.tweet?.favorited = !(self.tweet?.favorited ?? false)
        self.refreshFavoriteButton()
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject!) {
        if segue.identifier == "replySegue" {
            var replyNavigationController = segue.destinationViewController as UINavigationController
            var replyViewController = replyNavigationController.viewControllers[0] as ReplyViewController
            replyViewController.recipient = self.tweet?.user
        }
    }
    
}
