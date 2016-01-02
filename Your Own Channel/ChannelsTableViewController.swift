//
//  ChannelsTableViewController.swift
//  LiveTVStream
//
//  Created by Markus Schalk on 22.11.15.
//  Copyright © 2015 Markus Schalk. All rights reserved.
//

import Foundation
import UIKit
import AVKit
import AVFoundation

class ChannelsTableViewController: UITableViewController {
    
    var channels:[Channel] = []
    private let identifier = "ChannelCell"
    private let status = "status"
    private var index = 0
    private var playerItem:AVPlayerItem? = nil
    
    deinit {
        if let _ = playerItem {
            playerItem!.removeObserver(self, forKeyPath: status)
        }
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return channels.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier(identifier, forIndexPath: indexPath)
        cell.textLabel?.text = channels[indexPath.row].name
        return cell
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        splitViewController?.preferredDisplayMode = .PrimaryHidden
    }

    override func tableView(tableView: UITableView, didUpdateFocusInContext context: UITableViewFocusUpdateContext, withAnimationCoordinator coordinator: UIFocusAnimationCoordinator) {
        if let _ = (context.previouslyFocusedIndexPath?.row) {
            getAVPlayerViewController().player?.pause()
        }
        if let nextIndex = (context.nextFocusedIndexPath?.row) {
            playVideo(nextIndex)
        }
    }
    
    private func playVideo(index: Int) {
        if channels[index].url != nil {
            let playerViewController = getAVPlayerViewController()
            if playerItem != nil {
                playerItem!.removeObserver(self, forKeyPath: status)
            }
            playerItem = AVPlayerItem(URL: channels[index].url)
            playerItem!.addObserver(self, forKeyPath: status, options: .New, context: nil)
            let player = AVPlayer(playerItem: playerItem!)
            playerViewController.player = player
            playerViewController.player?.play()
        }
    }
    
    private func getAVPlayerViewController()->AVPlayerViewController {
        return splitViewController?.childViewControllers[1] as! AVPlayerViewController
    }

    override func observeValueForKeyPath(keyPath: String?, ofObject object: AnyObject?, change: [String : AnyObject]?, context: UnsafeMutablePointer<Void>) {
        if keyPath == status && playerItem!.status == AVPlayerItemStatus.Failed {
            let alert = UIAlertController(title: "Error", message: "Could not play stream! Check your internet connection! Maybe the stream is offline though!", preferredStyle: UIAlertControllerStyle.Alert)
            alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.Default, handler: nil))
            self.presentViewController(alert, animated: true, completion: nil)
        }
    }
}