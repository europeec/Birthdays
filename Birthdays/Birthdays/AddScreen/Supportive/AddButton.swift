//
//  AddButton.swift
//  Birthdays
//
//  Created by Дмитрий Юдин on 07.08.2021.
//

import SwiftUI

struct AddButton: View {
    var body: some View {
        NavigationLink(
            destination: AddScreen(),
            label: {
                Image(systemName: "plus.circle")
                    .font(.title)
            })
    }
}
