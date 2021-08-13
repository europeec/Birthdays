//
//  MainScreenView.swift
//  Birthdays
//
//  Created by Дмитрий Юдин on 12.08.2021.
//

import SwiftUI

struct MainScreenView: View {
    @State var searchText = ""
    let model = Model.shared
    @State var data: [Days]?
    
    init() {
        self.data = model.days
    }
    
    var body: some View {
        NavigationView {
            List {
                let days = model.getData(search: searchText)
                                
                if days.past != nil {
                    Section(header: Text("Прошедшие дни рождения")) {
                        ForEach(days.past!) { day in
                            PersonCellView(day: day)
                        }.onDelete(perform: { indexSet in
                            
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
                        })
                    }
                }
                
                if days.future != nil {
                    Section(header: Text("Ближайшие дни рождения")) {
                        ForEach(days.future!) { day in
                            PersonCellView(day: day)
                        }.onDelete(perform: { indexSet in
                            
                        })
                    }
                }
            }.navigationBarTitle("Birthdays!")
            .navigationBarSearch(self.$searchText)
            .navigationBarItems(trailing: AddButton(data: $data))
        }
    }
}

struct MainScreenView_Previews: PreviewProvider {
    static var previews: some View {
        MainScreenView()
    }
}
