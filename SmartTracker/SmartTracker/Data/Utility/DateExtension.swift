//
//  DateExtension.swift
//  DateExtension
//
//  Created by Harry Yan on 18/08/21.
//

import Foundation

extension Date {
    var startOfMonth: Date {
        let calendar = Calendar(identifier: .gregorian)
        let components = calendar.dateComponents([.year, .month], from: self)
        
        return calendar.date(from: components)!
    }
    
    var endOfMonth: Date {
        var components = DateComponents()
        components.month = 1
        components.second = -1
        
        return Calendar(identifier: .gregorian).date(byAdding: components, to: startOfMonth)!
    }
}
