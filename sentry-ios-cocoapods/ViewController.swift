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
        
        let backgroundImage = UIImageView(frame: UIScreen.main.bounds)
        backgroundImage.image = UIImage(named: "sentry-pattern.png")
        backgroundImage.contentMode = UIViewContentMode.scaleAspectFill
        self.view.insertSubview(backgroundImage, at: 0)
    }
    
    @IBAction func sendMessage(_ sender: Any) {
        let event = Event(level: .debug)
        event.message = "Runtime Error [User sent event]"
        Client.shared?.send(event: event) { (error) in
            // Optional callback after event has been sent
        }
    }
    
    @IBAction func causeCrash(_ sender: Any) {
        Client.shared?.crash()
        //fatalError()
    }
    
    
    @IBAction func causeRuntimeException(_ sender: Any) /*throws*/ {
        //Index out of rang exception
        var listOfNumbers = [1, 2, 3]
        print(listOfNumbers[4])
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

