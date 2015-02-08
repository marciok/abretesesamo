//
//  ViewController.swift
//  Abrete Sesamo
//
//  Created by Marcio Klepacz on 18/01/15.
//  Copyright (c) 2015 Marcio Klepacz. All rights reserved.
//

import UIKit

enum SupportedBrowsers: String {
    case Chrome = "Chrome"
    case Safari = "Safari"
    case Firefox = "Firefox"
}

class SelectBrowserViewController: UIViewController {
    
    
    @IBOutlet weak var chromeButton: UIButton?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector:"openOnDesktop:browser", name:
            UIApplicationWillEnterForegroundNotification, object: nil)
        
       self.setupImages()
    }
    
    func setupImages() {

        
    }
    
    override func viewDidLayoutSubviews() {
 
    }
    
    override func prefersStatusBarHidden() -> Bool{
        return true
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func openOnDesktop(browser: SupportedBrowsers = SupportedBrowsers.Chrome){
        
        if let copyedStuff = UIPasteboard.generalPasteboard().string {
            println(" \(copyedStuff) copied from pastboard")
            
            //if validateUrl(copyedStuff) {
                println("Message sent !")
                // Fixed with Chrome
                
                let message = ["url": copyedStuff, "browser": browser.rawValue]
                
                Messanger.sharedInstance.send(message)
            //}
        }
    }
    
    @IBAction func firefoxTapped(sender: UIButton) {
        openOnDesktop(browser: SupportedBrowsers.Firefox)
    }
    @IBAction func safariTapped(sender: UIButton) {
        openOnDesktop(browser: SupportedBrowsers.Safari)
    }
    @IBAction func chromeTapped(sender: UIButton) {
        openOnDesktop(browser: SupportedBrowsers.Chrome)
    }
    
    func validateUrl (stringURL : NSString) -> Bool {
        var urlRegEx = "(http|https)://((\\w)*|([0-9]*)|([-|_])*)+([\\.|/]((\\w)*|([0-9]*)|([-|_])*))+"
        let predicate = NSPredicate(format:"SELF MATCHES %@", argumentArray:[urlRegEx])
        var urlTest = NSPredicate.predicateWithSubstitutionVariables(predicate)
        
        return predicate.evaluateWithObject(stringURL)
    }
}

