//
//  RegisterViewController.swift
//  HA
//
//  Created by Mohammed Abouarab on 4/14/19.
//  Copyright © 2019 Mohammed Abouarab. All rights reserved.
//

import UIKit

class RegisterViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    var firstDayName : String?
    var numberOfDaysOfMonth : Int?
    var nameOfMonth : String?
    var currentDayNumber : Int?
    var currntYear : String?
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
        
        //TODO: Initialaize Data for Calender CollectionView
        firstDayName = firstDayName(currentDayName: dateInformation().currentDayName, currentDayNumber: dateInformation().currentDayNumber)
        numberOfDaysOfMonth = lastDayNumber(monthe: dateInformation().currentMonthNumber, year: dateInformation().currentYear).0
        nameOfMonth = lastDayNumber(monthe: dateInformation().currentMonthNumber, year: dateInformation().currentYear).1
        currentDayNumber = Int(dateInformation().currentDayNumber)
        currntYear = dateInformation().currentYear
        
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
        
        
        
        
        // animate registeration label and calendar
        UIView.animate(withDuration: 1, delay: 1, usingSpringWithDamping: 0.3, initialSpringVelocity: 0.0, options: .preferredFramesPerSecond30, animations: {
            self.registerationDay.center.x = 0
            self.registerationDay.alpha = 1
        }, completion: nil)
        UIView.animate(withDuration: 1, delay: 0.5, usingSpringWithDamping: 0.9, initialSpringVelocity: 0.0, options: .curveEaseIn, animations: {
            self.daysOfMonth.center.x = 0
            self.daysOfMonth.alpha = 1
        }, completion: nil)
        
        
    }
    override func viewWillAppear(_ animated: Bool) {
        currentMonth.text = "\(nameOfMonth!)  \(currntYear!)"
    }
    
    //MARK: - CollectionView Methods
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 37
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        var firstDayIndex : Int = 0
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "DayNumberCell2", for: indexPath) as! DayesOfCalender
        if firstDayName == "Saturday" {
            firstDayIndex = 0
        }
        else if firstDayName == "Sunday" {
            firstDayIndex = 1
        }
        else if firstDayName == "Monday" {
            firstDayIndex = 2
        }
        else if firstDayName == "Tuesday" {
            firstDayIndex = 3
        }
        else if firstDayName == "Wednesday" {
            firstDayIndex = 4
        }
        else if firstDayName == "Thursday" {
            firstDayIndex = 5
        }
        else if firstDayName == "Friday" {
            firstDayIndex = 6
        }
        if indexPath.item >= firstDayIndex && indexPath.item < (firstDayIndex + numberOfDaysOfMonth!) {
            cell.numberOfDay.isHidden = false
            cell.numberOfDay.setTitle(String(indexPath.item - firstDayIndex + 1), for: .normal)
            if indexPath.item == currentDayNumber! + firstDayIndex - 1 {
                // Current Day
                cell.numberOfDay.setBackgroundImage(UIImage(named: "CurrentDay"), for: .normal)
            }
            else if indexPath.item < currentDayNumber! + firstDayIndex - 1 {
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
    
    // MARK: - Calender informatios
    func dateInformation () -> (currentDayName: String, currentDayNumber: String, currentMonthNumber: String, currentYear: String) {
        let date = Date()
        let dayNameFormatter = DateFormatter()
        dayNameFormatter.dateFormat = "EEEE"
        let dayNumberFormatter = DateFormatter()
        dayNumberFormatter.dateFormat = "dd"
        let monthNumberFormatter = DateFormatter()
        monthNumberFormatter.dateFormat = "MM"
        let yearNumberFormatter = DateFormatter()
        yearNumberFormatter.dateFormat = "yyyy"
        
        let currentDayName = dayNameFormatter.string(from: date)
        if currentDayName == "Saturday" {
            saturday.backgroundColor = #colorLiteral(red: 0.8, green: 0.2078431373, blue: 0.1803921569, alpha: 0.7045430223)
            saturday.textColor = .black
        }
        else if currentDayName == "Sunday" {
            sunday.backgroundColor = #colorLiteral(red: 0.8, green: 0.2078431373, blue: 0.1803921569, alpha: 0.7045430223)
            sunday.textColor = .black
        }
        else if currentDayName == "Monday" {
            monday.backgroundColor = #colorLiteral(red: 0.8, green: 0.2078431373, blue: 0.1803921569, alpha: 0.7045430223)
            monday.textColor = .black
        }
        else if currentDayName == "Tuesday" {
            tuesday.backgroundColor = #colorLiteral(red: 0.8, green: 0.2078431373, blue: 0.1803921569, alpha: 0.7045430223)
            tuesday.textColor = .black
        }
        else if currentDayName == "Wednesday" {
            wednesday.backgroundColor = #colorLiteral(red: 0.8, green: 0.2078431373, blue: 0.1803921569, alpha: 0.7045430223)
            wednesday.textColor = .black
        }
        else if currentDayName == "Thursday" {
            thursday.backgroundColor = #colorLiteral(red: 0.8, green: 0.2078431373, blue: 0.1803921569, alpha: 0.7045430223)
            thursday.textColor = .black
        }
        else if currentDayName == "Friday" {
            friday.backgroundColor = #colorLiteral(red: 0.8, green: 0.2078431373, blue: 0.1803921569, alpha: 0.7045430223)
            friday.textColor = .black
        }
        let currentDayNumber = dayNumberFormatter.string(from: date)
        let currentMonthNumber = monthNumberFormatter.string(from: date)
        let currentYear = yearNumberFormatter.string(from: date)
        return(currentDayName, currentDayNumber, currentMonthNumber, currentYear)
    }
    func firstDayName(currentDayName: String, currentDayNumber: String) -> String {
        
        var firstDayName: String = ""
        let numberOfRepetingOperation = Int(currentDayNumber)! - 2
        let daysArray = ["Saturday","Sunday","Monday","Tuesday","Wednesday","Thursday","Friday"]
        var currentDayIndex = 0
        var result : Int = 0
        
        for dayIndex in 0 ... daysArray.count - 1 {
            if daysArray[dayIndex] == currentDayName {
                currentDayIndex = dayIndex
                if numberOfRepetingOperation >= 0 {
                    for _ in 0 ... numberOfRepetingOperation {
                        if currentDayIndex == 0 {
                            currentDayIndex = 6
                            result = currentDayIndex
                        }
                        else {
                            currentDayIndex -= 1
                            result = currentDayIndex
                        }
                    }
                }
                else {
                    currentDayIndex = dayIndex
                    result = currentDayIndex
                }
            }
            firstDayName = daysArray[result]
        }
        
        return firstDayName
    }
    func lastDayNumber(monthe: String, year: String) -> (Int, String) {
        
        var numberOfDays = 0
        var monthName = ""
        
        if monthe == "01" {
            numberOfDays = 31
            monthName = "January"
        }
        else if monthe == "02" {
            let a = Int(year)
            let b = 2016
            let years = Double(a! - b)/4
            let intYears = Int(years)
            if String(years-Double(intYears)) == "0.0" {
                numberOfDays = 29
            }
            else {
                numberOfDays = 28
            }
            monthName = "February"
        }
        else if monthe == "03" {
            numberOfDays = 31
            monthName = "March"
        }
        else if monthe == "04" {
            numberOfDays = 30
            monthName = "April"
        }
        else if monthe == "05" {
            numberOfDays = 31
            monthName = "May"
        }
        else if monthe == "06" {
            numberOfDays = 30
            monthName = "June"
        }
        else if monthe == "07" {
            numberOfDays = 31
            monthName = "July"
        }
        else if monthe == "08" {
            numberOfDays = 31
            monthName = "August"
        }
        else if monthe == "09" {
            numberOfDays = 30
            monthName = "September"
        }
        else if monthe == "10" {
            numberOfDays = 31
            monthName = "October"
        }
        else if monthe == "11" {
            numberOfDays = 30
            monthName = "November"
        }
        else if monthe == "12" {
            numberOfDays = 31
            monthName = "December"
        }
        
        return (numberOfDays, monthName)
    }
    
    //MARK:- Side Menu and PopUP Menu Functions
        //functions
    func showSideMenu() {
        UIView.animate(withDuration: 0.5) {
            self.sideMenuLeading.constant = 0
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
    
    
    //MARK: - Change Profile Image
    
    //Choose the photo
    @IBAction func changeProfiePicture(_ sender: Any) {
        let picker = UIImagePickerController()
        picker.delegate = self
        picker.allowsEditing = false
        picker.sourceType = .photoLibrary
        picker.mediaTypes = UIImagePickerController.availableMediaTypes(for: .photoLibrary)!
        present(picker, animated: true, completion: nil)
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
