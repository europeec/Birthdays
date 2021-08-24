//
//  Days+CoreDataProperties.swift
//  Birthdays
//
//  Created by Дмитрий Юдин on 12.08.2021.
//
//

import Foundation
import CoreData


extension Days {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Days> {
        return NSFetchRequest<Days>(entityName: "Days")
    }

    @NSManaged public var image: Data?
    @NSManaged public var firstname: String?
    @NSManaged public var secondname: String?
    @NSManaged public var date: Date?

}

extension Days: Identifiable {

}

extension Days {
    func getMessageForEvent() -> String {
        return "День рождение! \(firstname) \(secondname)"
    }
}
