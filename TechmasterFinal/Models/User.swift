//
//  User.swift
//  TechmasterFinal
//
//  Created by Toàn Nguyễn on 12/12/18.
//  Copyright © 2018 mobile. All rights reserved.
//

import Foundation
import UIKit

class User : Codable {
    
    var username: String
    var password: String
    
    init(_ Username: String, _ Password: String) {
        self.username = Username
        self.password = Password
    }
}


