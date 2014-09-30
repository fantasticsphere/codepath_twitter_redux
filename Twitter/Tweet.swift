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
    
    var secondsCreated: Double? {
        if self.createdAt != nil {
            return -self.createdAt!.timeIntervalSinceNow
        }
        return nil
    }
    
    var timeLapsedCreatedString: String {
        if var seconds = self.secondsCreated {
            var days = Int(seconds / 3600.0 / 24.0)
            if days > 7 {
                var formatter = NSDateFormatter()
                formatter.dateFormat = "M/d/yy"
                return formatter.stringFromDate(self.createdAt!)
            }
            if days >= 1 {
                return "\(days)d"
            }
            var hours = Int(seconds / 3600.0)
            if hours >= 1 {
                return "\(hours)h"
            }
            var minutes = Int(seconds / 60.0)
            return "\(minutes)m"
        }
        return ""
    }
    
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
