//
//  Date+Extensions.swift
//  EventsApp
//
//  Created by Artur Remizov on 19.11.22.
//

import Foundation

extension Date {
    
    func timeRemaining(until endDate: Date) -> String? {
        let dateComponentsFormatter = DateComponentsFormatter()
        dateComponentsFormatter.allowedUnits = [.year, .month, .weekOfMonth, .day]
        dateComponentsFormatter.unitsStyle = .full
        return dateComponentsFormatter.string(from: self, to: endDate)
    }
}
