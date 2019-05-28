//
//  Day.swift
//  HA
//
//  Created by Mohammed Abouarab on 5/26/19.
//  Copyright © 2019 Mohammed Abouarab. All rights reserved.
//

import UIKit

class Day {
    let name: String
    let number: Int
    let isOpen: Bool
    let interval: Interval
    init(name: String, number: Int, isOpen: Bool, interval: Interval) {
        self.name = name
        self.number = number
        self.isOpen = isOpen
        self.interval = interval
    }
}




