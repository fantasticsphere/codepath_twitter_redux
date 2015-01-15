//
//  ReplyViewController.swift
//  Twitter
//
//  Created by Paul Lo on 9/30/14.
//  Copyright (c) 2014 Paul Lo. All rights reserved.
//

import UIKit

class ReplyViewController: UIViewController {

    var recipient: User?
    var originalTweet: Tweet?
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var replyTextView: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.nameLabel.text = self.recipient?.name
        
        // Do any additional setup after loading the view.
        replyTextView.layer.borderWidth = 1.0
        replyTextView.layer.borderColor = UIColor.grayColor().CGColor
        replyTextView.text = "@\(recipient!.screenName!) "
        
        self.automaticallyAdjustsScrollViewInsets = false
    }

    @IBAction func doCancel(sender: AnyObject) {
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    @IBAction func doSend(sender: AnyObject) {
        if !replyTextView.text.isEmpty {
            TwitterClient.sharedInstance.updateWithParams(["status": replyTextView.text, "in_reply_to_status_id": self.originalTweet!.statusId!], completion: { (tweet, error) -> () in
                if tweet != nil {
                    println("Replied: \(tweet)")
                }
            })

        }
        dismissViewControllerAnimated(true, completion: nil)
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
