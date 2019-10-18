//
//  Holiday.swift
//  Holiday
//
//  Created by JunHyuk on 2019/10/18.
//  Copyright © 2019 junhyuk. All rights reserved.
//

import Foundation

struct HolidayResponse: Decodable {
    
    var response: Holidays
}

struct Holidays: Decodable {
    
    var holidays: [HolidayDetail]
}

struct HolidayDetail: Decodable {
    
    var name: String
    var date: DateInfo
}

struct DateInfo: Decodable {
    
    var iso: String
}
