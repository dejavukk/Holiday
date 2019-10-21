//
//  HolidayRequest.swift
//  Holiday
//
//  Created by JunHyuk on 2019/10/19.
//  Copyright © 2019 junhyuk. All rights reserved.
//

import UIKit

enum HolidayError: Error {
    
    case noDataAvailable
    case canNotProcessData
}

struct HolidayRequest {
    
    let resourceURL: URL
    let API_KEY = "00ce2a63cd85075c0d1ff7d589d272570d584821=US&year=2019"
    
    init(countryCode: String) {
        
        let date = Date()
        let format = DateFormatter()
        format.dateFormat = "yyyy"
        let currentYear = format.string(from: date)
        
        let resourceString = "https://calendarific.com/api?api_key=\(API_KEY)&country=\(countryCode)&year=\(currentYear)"
        // https://calendarific.com/api?api_key=00ce2a63cd85075c0d1ff7d589d272570d584821&country=US&year=2019
        
        guard let resourceURL = URL(string: resourceString) else {fatalError()}
        
        self.resourceURL = resourceURL
    }
    
    func getHolidays(completion: @escaping(Result<[HolidayDetail], HolidayError>) -> Void) {
        
        let dataTask = URLSession.shared.dataTask(with: resourceURL) { data, _, _ in
            
            guard let jsonData = data else {
                completion(.failure(.noDataAvailable))
                
                return
            }
            
            do {
                
                let decoder = JSONDecoder()
                let holidaysResponse = try decoder.decode(HolidayResponse.self, from: jsonData)
                
                let holidayDetails = holidaysResponse.response.holidays
                completion(.success(holidayDetails))
                
            } catch {
                completion(.failure(.canNotProcessData))
            }
        }
        dataTask.resume()
    }
}
