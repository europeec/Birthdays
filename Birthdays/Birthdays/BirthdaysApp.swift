//
//  BirthdaysApp.swift
//  Birthdays
//
//  Created by Дмитрий Юдин on 07.08.2021.
//

import SwiftUI

@main
struct BirthdaysApp: App {
    @Environment(\.scenePhase) var scenePhase
    let model = Model.shared
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, model.managedObjectContext)
        }.onChange(of: scenePhase) { _ in
            model.saveContext()
        }
    }
}
