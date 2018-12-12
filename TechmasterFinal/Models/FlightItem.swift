//
//  Item.swift
//  TechmasterFinal
//
//  Created by Toàn Nguyễn on 12/12/18.
//  Copyright © 2018 mobile. All rights reserved.
//

import Foundation
import UIKit
import Alamofire

class FlightItem : Decodable {
    
    var flightNo: String
    var flightDate: String
    var sector: String
    var flightStatus: String
    
    init(flightNo: String, flightDate: String, sector: String, flightStatus: String) {
        self.flightNo = flightNo
        self.flightDate = flightDate
        self.sector = sector
        self.flightStatus = flightStatus
    }
}
