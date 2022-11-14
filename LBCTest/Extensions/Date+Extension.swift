//
//  Date+Extension.swift
//  LBCTest
//
//  Created by Quentin Deschamps on 11/11/2022.
//

import Foundation

extension Date {
    func convertStringToDate(fromDate: String) -> Date {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
        let date = dateFormatter.date(from: fromDate)!
        return date
    }
    
    func displayDateFormat() -> String {
        let currentDate: Date = Date()
        
        let calendar: Calendar = Calendar.current
        let dayAgo = calendar.date(byAdding: .day, value: -1, to: Date())!
        
        let dateFormatter: DateFormatter = DateFormatter()
        
        let timeFormatter = DateFormatter()
        timeFormatter.dateFormat = "hh:mm"
        if dayAgo < currentDate {
            let diff = Calendar.current.dateComponents([.day], from: self, to: Date()).day ?? 0
            if diff > 2 {
                dateFormatter.dateFormat = "dd/MM/yyyy"
                return dateFormatter.string(from: self) + " à " + timeFormatter.string(from: self)
            } else {
                dateFormatter.dateStyle = .medium
                dateFormatter.doesRelativeDateFormatting = true
            }
        }
        return dateFormatter.string(from: self).capitalized + " à " + timeFormatter.string(from: self)
    }
}
