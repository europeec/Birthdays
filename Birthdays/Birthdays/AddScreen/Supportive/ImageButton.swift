//
//  ImageButton.swift
//  Birthdays
//
//  Created by Дмитрий Юдин on 07.08.2021.
//

import SwiftUI

struct ImageButtonView: View {
    @Binding var image: UIImage
    
    var body: some View {
            Image(uiImage: image)
                .resizable()
                .aspectRatio(contentMode: .fill)
                .clipShape(Circle())
                .frame(width: 100, height: 100)
                .overlay(
                    Circle()
                        .stroke()
                        .frame(width: 100)
                        .foregroundColor(.secondary)
                )
    }
}
