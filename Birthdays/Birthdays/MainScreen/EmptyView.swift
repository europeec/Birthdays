//
//  EmptyView.swift
//  Birthdays
//
//  Created by Дмитрий Юдин on 12.08.2021.
//

import SwiftUI

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

struct EmptyView_Previews: PreviewProvider {
    static var previews: some View {
        EmptyView()
    }
}
