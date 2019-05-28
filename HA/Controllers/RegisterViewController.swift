//
//  RegisterViewController.swift
//  HA
//
//  Created by Mohammed Abouarab on 4/14/19.
//  Copyright © 2019 Mohammed Abouarab. All rights reserved.
//

import UIKit
import SVProgressHUD
import Firebase

class RegisterViewController: UIViewController {

    let calendar = MGCalendar()
    let screenSize = UIScreen.main.bounds
    var isSideMenueHidden = true
    
    //MARK: - Outlets
        //calendar Outlets
    @IBOutlet weak var registerationDay: UILabel!
    @IBOutlet weak var currentMonth: UILabel!
        //Days Outlets
    @IBOutlet weak var saturday: UILabel!
    @IBOutlet weak var sunday: UILabel!
    @IBOutlet weak var monday: UILabel!
    @IBOutlet weak var tuesday: UILabel!
    @IBOutlet weak var wednesday: UILabel!
    @IBOutlet weak var thursday: UILabel!
    @IBOutlet weak var friday: UILabel!
    @IBOutlet weak var daysOfMonth: UICollectionView!
        //Side Menu outlet
    @IBOutlet weak var sideMenu: UIView!
    @IBOutlet weak var sideMenuWidth: NSLayoutConstraint!
    @IBOutlet weak var sideMenuLeading: NSLayoutConstraint!
    @IBOutlet weak var profileImage: UIImageView!
    @IBOutlet weak var profileHeight: NSLayoutConstraint!
    @IBOutlet weak var profileWidth: NSLayoutConstraint!
        //Popup Menue
    @IBOutlet weak var HorzintalPopupConstraint: NSLayoutConstraint!
    @IBOutlet weak var PopupAndSideMenusBackView: UIView!
    
    
    //MARK: - View Life cycle
    override func viewDidLoad() {
        
        super.viewDidLoad()
        currentDayLabelBackground()
        
        //TODO: -Set DataSource and Delegate for collectionView
        daysOfMonth.delegate = self
        daysOfMonth.dataSource = self
        
        //tapGuster
        let dismissViewTapGestur = UITapGestureRecognizer(target: self, action: #selector(DissmisView))
        PopupAndSideMenusBackView.addGestureRecognizer(dismissViewTapGestur)
        
        //TODO: -Set initial Values
        navigationItem.backBarButtonItem?.tintColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        daysOfMonth.alpha = 0
        registerationDay.alpha = 0
        daysOfMonth.backgroundColor = UIColor.clear.withAlphaComponent(0) //solve problem for black background for collectionView
        
        // initial values for side menu
        sideMenuWidth.constant = CGFloat(Double(screenSize.width) * 0.75)
        profileWidth.constant = sideMenuWidth.constant * 0.7
        profileHeight.constant = profileWidth.constant
        profileImage.layer.cornerRadius = profileHeight.constant / 2
        profileImage.clipsToBounds = true
        sideMenuLeading.constant = -(sideMenuWidth.constant + 10)
        HorzintalPopupConstraint.constant = screenSize.height
        PopupAndSideMenusBackView.isHidden = true
        animateCalendarAndRegisterationLabel()
    }
    override func viewWillAppear(_ animated: Bool) {
        currentMonth.text = "\(calendar.nameOfMonth!)  \(calendar.currntYear!)"
        
    }
    
    func currentDayLabelBackground() {
        if calendar.dateInformation().currentDayName == "Saturday" {
            saturday.backgroundColor = #colorLiteral(red: 0.8, green: 0.2078431373, blue: 0.1803921569, alpha: 0.7045430223)
            saturday.textColor = .black
        }
        else if calendar.dateInformation().currentDayName == "Sunday" {
            sunday.backgroundColor = #colorLiteral(red: 0.8, green: 0.2078431373, blue: 0.1803921569, alpha: 0.7045430223)
            sunday.textColor = .black
        }
        else if calendar.dateInformation().currentDayName == "Monday" {
            monday.backgroundColor = #colorLiteral(red: 0.8, green: 0.2078431373, blue: 0.1803921569, alpha: 0.7045430223)
            monday.textColor = .black
        }
        else if calendar.dateInformation().currentDayName == "Tuesday" {
            tuesday.backgroundColor = #colorLiteral(red: 0.8, green: 0.2078431373, blue: 0.1803921569, alpha: 0.7045430223)
            tuesday.textColor = .black
        }
        else if calendar.dateInformation().currentDayName == "Wednesday" {
            wednesday.backgroundColor = #colorLiteral(red: 0.8, green: 0.2078431373, blue: 0.1803921569, alpha: 0.7045430223)
            wednesday.textColor = .black
        }
        else if calendar.dateInformation().currentDayName == "Thursday" {
            thursday.backgroundColor = #colorLiteral(red: 0.8, green: 0.2078431373, blue: 0.1803921569, alpha: 0.7045430223)
            thursday.textColor = .black
        }
        else if calendar.dateInformation().currentDayName == "Friday" {
            friday.backgroundColor = #colorLiteral(red: 0.8, green: 0.2078431373, blue: 0.1803921569, alpha: 0.7045430223)
            friday.textColor = .black
        }
    }
    
    //MARK:- Side Menu and PopUP Menu Functions
        //functions
    func showSideMenu() {
        UIView.animate(withDuration: 0.5) {
            self.sideMenuLeading.constant = 0
            self.sideMenu.dropShadow()
            self.PopupAndSideMenusBackView.isHidden = false
            self.isSideMenueHidden = false
            self.view.layoutIfNeeded()
        }
    }
    func hideSideMenu() {
        UIView.animate(withDuration: 0.5) {
            self.sideMenuLeading.constant = -(self.sideMenuWidth.constant + 10)
            self.PopupAndSideMenusBackView.isHidden = true
            self.isSideMenueHidden = true
            self.view.layoutIfNeeded()
        }
    }
    func showPopupMenu() {
        UIView.animate(withDuration: 0.5) {
            self.HorzintalPopupConstraint.constant = 30
            self.PopupAndSideMenusBackView.isHidden = false
            self.view.layoutIfNeeded()
        }
    }
    func hidePopupMenu() {
        UIView.animate(withDuration: 0.5) {
            self.HorzintalPopupConstraint.constant = self.screenSize.height
            self.PopupAndSideMenusBackView.isHidden = true
            self.view.layoutIfNeeded()
        }
    }
    func animateCalendarAndRegisterationLabel() {
        UIView.animate(withDuration: 1, delay: 1, usingSpringWithDamping: 0.3, initialSpringVelocity: 0.0, options: .preferredFramesPerSecond30, animations: {
            self.registerationDay.center.x = 0
            self.registerationDay.alpha = 1
        }, completion: nil)
        UIView.animate(withDuration: 1, delay: 0.5, usingSpringWithDamping: 0.9, initialSpringVelocity: 0.0, options: .curveEaseIn, animations: {
            self.daysOfMonth.center.x = 0
            self.daysOfMonth.alpha = 1
        }, completion: nil)
    }
    @objc func DissmisView() {
        hideSideMenu()
        hidePopupMenu()
    }
        //IBActions
    @IBAction func MenuButtonPressed(_ sender: UIBarButtonItem) {
        if isSideMenueHidden {
            hidePopupMenu()
            showSideMenu()
        }
        else {
            hideSideMenu()
        }
    }
    @IBAction func cancelButtonPressed(_ sender: UIButton) {
        hidePopupMenu()
    }
    @IBAction func daySelected(_ sender: UIButton) {
        showPopupMenu()
    }
    
    // MARK: - Segues to Other Screens
        //Contact Screen
    @IBAction func ContactUsButtonPressed(_ sender: UIButton) {
        hideSideMenu()
        performSegue(withIdentifier: "ToContactUS", sender: self)
    }
        //Galary Screen
    @IBAction func GalaryButtonPressed(_ sender: UIButton) {
        hideSideMenu()
        performSegue(withIdentifier: "ToGalary", sender: self)
    }
        //Logout
    @IBAction func logoutPressed(_ sender: UIButton) {
        navigationController?.popViewController(animated: true)
        
        dismiss(animated: true, completion: nil)
    }
        //Profile
    @IBAction func ProfileButtonPressed(_ sender: UIButton) {
        hideSideMenu()
        performSegue(withIdentifier: "ToProfile", sender: self)
    }

    
}

//MARK: - Add shadow to sideMenu
extension UIView {
    func dropShadow(scale: Bool = true) {
        layer.masksToBounds = false
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOpacity = 2
        layer.shadowOffset = .zero
        layer.shadowRadius = 10
        layer.shouldRasterize = true
        layer.rasterizationScale = scale ? UIScreen.main.scale : 1
    }
}

//MARK: - Change Profile Image
extension RegisterViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    //Choose the photo
    @IBAction func changeProfiePicture(_ sender: Any) {
        SVProgressHUD.show()
        let picker = UIImagePickerController()
        picker.delegate = self
        picker.allowsEditing = false
        picker.sourceType = .photoLibrary
        picker.mediaTypes = UIImagePickerController.availableMediaTypes(for: .photoLibrary)!
        present(picker, animated: true, completion: SVProgressHUD.dismiss)
    }
    
    //Set Chosen Photo
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        var choosenImage = UIImage()
        choosenImage = info[UIImagePickerController.InfoKey.originalImage] as! UIImage
        profileImage.image = choosenImage
        dismiss(animated: true, completion: nil)
    }
    
    //Dismiss the choose operation
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
}

//MARK: - CollectionView
extension RegisterViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 37
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        var firstDayIndex : Int = 0
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "DayNumberCell2", for: indexPath) as! DayesOfCalender
        if calendar.firstDayName == "Saturday" {
            firstDayIndex = 0
        }
        else if calendar.firstDayName == "Sunday" {
            firstDayIndex = 1
        }
        else if calendar.firstDayName == "Monday" {
            firstDayIndex = 2
        }
        else if calendar.firstDayName == "Tuesday" {
            firstDayIndex = 3
        }
        else if calendar.firstDayName == "Wednesday" {
            firstDayIndex = 4
        }
        else if calendar.firstDayName == "Thursday" {
            firstDayIndex = 5
        }
        else if calendar.firstDayName == "Friday" {
            firstDayIndex = 6
        }
        if indexPath.item >= firstDayIndex && indexPath.item < (firstDayIndex + calendar.numberOfDaysOfMonth!) {
            cell.numberOfDay.isHidden = false
            cell.numberOfDay.setTitle(String(indexPath.item - firstDayIndex + 1), for: .normal)
            if indexPath.item == calendar.currentDayNumber! + firstDayIndex - 1 {
                // Current Day
                cell.numberOfDay.setBackgroundImage(UIImage(named: "CurrentDay"), for: .normal)
            }
            else if indexPath.item < calendar.currentDayNumber! + firstDayIndex - 1 {
                // Last Dayes
                cell.numberOfDay.isEnabled = false
                cell.numberOfDay.setBackgroundImage(UIImage(named: "Days"), for: .normal)
            }
            else {
                // Next Days
                cell.numberOfDay.setBackgroundImage(UIImage(named: "Days"), for: .normal)
            }
        }
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let itemSize = (collectionView.frame.width - (collectionView.contentInset.left + collectionView.contentInset.right + 60)) / 7
        return CGSize(width: itemSize, height: itemSize)
    }
}
