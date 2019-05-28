//
//  ViewController.swift
//  HA
//
//  Created by Mohammed Abouarab on 4/6/19.
//  Copyright © 2019 Mohammed Abouarab. All rights reserved.
//

import UIKit
import SVProgressHUD

class ViewController: UIViewController {
    
    
    
    // MARK: - Outlets

    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var logo: UIView!
    @IBOutlet weak var signingView: UIView!
    @IBOutlet weak var signUpView: UIView!
    @IBOutlet weak var signInView: UIView!
    @IBOutlet weak var backgroundView: UIView!
    @IBOutlet weak var signingHeight: NSLayoutConstraint!
    @IBOutlet weak var signInEmailTextField: UITextField!
    @IBOutlet weak var signInPasswordTextField: UITextField!
    @IBOutlet weak var signUpFirstNameTextField: UITextField!
    @IBOutlet weak var signUpLastNameTextField: UITextField!
    @IBOutlet weak var signUpPhoneNumberTextField: UITextField!
    @IBOutlet weak var signUpEmailTextField: UITextField!
    @IBOutlet weak var signUpPasswordTextField: UITextField!
    @IBOutlet weak var signUpRePasswordTextField: UITextField!
    
    @IBOutlet weak var signInButton: UIButton!
    @IBOutlet weak var signUpButton: UIButton!
    
    //MARK: - ViewLoad Functions
    
    override func viewDidLoad() {
        super.viewDidLoad()
        registerForKeyboardNotifications()
        signInButtonStatus()
        signUpButtonStatus()
        
        // TODO:  Initial Values
        logo.alpha = 0
        signingView.alpha = 0
        signUpView.isHidden = true
        signingHeight.constant = 560
        backgroundView.layer.cornerRadius = 20
        
        // TODO:  Keyboard Dismiss
        let siginInTapGesture = UITapGestureRecognizer(target: self, action: #selector(anyViewSelected))
        let siginUpTapGesture = UITapGestureRecognizer(target: self, action: #selector(anyViewSelected))
        signUpView.addGestureRecognizer(siginUpTapGesture)
        signInView.addGestureRecognizer(siginInTapGesture)
    }
    override func viewDidAppear(_ animated: Bool) {
        
        //TODO: Animate the view in start up
        
        UIView.animate(withDuration: 0.5, delay: 0.5, options: UIView.AnimationOptions.curveEaseIn, animations: {
            self.logo.alpha = 1    //show the logo with animation
        }, completion: nil)
        UIView.animate(withDuration: 0.5, delay: 0.9, options: UIView.AnimationOptions.curveEaseIn, animations: {
            self.signingView.alpha = 1   //show sign in view with animation
        }, completion: nil)
        
    }
    

    
    //MARK: - Switch Bettween sign in and sign up views
    
    @IBAction func toSignUP(_ sender: UIButton) {
        setViewBack(view: signInView, hidden: true)
        setViewBack(view: signUpView, hidden: false)
        UIView.animate(withDuration: 0.5) {
            self.signingHeight.constant = 850 // Expand the view to fit the containts
            self.anyViewSelected()    // Dissmis the keyboard
            self.view.layoutIfNeeded()
        }
    }
    @IBAction func toSignIn(_ sender: UIButton) {
        setView(view: signInView, hidden: false)
        setView(view: signUpView, hidden: true)
        UIView.animate(withDuration: 0.5) {
            self.signingHeight.constant = 560  // Expand the view to fit the containts
            self.anyViewSelected()      // Dissmis the keyboard
            self.view.layoutIfNeeded()
        }
    }
    //TODO: animate the view to right
    func setView(view: UIView, hidden: Bool) {
        UIView.transition(with: view, duration: 0.5, options: .transitionFlipFromRight, animations: {
            view.isHidden = hidden
        })
    }
    //TODO: animate the view to Left
    func setViewBack(view: UIView, hidden: Bool) {
        UIView.transition(with: view, duration: 0.5, options: .transitionFlipFromLeft, animations: {
            view.isHidden = hidden
        })
    }
    
    //MARK: - segues
    @IBAction func signInButtonPressed(_ sender: UIButton) {
        resetAllTextFields()
        performSegue(withIdentifier: "ToRegisterScreen", sender: signInButton)
    }
    @IBAction func signUpButtonPressed(_ sender: UIButton) {
        if signUpRePasswordTextField.text == signUpPasswordTextField.text {
            resetAllTextFields()
            performSegue(withIdentifier: "ToRegisterScreen", sender: signUpButton)
        }
        else{
            SVProgressHUD.showError(withStatus: "Password is not match")
        }
        
    }
    
    
    func resetAllTextFields() {
        signInEmailTextField.text = nil
        signInPasswordTextField.text = nil
        signUpFirstNameTextField.text = nil
        signUpLastNameTextField.text = nil
        signUpEmailTextField.text = nil
        signUpPhoneNumberTextField.text = nil
        signUpPasswordTextField.text = nil
        signUpRePasswordTextField.text = nil
        signInButtonStatus()
        signUpButtonStatus()
        
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
    //TODO: Dissmis the keyboard for all textFields
    @objc func anyViewSelected() {
        signInEmailTextField.endEditing(true)
        signInPasswordTextField.endEditing(true)
        signUpFirstNameTextField.endEditing(true)
        signUpLastNameTextField.endEditing(true)
        signUpEmailTextField.endEditing(true)
        signUpPhoneNumberTextField.endEditing(true)
        signUpPasswordTextField.endEditing(true)
        signUpRePasswordTextField.endEditing(true)
    }
    
    //MARK: - Disable Buttons to fill TextFields
    
    //TODO: - Disable sign in Button
    @IBAction func signInEmail(_ sender: UITextField) {
        signInButtonStatus()
    }
    @IBAction func signInPassword(_ sender: UITextField) {
        signInButtonStatus()
    }
    func signInButtonStatus() {
        if (signInPasswordTextField.text?.count)! >= 6 && (signInEmailTextField.text?.contains("@"))! && (signInEmailTextField.text?.contains(".com"))! {
            signInButton.isEnabled = true
            signInButton.backgroundColor = #colorLiteral(red: 0.8, green: 0.2078431373, blue: 0.1803921569, alpha: 1)
        }
        else {
            signInButton.isEnabled = false
            signInButton.backgroundColor = #colorLiteral(red: 0.8, green: 0.2078431373, blue: 0.1803921569, alpha: 0.5)
        }
    }
    //TODO: - Disable sign up Button
    @IBAction func signUpFirstName(_ sender: UITextField) {
        signUpButtonStatus()
    }
    @IBAction func signUpLastName(_ sender: UITextField) {
        signUpButtonStatus()
    }
    @IBAction func signUpEmail(_ sender: UITextField) {
        signUpButtonStatus()
    }
    @IBAction func signUpPhoneNumber(_ sender: UITextField) {
        signUpButtonStatus()
    }
    @IBAction func signUpPassword(_ sender: UITextField) {
        signUpButtonStatus()
    }
    @IBAction func signUpRePassword(_ sender: UITextField) {
        signUpButtonStatus()
    }
    func signUpButtonStatus() {
        if signUpFirstNameTextField.text?.isEmpty == false && signUpLastNameTextField.text?.isEmpty == false && (signUpEmailTextField.text?.contains("@"))! && (signUpEmailTextField.text?.contains(".com"))! && signUpPhoneNumberTextField.text?.count == 11 && (signUpPasswordTextField.text?.count)! > 5  && signUpRePasswordTextField.text?.count == signUpPasswordTextField.text?.count {
            signUpButton.isEnabled = true
            signUpButton.backgroundColor = #colorLiteral(red: 0.8, green: 0.2078431373, blue: 0.1803921569, alpha: 1)
        }
        else {
            signUpButton.isEnabled = false
            signUpButton.backgroundColor = #colorLiteral(red: 0.8, green: 0.2078431373, blue: 0.1803921569, alpha: 0.5)
        }
    }
    

}

