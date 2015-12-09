//
//  ChannelJsonReader.swift
//  LiveTVStream
//
//  Created by Markus Schalk on 22.11.15.
//  Copyright © 2015 Markus Schalk. All rights reserved.
//

import Foundation

class ChannelJsonReader {
    
    func load()->[Channel] {
        var channels:[Channel] = []
        if let filePath = NSBundle.mainBundle().pathForResource("tvstreams", ofType:"json") {
            do {
                let data = try NSData(contentsOfURL: NSURL(fileURLWithPath: filePath), options: NSDataReadingOptions.DataReadingMappedIfSafe)
                if let jsonResult:NSDictionary = try NSJSONSerialization.JSONObjectWithData(data, options: NSJSONReadingOptions.MutableContainers) as? NSDictionary {
                    if let items:NSArray = jsonResult["channels"] as? NSArray {
                        for item:NSDictionary in items as! [Dictionary<String, AnyObject>] {
                            if let name = item["name"] as? String {
                                if let urlString = item["url"] as? String {
                                    if let channel = ChannelFactory.createChannel(name, urlString: urlString) {
                                        channels.append(channel)
                                    }
                                }
                            }
                        }
                    }
                }
            }
            catch _ as NSError {
            }
        }
        return channels
    }
}