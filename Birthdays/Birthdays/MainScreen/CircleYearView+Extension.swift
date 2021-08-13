//
//  CircleYearView+Extension.swift
//  Birthdays
//
//  Created by Дмитрий Юдин on 12.08.2021.
//

import SwiftUI

struct CircleYearView: View {
    var age: Int
    
    var body: some View {
        if age > 0 {
            ZStack {
                Circle()
                    .foregroundColor(Color.random())
                    .opacity(0.3)
                
                Text(String(age))
                    .font(.caption2)
                    .fontWeight(.medium)
                    .lineLimit(1)
                    .minimumScaleFactor(0.7)
                    .frame(width: 20)
            }.frame(width: 27, height: 27)
        }
    }
}

// MARK: - Extension Color
extension Color {
    static func random() -> Color {
        return Color(red: .random(in: 0...1), green: .random(in: 0...1), blue: .random(in: 0...1))
    }
}
