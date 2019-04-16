//
//  ContactUsViewController.swift
//  HA
//
//  Created by Mohammed Abouarab on 4/11/19.
//  Copyright © 2019 Mohammed Abouarab. All rights reserved.
//

import UIKit

class ContactUsViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "CONTACT US"
        navigationItem.prompt = "Welcome"
    }
    
    @IBAction func firstNumberForCalling(_ sender: UIButton) {
        if #available(iOS 10.0, *) {
            UIApplication.shared.open(URL(string: "telprompt://\(+2010900733)")!)
            print("1")
        } else {
            // Fallback on earlier versions
            UIApplication.shared.openURL(URL(string: "telprompt://\(+2010900733)")!)
            print("2")
        }
    }
    @IBAction func secondNumberForCalling(_ sender: UIButton) {
        if #available(iOS 10.0, *) {
            UIApplication.shared.open(URL(string: "telprompt://\(+2010900733)")!)
            print("3")
        } else {
            // Fallback on earlier versions
            UIApplication.shared.openURL(URL(string: "telprompt://\(+2010900733)")!)
            print("4")
        }
    }
    
}
