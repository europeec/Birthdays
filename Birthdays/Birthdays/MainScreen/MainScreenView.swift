//
//  MainScreenView.swift
//  Birthdays
//
//  Created by Дмитрий Юдин on 12.08.2021.
//

import SwiftUI
import CoreData

struct MainScreenView: View {
    @Environment(\.managedObjectContext) var managedObjectContext
    let model = Model.shared
    @State var searchText = ""
    @State var days: (past: [Days]?, today: [Days]?, future: [Days]?)
    
    init() {
        days = model.getData(search: nil)
    }
    
    var body: some View {
        NavigationView {
            List {
                if days.past != nil {
                    Section(header: Text("Прошедшие дни рождения")) {
                        ForEach(days.past!) { day in
                            PersonCellView(day: day)
                        }.onDelete(perform: { indexSet in
                            let index = indexSet.first
                            model.delete(days.past?[index!])
                            updateData(searchText: searchText)
                        })
                    }
                }
                
                if days.today != nil {
                    Section(header: Text("Cегодня")) {
                        ForEach(days.today!) { day in
                            PersonCellView(day: day)
                        }.onDelete(perform: { indexSet in
                            let index = indexSet.first
                            model.delete(days.today?[index!])
                            updateData(searchText: searchText)
                        })
                    }
                }
                
                if days.future != nil {
                    Section(header: Text("Ближайшие дни рождения")) {
                        ForEach(days.future!) { day in
                            PersonCellView(day: day)
                        }.onDelete(perform: { indexSet in
                            let index = indexSet.first
                            model.delete(days.future?[index!])
                            updateData(searchText: searchText)
                        })
                    }
                }
            }.onAppear {
                self.updateData(searchText: searchText)
            }
            .onChange(of: searchText) { _ in
                self.updateData(searchText: searchText)
            }
            .navigationBarTitle("Birthdays!")
            .navigationBarSearch(self.$searchText)
            .navigationBarItems(trailing: AddButton().environment(\.managedObjectContext, self.managedObjectContext))
        }
    }
    
    private func updateData(searchText: String) {
        self.days = self.model.getData(search: searchText)
    }
}

struct MainScreenView_Previews: PreviewProvider {
    static var previews: some View {
        MainScreenView()
    }
}
