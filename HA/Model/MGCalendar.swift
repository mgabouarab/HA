//
//  Calender.swift
//  HA
//
//  Created by Mohammed Abouarab on 5/28/19.
//  Copyright © 2019 Mohammed Abouarab. All rights reserved.
//

import UIKit

class MGCalendar {
    
    var firstDayName : String?
    var numberOfDaysOfMonth : Int?
    var nameOfMonth : String?
    var currentDayNumber : Int?
    var currntYear : String?
    
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
    
    init() {
        firstDayName = firstDayName(currentDayName: dateInformation().currentDayName, currentDayNumber: dateInformation().currentDayNumber)
        numberOfDaysOfMonth = lastDayNumber(monthe: dateInformation().currentMonthNumber, year: dateInformation().currentYear).0
        nameOfMonth = lastDayNumber(monthe: dateInformation().currentMonthNumber, year: dateInformation().currentYear).1
        currentDayNumber = Int(dateInformation().currentDayNumber)
        currntYear = dateInformation().currentYear
    }
    
}
