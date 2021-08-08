//
//  Person.swift
//  Birthdays
//
//  Created by Дмитрий Юдин on 07.08.2021.
//

import SwiftUI

struct PersonData: Identifiable {
    var id = UUID()
    var date = Date()
    var firstName: String
    var secondName: String
    var image: Image
}
