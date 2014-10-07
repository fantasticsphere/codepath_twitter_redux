//
//  TweetCell.swift
//  Twitter
//
//  Created by Paul Lo on 9/29/14.
//  Copyright (c) 2014 Paul Lo. All rights reserved.
//

import UIKit

class TweetCell: UITableViewCell {

    var tweet: Tweet?
    
    @IBOutlet weak var thumbnailView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var screenNameLabel: UILabel!
    @IBOutlet weak var tweetTextLabel: UILabel!
    @IBOutlet weak var timeLapsedLabel: UILabel!
    @IBOutlet weak var thumbnailButtonView: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    @IBAction func onThumbnailTap(sender: AnyObject) {
        if var drawerController = self.window?.rootViewController as? MMDrawerController {
            var storyboard = UIStoryboard(name: "Main", bundle: nil)
            var profileNavigationController = storyboard.instantiateViewControllerWithIdentifier("profileNavigationController") as UINavigationController
            var profileViewController = profileNavigationController.viewControllers[0] as ProfileViewController
            profileViewController.user = self.tweet?.user
            drawerController.openDrawerSide(.Left, animated: true, completion: { (open: Bool) -> Void in
                drawerController.setCenterViewController(profileNavigationController, withFullCloseAnimation: true, completion: { (result: Bool) -> Void in
                    drawerController.closeDrawerAnimated(true, completion: nil)
                })
            })
        }
    }
    
    func updateCellWithTweet(tweet: Tweet?) {
        var cell = self
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
    }
}
