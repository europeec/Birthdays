//
//  AddButton.swift
//  Birthdays
//
//  Created by Дмитрий Юдин on 07.08.2021.
//

import SwiftUI

struct AddButton: View {
    @Binding var data: [Days]?
    
    var body: some View {
        NavigationLink(
            destination: AddScreen(data: $data),
            label: {
                Image(systemName: "plus.circle")
                    .font(.title)
            })
    }
}