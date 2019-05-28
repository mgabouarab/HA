//
//  Interval.swift
//  HA
//
//  Created by Mohammed Abouarab on 5/26/19.
//  Copyright © 2019 Mohammed Abouarab. All rights reserved.
//

import UIKit

class Interval {
    var users: User?
    let name: String
    let isOpen: Bool
    var numberOfPlaces: Int
    init(users: User?, name: String, isOpen: Bool, numberOfPlaces: Int = 0) {
        self.users = users
        self.name = name
        self.isOpen = isOpen
        self.numberOfPlaces = numberOfPlaces
    }
}
