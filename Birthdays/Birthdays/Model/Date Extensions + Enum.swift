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
    static func getType(person: PersonData) -> DateType
}

class DateManager: DateManagerProtocol {
    static func getType(person: PersonData) -> DateType {
        let now = Date().getDayAndMonth()
        let personDate = person.date.getDayAndMonth()
        
        if now.month > personDate.month {
            return .past
        } else if now.month == personDate.month {
            if now.day > personDate.day {
                return .past
            } else if now.day == personDate.day {
                return .today
            } else {
                return .future
            }
        } else {
            return .future
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
