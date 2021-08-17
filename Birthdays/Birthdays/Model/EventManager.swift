//
//  EventManager.swift
//  Birthdays
//
//  Created by Дмитрий Юдин on 16.08.2021.
//

import UIKit
import EventKit

protocol EventProtocol: AnyObject {
    var eventStore: EKEventStore? { get set }
    func addReminder(day: Days)
    func addCalendar(days: [Days])
    func removeCalendar()
    func getCalendar() -> EKCalendar?
}

class EventManager: EventProtocol {
    static var shared = EventManager()
    var eventStore: EKEventStore?
    let key = "calendarIdentifier"
    
    init() {
        self.eventStore = EKEventStore()
    }
    
    func addReminder(day: Days) {
        guard let eventStore = eventStore else { return }
        eventStore.requestAccess(to: .reminder) { [weak self] _, error in
            if error == nil {
                guard let self = self, let calendar = self.getCalendar() else { return }
                let reminder = EKReminder(eventStore: eventStore)
                let event = EKEvent(eventStore: eventStore)
                event.title = day.firstname! + day.secondname!
                reminder.priority = 9
                reminder.startDateComponents = day.date?.startTimeComponents()
                reminder.completionDate = day.date!.stopTime()
                reminder.calendar = calendar
                reminder.title = day.firstname! + day.secondname!
                let startDate = day.date!.startTime()
                let endDate = day.date!.stopTime()
                event.startDate = startDate
                event.endDate = endDate
                event.isAllDay = true
                event.notes = "..."
                event.alarms = nil
                event.calendar = calendar
                
                try! eventStore.save(reminder, commit: true)
            }
        }
    }
    
    func addCalendar(days: [Days]) {
        
    }
    
    func removeCalendar() {
        
    }
    
    func getCalendar() -> EKCalendar? {
        if let id = UserDefaults.standard.string(forKey: key),
           let calendar = eventStore?.calendar(withIdentifier: id) {
            return calendar
        } else {
            guard let eventStore = eventStore else { return nil }
            let calendar = EKCalendar(for: .reminder, eventStore: eventStore)
            calendar.title = "Birthdays!"
            calendar.cgColor = UIColor.purple.cgColor
            calendar.source = eventStore.defaultCalendarForNewReminders()?.source
            
            do {
                try eventStore.saveCalendar(calendar, commit: true)
                UserDefaults.standard.setValue(calendar.calendarIdentifier, forKey: key)
            } catch let error {
                print(error)
            }
            
            return calendar
        }
    }
}
