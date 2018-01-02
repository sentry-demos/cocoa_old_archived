//
//  ViewController.swift
//  sentry-ios-cocoapods
//
//  Created by Daniel Griesser on 18.07.17.
//  Copyright © 2017 Sentry. All rights reserved.
//

import UIKit
import Sentry

class ViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        do {
            Client.shared = try Client(dsn: "https://4b5132d21b6d4470a6083c7048950eea:a192729380d84a71b97c0b74b435c4ee@sentry.io/265601")
            try Client.shared?.startCrashHandler()
            Client.logLevel = .verbose
            Client.shared?.tags = ["a": "b"]
            Client.shared?.extra = ["c": "d"]
            let user = User(userId: "1234")
            user.email = email.text!
            Client.shared?.user = user
        } catch let error {
            print("\(error)")
            // Wrong DSN or KSCrash not installed
        }
        Client.shared?.enableAutomaticBreadcrumbTracking()
    }
    
    @IBAction func sendMessage(_ sender: Any) {
        let event = Event(level: .debug)
        event.message = "Runtime Error"
        Client.shared?.send(event: event) { (error) in
            // Optional callback after event has been send
        }
    }
    
    @IBAction func causeCrash(_ sender: Any) {
        Client.shared?.crash()
    }
    
    @IBOutlet weak var display: UITextView!
    
    @IBOutlet weak var email: UITextField!
    
    @IBAction func submit(_ sender: Any) {
        display.text = "Hello, " + email.text! + "!"
        let user = User(userId: "6789")
        user.email = email.text!
        Client.shared?.user = user
    }
}

