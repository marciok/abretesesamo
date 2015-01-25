//
//  Messanger.swift
//  Abrete Sesamo
//
//  Created by Marcio Klepacz on 25/01/15.
//  Copyright (c) 2015 Marcio Klepacz. All rights reserved.
//

import Foundation


struct MessangerProvider {
    
    let name: String
    let pubNub: PubNub?
    
    init(name: String) {
        self.name = name
        
        switch self.name {
        case "PubNub" :
           self.pubNub = PubNub.connectingClientWithConfiguration(PNConfiguration.defaultConfiguration(), andSuccessBlock: { origin in
            println("Connected to \(origin)")
            
            }) { error in println("Error \(error)") }
        default:
            println("Messanger provider not supoported")
            //Should Crash
        }

        
    }
    
    // Sends with the right provider
    func send(message: AnyObject) {
        switch self.name {
        case "PubNub" :
            if let pubNub = self.pubNub {
                pubNub.sendMessage(message, toChannel: PNChannel.channelWithName("shalom") as PNChannel);
            }

        default:
            println("Messanger provider not supoported")
            //Should Crash
        }

        
    }
    
}



struct Messanger {
    
    let provider: MessangerProvider
    
    static var sharedInstance : Messanger {
        struct Static {
            static let instance : Messanger = Messanger(providerClass: PubNub.self)
        }
        
        return Static.instance
    }
    
    init (providerClass: AnyClass) {
        self.provider = MessangerProvider(name: providerClass.description())
    }
    
    
    func send(message: AnyObject){
        self.provider.send(message)
    }
    
}

