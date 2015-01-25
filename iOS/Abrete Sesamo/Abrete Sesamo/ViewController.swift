//
//  ViewController.swift
//  Abrete Sesamo
//
//  Created by Marcio Klepacz on 18/01/15.
//  Copyright (c) 2015 Marcio Klepacz. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector:"openOnDesktop", name:
            UIApplicationWillEnterForegroundNotification, object: nil)
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func openOnDesktop(){
        if let copyedStuff = UIPasteboard.generalPasteboard().string {
            println(" \(copyedStuff) copied from pastboard")
            if validateUrl(copyedStuff) {
                println("Message sent !")
                Messanger.sharedInstance.send(copyedStuff)
            }
        }
    }
    
    
    func validateUrl (stringURL : NSString) -> Bool {
        var urlRegEx = "(http|https)://((\\w)*|([0-9]*)|([-|_])*)+([\\.|/]((\\w)*|([0-9]*)|([-|_])*))+"
        let predicate = NSPredicate(format:"SELF MATCHES %@", argumentArray:[urlRegEx])
        var urlTest = NSPredicate.predicateWithSubstitutionVariables(predicate)
        
        return predicate.evaluateWithObject(stringURL)
    }
}

