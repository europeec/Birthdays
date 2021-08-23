//
//  PersonCellView.swift
//  Birthdays
//
//  Created by Дмитрий Юдин on 12.08.2021.
//

import SwiftUI

struct PersonCellView: View {
    @State var isSharePresented = false
    var day: Days
    
    var body: some View {
        let person = Model.shared.convertDayToPerson(day: day)
        
        HStack(alignment: .top, spacing: 15) {
            Image(uiImage: person.image)
                .resizable()
                .aspectRatio(contentMode: .fill)
                .clipShape(Circle())
                .frame(width: 45, height: 45)
            
            VStack(alignment: .leading) {
                Text(person.firstName + " " + person.secondName)
                    .font(.title3)
                    .fontWeight(.bold)
                    .lineLimit(2)
                    .minimumScaleFactor(0.7)
                    .truncationMode(.middle)
                
                let dateString = DateManager.getDateString(date: person.date)
                Text(dateString)
                    .font(.caption)
                    .fontWeight(.medium)
                    .foregroundColor(.secondary)
                
                Spacer()
                
            }.frame(height: 45)
            
            Spacer()
            
            let age = DateManager.calculateAge(person: person)
            CircleYearView(age: age)
        }.contextMenu {
            Button("Добавить в календарь", action: {
                EventManager.shared.addDay(day: day)
            })
            Button("Поделиться", action: {
                isSharePresented = true
            })
        }
        .sheet(isPresented: $isSharePresented, content: {
                ActivityController(sharingMessage: person.getMessage())
               })
    }
}
