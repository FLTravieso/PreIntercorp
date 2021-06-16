//
//  User.swift
//  PreInterCorp
//
//  Created by Frank Travieso on 15/06/2021.
//

import Foundation

struct User {
    let firstName: String
    let lastName: String
    let birthday: Double

    var userRegister: [String : Any] {
        return ["firstName" : self.firstName,
                "lastName"  : self.lastName,
                "birthday"  : self.birthday]
    }
    
}
