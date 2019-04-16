//
//  MainViewController.swift
//  HA
//
//  Created by Mohammed Abouarab on 4/8/19.
//  Copyright © 2019 Mohammed Abouarab. All rights reserved.
//

import UIKit

class MainViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {
    
    //MARK: - Variables
    
    var firstDayName : String?
    var numberOfDaysOfMonth : Int?
    var nameOfMonth : String?
    var currentDayNumber : Int?
    var currntYear : String?
    var isSideMenuOpen = false
    var isChoosePeriodShown = false
    
    //MARK: - Outlets
    
    @IBOutlet weak var daysNumberCollectionView: UICollectionView!
    @IBOutlet weak var monthLabel: UILabel!
    @IBOutlet weak var registerDateView: UIView!
    @IBOutlet weak var sideMenuLeadingPosition: NSLayoutConstraint!
    @IBOutlet weak var sideMenueAndPopUpBackgroundView: UIView!
    @IBOutlet weak var choosePeriodViewPosition: NSLayoutConstraint!
    
    //MARK: - ViewController Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.backBarButtonItem?.tintColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        let dismissViewTapGestur = UITapGestureRecognizer(target: self, action: #selector(DissmisView))
        sideMenueAndPopUpBackgroundView.addGestureRecognizer(dismissViewTapGestur)
        
        //TODO: Make viewController as delegat and DataSource for CollectionView
        daysNumberCollectionView.delegate = self
        daysNumberCollectionView.dataSource = self
        daysNumberCollectionView.backgroundColor = UIColor.clear.withAlphaComponent(0)
        
        //TODO: Initialaize Data for Calender CollectionView
        firstDayName = firstDayName(currentDayName: dateInformation().currentDayName, currentDayNumber: dateInformation().currentDayNumber)
        numberOfDaysOfMonth = lastDayNumber(monthe: dateInformation().currentMonthNumber, year: dateInformation().currentYear).0
        nameOfMonth = lastDayNumber(monthe: dateInformation().currentMonthNumber, year: dateInformation().currentYear).1
        currentDayNumber = Int(dateInformation().currentDayNumber)
        currntYear = dateInformation().currentYear
        
        //TODO: Initial values
        sideMenuLeadingPosition.constant = -300
        choosePeriodViewPosition.constant = 600
        sideMenueAndPopUpBackgroundView.isHidden = true
    }
    override func viewWillAppear(_ animated: Bool) {
        monthLabel.text = "\(nameOfMonth!)  \(currntYear!)"
    }
    override func viewDidAppear(_ animated: Bool) {
        let vc = ViewController()
        UIView.animate(withDuration: 0.5) {
            vc.setViewBack(view: self.registerDateView, hidden: false)
        }
    }
    
    // MARK: - Calender CollectionView
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 37
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        var firstDayIndex : Int = 0
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "DayNumberCell", for: indexPath) as! DaysNumberCollectionViewCell
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
            cell.numberOfDay.setTitle(String(indexPath.item - 1), for: .normal)
            cell.dayBackgroundImage.isHidden = false
            if indexPath.item == currentDayNumber! + firstDayIndex - 1 {
                // Current Day
                cell.dayBackgroundImage.image = UIImage(named: "CurrentDay")
            }
            else if indexPath.item < currentDayNumber! + firstDayIndex - 1 {
                // Last Dayes
                cell.numberOfDay.isEnabled = false
                cell.dayBackgroundImage.image = UIImage(named: "Days")
                cell.dayBackgroundImage.alpha = 0.3
            }
            else {
                // Next Days
                cell.dayBackgroundImage.image = UIImage(named: "Days")
            }
        }
        return cell
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
    
    // MARK: - Hide and Show Views
    
    // TODO: - Side Menue hide and Show
    func showSideMenu () {
        isSideMenuOpen = true
        hideChoosePeriod()
        UIView.animate(withDuration: 0.5) {
            self.sideMenueAndPopUpBackgroundView.isHidden = false
            self.sideMenuLeadingPosition.constant = 0
            self.view.layoutIfNeeded()
        }
    }
    func hideSideMenu () {
        isSideMenuOpen = false
        UIView.animate(withDuration: 0.5) {
            self.sideMenueAndPopUpBackgroundView.isHidden = true
            self.sideMenuLeadingPosition.constant = -300
            self.view.layoutIfNeeded()
        }
    }
    @objc func DissmisView() {
        hideSideMenu()
        hideChoosePeriod()
    }
    @IBAction func menuButtonPressed(_ sender: UIBarButtonItem) {
        if isSideMenuOpen {
            hideSideMenu()
        }
        else {
            showSideMenu()
        }
    }
    
    // TODO: - show and hide choose period view
    func showChoosePeriod () {
        isChoosePeriodShown = true
        UIView.animate(withDuration: 0.5) {
            self.sideMenueAndPopUpBackgroundView.isHidden = false
            self.choosePeriodViewPosition.constant = 0
            self.view.layoutIfNeeded()
        }
    }
    func hideChoosePeriod () {
        isChoosePeriodShown = false
        UIView.animate(withDuration: 0.5) {
            self.sideMenueAndPopUpBackgroundView.isHidden = true
            self.choosePeriodViewPosition.constant = 600
            self.view.layoutIfNeeded()
        }
    }
    @IBAction func dayButtonPressed(_ sender: Any) {
        showChoosePeriod()
    }
    @IBAction func cancelButtonPressed(_ sender: Any) {
        hideChoosePeriod()
    }
    
    // MARK: - Segues to Other Screens
    
    // TODO: - Contact Screen
    @IBAction func ContactUsButtonPressed(_ sender: UIButton) {
        hideSideMenu()
        performSegue(withIdentifier: "ToContact", sender: self)
    }
    
    //TODO: - Galary Screen
    
    @IBAction func GalaryButtonPressed(_ sender: UIButton) {
        hideSideMenu()
        performSegue(withIdentifier: "ToGalary", sender: self)
    }
    
    
    @IBAction func logoutPressed(_ sender: UIButton) {
        navigationController?.popViewController(animated: true)
        
        dismiss(animated: true, completion: nil)
    }
    
}

