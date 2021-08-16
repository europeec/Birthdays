//
//  Model.swift
//  Birthdays
//
//  Created by Дмитрий Юдин on 08.08.2021.
//

import UIKit
import CoreData

// MARK: - Protocol
protocol ModelProtocol: AnyObject {
    var days: [Days]? { get }
    func fetch() -> [Days]?
    func getData(search: String?) -> (past: [Days]?, today: [Days]?, future: [Days]?)
    func saveContext()
    func save(person: PersonData) -> Days
    func convertDaysToPersons(days: [Days]?) -> [PersonData]?
    func convertDayToPerson(day: Days) -> PersonData
    func delete(_ day: Days?)
    func cleanCoreData()
}

// MARK: - Class
class Model: ModelProtocol {
    var days: [Days]? {
        get {
            return fetch()
        }
    }
    
    static let shared = Model()
    
    lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "ModelCoreData")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()
    
    lazy var managedObjectContext = persistentContainer.viewContext
    
    func fetch() -> [Days]? {
        let fetched = try? managedObjectContext.fetch(Days.fetchRequest()) as? [Days]
        return fetched
    }
    
    func save(person: PersonData) -> Days {
        let new = Days(context: managedObjectContext)
        new.firstname = person.firstName
        new.secondname = person.secondName
        new.date = person.date
        new.image = person.image.pngData()
        self.saveContext()
        return new
    }
    
    func saveContext () {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
    
    func delete(_ day: Days?) {
        guard let day = day else { return }
        managedObjectContext.delete(day)
        self.saveContext()
    }
    
    func convertDaysToPersons(days: [Days]?) -> [PersonData]? {
        guard let days = days else { return nil }
        var persons = [PersonData]()
        for day in days {
            let person = PersonData(date: day.date!, firstName: day.firstname!, secondName: day.secondname!, image: UIImage(data: day.image!)!)
            persons.append(person)
        }
        return persons
    }
    
    func convertDayToPerson(day: Days) -> PersonData {
        let person = PersonData(date: day.date!, firstName: day.firstname!, secondName: day.secondname!, image: UIImage(data: day.image!)!)
        return person
    }
    
    func getData(search: String?) -> (past: [Days]?, today: [Days]?, future: [Days]?) {
        guard let sortedDays = self.days?.sorted(by: { $0.date! < $1.date! }) else { return (past: nil, today: nil, future: nil )}
        
        var past: [Days]?
        var today: [Days]?
        var future: [Days]?
        
        for day in sortedDays {
            let type = DateManager.getType(day: day)
            
            if (containsSearch(day, search: search)) {
                switch type {
                case .past:
                    if past == nil {
                        past = []
                    }
                    past?.append(day)
                case .today:
                    if today == nil {
                        today = []
                    }
                    today?.append(day)
                case .future:
                    if future == nil {
                        future = []
                    }
                    future?.append(day)
                }
            }
        }
        
        // sorting
        past?.sort(by: { $0.date! < $1.date! })
        today?.sort(by: { $0.date! == $1.date! })
        future?.sort(by: { $0.date! > $1.date! })
        
        return (past: past, today: today, future: future)
    }
    
    func cleanCoreData() {
        guard let days = self.days else { return }
        for day in days {
            self.delete(day)
        }
        self.saveContext()
    }
    
    private func containsSearch(_ day: Days, search: String?) -> Bool {
        guard let search = search, !search.isEmpty else { return true }
        
        let lowerSearch = search.lowercased()
        let lowerFirst = day.firstname!.lowercased()
        let lowerSecond = day.secondname!.lowercased()
        let firstPlusSecond = lowerFirst + " " + lowerSecond
        let secondPlusFirst = lowerSecond + " " + lowerFirst
        return lowerFirst.contains(lowerSearch) ||
            lowerSecond.contains(lowerSearch) ||
            firstPlusSecond.contains(lowerSearch) ||
            secondPlusFirst.contains(lowerSearch)
    }
}

