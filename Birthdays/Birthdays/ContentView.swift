//
//  ContentView.swift
//  Birthdays
//
//  Created by Дмитрий Юдин on 07.08.2021.
//

import SwiftUI
import SwiftlySearch

struct ContentView: View {
    @State var searchText = ""
    
    var body: some View {
        NavigationView {
            
            ScrollView {
                ForEach(0..<100) { _ in
                    Text("Hello, world")
                }
            }.navigationBarTitle("Birthdays!")
            .navigationBarSearch(self.$searchText)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
