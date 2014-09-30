//
//  NewTweetViewController.swift
//  Twitter
//
//  Created by Paul Lo on 9/29/14.
//  Copyright (c) 2014 Paul Lo. All rights reserved.
//

import UIKit

class NewTweetViewController: UIViewController {

    @IBOutlet weak var tweetTextView: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        tweetTextView.layer.borderWidth = 1.0
        tweetTextView.layer.borderColor = UIColor.grayColor().CGColor
        
        self.automaticallyAdjustsScrollViewInsets = false
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func onCancel(sender: AnyObject) {
        dismissViewControllerAnimated(true, completion: nil)
    }

    @IBAction func onDone(sender: AnyObject) {
        if !tweetTextView.text.isEmpty {
            TwitterClient.sharedInstance.updateWithParams(["status": tweetTextView.text], completion: { (tweet, error) -> () in
                if tweet != nil {
                    println("Created tweet: \(tweet)")
                }
            })
        }
        dismissViewControllerAnimated(true, completion: nil)
    }
    
}
