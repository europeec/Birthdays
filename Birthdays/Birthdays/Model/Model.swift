//
//  Model.swift
//  Birthdays
//
//  Created by Дмитрий Юдин on 08.08.2021.
//

import Foundation

// MARK: - Protocol
protocol ModelProtocol: AnyObject {
    func getData(persons: [PersonData], search: String?) -> (past: [PersonData]?, today: [PersonData]?, future: [PersonData]?)
}

// MARK: - Class
class Model: ModelProtocol {
    static let shared = Model()
    
    func getData(persons: [PersonData], search: String?) -> (past: [PersonData]?, today: [PersonData]?, future: [PersonData]?) {
        let sortedPersons = persons.sorted(by: { $0.date < $1.date })
        
        var past: [PersonData]?
        var today: [PersonData]?
        var future: [PersonData]?
        
        for person in sortedPersons {
            let type = DateManager.getType(person: person)
            
            if (containsSearch(person, search: search)) {
                switch type {
                case .past:
                    if past == nil {
                        past = []
                    }
                    past?.append(person)
                case .today:
                    if today == nil {
                        today = []
                    }
                    today?.append(person)
                case .future:
                    if future == nil {
                        future = []
                    }
                    future?.append(person)
                }
            }
        }
        
        // sorting
        past?.sort(by: { $0.date < $1.date })
        today?.sort(by: { $0.date == $1.date })
        future?.sort(by: { $0.date > $1.date })
        
        return (past: past, today: today, future: future)
    }
    
    private func containsSearch(_ person: PersonData, search: String?) -> Bool {
        guard let search = search, !search.isEmpty else { return true }
        
        let lowerSearch = search.lowercased()
        return person.firstName.lowercased().contains(lowerSearch) || person.secondName.lowercased().contains(lowerSearch)
    }
}

