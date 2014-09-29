//
//  Tweet.swift
//  Twitter
//
//  Created by Paul Lo on 9/29/14.
//  Copyright (c) 2014 Paul Lo. All rights reserved.
//

import UIKit

class Tweet: NSObject {
   
    var user: User?
    var text: String?
    var createdAtString: String?
    var createdAt: NSDate?
    
    init(dictionary: NSDictionary) {
        self.user = User(dictionary: dictionary["user"] as NSDictionary)
        self.text = dictionary["text"] as? String
        self.createdAtString = dictionary["created_at"] as? String
        var formatter = NSDateFormatter()
        formatter.dateFormat = "EEE MMM d HH:mm:ss Z y"
        self.createdAt = formatter.dateFromString(self.createdAtString!)
    }
    
    class func tweetWithArray(array: [NSDictionary]) -> [Tweet] {
        var tweets = [Tweet]()
        for dictionary in array {
            tweets.append(Tweet(dictionary: dictionary))
        }
        return tweets
    }
}
