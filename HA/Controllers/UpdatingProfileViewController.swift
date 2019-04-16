//
//  UpdatingProfileViewController.swift
//  HA
//
//  Created by Mohammed Abouarab on 4/16/19.
//  Copyright © 2019 Mohammed Abouarab. All rights reserved.
//

import UIKit

class UpdatingProfileViewController: UIViewController {
    
    @IBOutlet weak var scrollView: UIScrollView!
    
    @IBOutlet weak var firstNameTextField: UITextField!
    @IBOutlet weak var LastNameTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var phoneNumberTextField: UITextField!
    @IBOutlet weak var updateButten: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        registerForKeyboardNotifications()
        updateButtonStatus ()
        navigationItem.title = "Update Profile"
        navigationItem.prompt = "Wellcome"
    }
    
    //MARK: - Fix the keyboard cover views & Dissmis the keyboard Issues
    
    //TODO: Get notification for keyboard shown and hidden
    func registerForKeyboardNotifications() {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWasShown(_:)), name: UIResponder.keyboardDidShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillBeHidden(_:)), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    //TODO: Adjust the Buttom of the view to be on top of keyboard
    @objc func keyboardWasShown(_ notificiation: NSNotification) {
        guard let info = notificiation.userInfo,
            let keyboardFrameValue =
            info[UIResponder.keyboardFrameBeginUserInfoKey] as? NSValue
            else { return }
        let keyboardFrame = keyboardFrameValue.cgRectValue
        let keyboardSize = keyboardFrame.size
        let contentInsets = UIEdgeInsets(top: 0.0, left: 0.0,
                                         bottom: keyboardSize.height, right: 0.0)
        scrollView.contentInset = contentInsets
        scrollView.scrollIndicatorInsets = contentInsets
    }
    //TODO: Adjust the Buttom of the view to be on the buttom edge
    @objc func keyboardWillBeHidden(_ notification: NSNotification) {
        let contentInsets = UIEdgeInsets.zero
        scrollView.contentInset = contentInsets
        scrollView.scrollIndicatorInsets = contentInsets
    }
    
    
    //MARK: - enable and disable updat Button
    @IBAction func firstName(_ sender: UITextField) {
        updateButtonStatus ()
    }
    @IBAction func lastName(_ sender: UITextField) {
        updateButtonStatus ()
    }
    @IBAction func email(_ sender: UITextField) {
        updateButtonStatus ()
    }
    @IBAction func phoneNumber(_ sender: UITextField) {
        updateButtonStatus ()
    }
    
    func updateButtonStatus () {
        if firstNameTextField.text?.isEmpty == false && LastNameTextField.text?.isEmpty == false && emailTextField.text?.isEmpty == false && phoneNumberTextField.text?.isEmpty == false && emailTextField.text?.contains("@") == true && emailTextField.text?.contains(".com") == true && (phoneNumberTextField.text?.count)! == 11 {
            updateButten.isEnabled = true
            updateButten.backgroundColor = #colorLiteral(red: 0.8, green: 0.2078431373, blue: 0.1803921569, alpha: 1)
        }
        else {
            updateButten.isEnabled = false
            updateButten.backgroundColor = #colorLiteral(red: 0.8, green: 0.2078431373, blue: 0.1803921569, alpha: 0.5)
        }
    }
    
    
}
