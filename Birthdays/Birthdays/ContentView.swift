//
//  ContentView.swift
//  Birthdays
//
//  Created by Дмитрий Юдин on 07.08.2021.
//

import SwiftUI
import SwiftlySearch

struct ContentView: View {
    @State var persons = data
    @State var searchText = ""
    
    var body: some View {
        NavigationView {
            List {
                if persons.isEmpty {
                    EmptyView()
                }
                
                ForEach(persons) { person in
                    PersonCell(person: person)
                }.onDelete(perform: { indexSet in
                    persons.remove(atOffsets: indexSet)
                })
            }.navigationBarTitle("Birthdays!")
            .navigationBarSearch(self.$searchText)
            .navigationBarItems(trailing: AddButton(persons: $persons))
        }
    }
}

struct EmptyView: View {
    var body: some View {
        VStack(alignment: .center) {
            Text("Добавьте дни рождения")
                .font(.headline)
                .fontWeight(.bold)
                .foregroundColor(.secondary)
        }
    }
}

struct PersonCell: View {
    var person: PersonData
    
    var body: some View {
        HStack(spacing: 15) {
            person.image
                .resizable()
                .aspectRatio(contentMode: .fill)
                .clipShape(Circle())
                .frame(width: 60)
            
            VStack(alignment: .leading) {
                Text(person.firstName + " " + person.secondName)
                    .font(.title3)
                    .fontWeight(.bold)
                
                Text(getDateString(date: person.date))
                    .font(.caption)
                    .fontWeight(.medium)
                    .foregroundColor(.secondary)
                
                Spacer()
                
            }
        }
    }
    
    func getDateString(date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "d MMMM"
        let dayString = formatter.string(from: date)
        
        formatter.dateFormat = "y"
        let year = Int(formatter.string(from: Date()))! - Int(formatter.string(from: date))!
        
        if year > 0 {
            return "\(dayString) будет \(year)"
        }
        
        return "\(dayString)"
    }
}

let data = [PersonData(date: Date(), firstName: "Дмитрий", secondName: "Юдин", image: Image(systemName: "photo")), PersonData(date: Date(), firstName: "Дмитрий", secondName: "Юдин", image: Image(systemName: "photo"))]

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
