//
//  Date Extensions + Enum.swift
//  Birthdays
//
//  Created by Дмитрий Юдин on 08.08.2021.
//

import Foundation

enum DateType {
    case past, today, future
}

protocol DateManagerProtocol: AnyObject {
    static func getType(day: Days) -> DateType
    static func getDateString(date: Date) -> String
    static func calculateAge(person: PersonData) -> Int
    static func compare(_ first: Days, with second: Days) -> Bool
}

class DateManager: DateManagerProtocol {
    static func getType(day: Days) -> DateType {
        let now = Date().getDayAndMonth()
        let dayDate = day.date!.getDayAndMonth()
        
        if now.month > dayDate.month {
            return .past
        } else if now.month == dayDate.month {
            if now.day > dayDate.day {
                return .past
            } else if now.day == dayDate.day {
                return .today
            } else {
                return .future
            }
        } else {
            return .future
        }
    }
    
    static func getDateString(date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "d MMMM"
        let dayString = formatter.string(from: date)
        return dayString
    }
    
    static func calculateAge(person: PersonData) -> Int {
        let formatter = DateFormatter()
        formatter.dateFormat = "y"
        let year = Int(formatter.string(from: Date()))! - Int(formatter.string(from: person.date))!
        
        return year
    }
    
    static func compare(_ first: Days, with second: Days) -> Bool {
        let firstComponents = first.date!.getDayAndMonth()
        let secondComponents = second.date!.getDayAndMonth()
        
        if secondComponents.month > firstComponents.month {
            return true
        } else if firstComponents.month < secondComponents.month {
            return false
        } else {
            return secondComponents.day > firstComponents.day
        }
    }
}

extension Date {
    func getDayAndMonth() -> (day: Int, month: Int) {
        let calendar = Calendar.current
        let components = calendar.dateComponents([.day, .month], from: self)
        return (day: components.day!, month: components.month!)
    }
}
