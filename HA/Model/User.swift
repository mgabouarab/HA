//
//  User.swift
//  HA
//
//  Created by Mohammed Abouarab on 5/26/19.
//  Copyright © 2019 Mohammed Abouarab. All rights reserved.
//

import UIKit

class User {
    let email: String
    let phoneNumber: String
    let name: String
    let password: String
    let status: Bool
    let type: String
    let nextBooking: Int?
    
    init(email: String, phoneNumber: String, name: String, password: String, status: Bool, type: String, nextBooking: Int? = 0) {
        self.email = email
        self.name = name
        self.nextBooking = nextBooking
        self.password = password
        self.phoneNumber = phoneNumber
        self.status = status
        self.type = type
    }
    
}
