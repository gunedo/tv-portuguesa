//
//  Channel.swift
//  LiveTVStream
//
//  Created by Markus Schalk on 22.11.15.
//  Copyright © 2015 Markus Schalk. All rights reserved.
//

import Foundation
import UIKit

struct Channel {
    
    init(name: String, urlString: String)
    {
        self.name = name
        self.url = NSURL(string: urlString)!
    }
    
    private(set) var name: String
    private(set) var url: NSURL!
}