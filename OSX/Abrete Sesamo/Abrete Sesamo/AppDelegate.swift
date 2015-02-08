//
//  AppDelegate.swift
//  Abrete Sesamo
//
//  Created by Marcio Klepacz on 25/01/15.
//  Copyright (c) 2015 Marcio Klepacz. All rights reserved.
//

import Cocoa

@NSApplicationMain
class AppDelegate: NSObject, NSApplicationDelegate {
    
    let pubNub: PubNub = PubNub.connectingClientWithConfiguration(PNConfiguration.defaultConfiguration(), andSuccessBlock: { origin -> Void in
        
        println("Connected to \(origin)")
        
    }) { error -> Void in
        
        println("Error \(error)")
        
    }


    func applicationDidFinishLaunching(aNotification: NSNotification) {
        // Insert code here to initialize your application
        self.pubNub.setDelegate(self)
        self.pubNub.connect()
        let channel = [PNChannel.channelWithName("shalom", shouldObservePresence: true)]
        
        self.pubNub.setClientIdentifier("Cito Mac Book")
        self.pubNub.subscribeOn(channel)
    }

    func applicationWillTerminate(aNotification: NSNotification) {
        // Insert code here to tear down your application
    }

}

extension AppDelegate: PNDelegate {
    func pubnubClient(client: PubNub!, didSubscribeOn channelObjects: [AnyObject]!) {
        println("PubNub client successfully subscribed on channels: \(channelObjects)")
    }
    
    func pubnubClient(client: PubNub!, didReceiveMessage pubNubMessage: PNMessage!) {
        println("message received: \(pubNubMessage.message)")
        
        if let message = pubNubMessage.message as? NSDictionary {
            
            if let url = message.objectForKey("url") as? String {
                
                if let browser = message.objectForKey("browser") as? String {
                    
                    let task = NSTask()
                    task.launchPath = "/usr/bin/open"
                    
                    switch browser {
                    case "Chrome":
                        task.arguments = ["-a", "Google Chrome", url]
                    case "Safari":
                        task.arguments = ["-a", "Safari", url]
                    case "Firefox":
                        task.arguments = ["-a", "Firefox", url]
                    default:
                        println("Unable to find the browser")
                    }
                    
                    task.launch()
                }
            }
        }
    }
    
}

