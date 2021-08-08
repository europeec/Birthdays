//
//  AddButton.swift
//  Birthdays
//
//  Created by Дмитрий Юдин on 07.08.2021.
//

import SwiftUI

struct AddButton: View {
    @Binding var persons: [PersonData]
    var body: some View {
        NavigationLink(
            destination: AddScreen(persons: $persons),
            label: {
                Image(systemName: "plus.circle")
                    .font(.title)
            })
    }
}
