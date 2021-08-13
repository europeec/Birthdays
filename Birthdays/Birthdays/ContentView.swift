//
//  ContentView.swift
//  Birthdays
//
//  Created by Дмитрий Юдин on 07.08.2021.
//

import SwiftUI
import SwiftlySearch

struct ContentView: View {
    
    var body: some View {
        MainScreenView()
    }
}

let data = [PersonData(date: Date(), firstName: "Дмитрий", secondName: "Юдин", image: UIImage(systemName: "person.circle")!), PersonData(date: Date(timeIntervalSince1970: 1234567), firstName: "Дмитрий", secondName: "Юдин", image: UIImage(systemName: "person.circle")!), PersonData(date: Date(timeIntervalSince1970: 123456788), firstName: "Дмитрий", secondName: "Юдин", image: UIImage(systemName: "person.circle")!)]

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
