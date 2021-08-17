//
//  AddButton.swift
//  Birthdays
//
//  Created by Дмитрий Юдин on 07.08.2021.
//

import SwiftUI

struct AddButton: View {
    @State var isPresented = false
    var body: some View {
        HStack {
            Button {
                isPresented.toggle()
            } label: {
                Image(systemName: "calendar.circle")
                    .font(.title)
            }
            
            NavigationLink(
                destination: AddScreen(),
                label: {
                    Image(systemName: "plus.circle")
                        .font(.title)
                })
        }.actionSheet(isPresented: $isPresented) {
            let buttons = [ActionSheet.Button.cancel(Text("Удаляем"), action: { EventManager.shared.removeCalendar()}),
                           ActionSheet.Button.default(Text("Переносим"), action: { EventManager.shared.addDays()})]
            return ActionSheet(title: Text("Так-с, календарь"),
                        message: Text("Что будем делать с календарем? Перенесем все дни рождения, или удалим их из календаря?"),
                        buttons: buttons)
        }
    }
}
