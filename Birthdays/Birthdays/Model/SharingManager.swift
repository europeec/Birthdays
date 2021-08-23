//
//  SharingManager.swift
//  Birthdays
//
//  Created by Дмитрий Юдин on 16.08.2021.
//

import UIKit
import SwiftUI

// https://stackoverflow.com/questions/35931946/basic-example-for-sharing-text-or-image-with-uiactivityviewcontroller-in-swift
// activity view controller

struct ActivityController: UIViewControllerRepresentable {
    
    @Environment(\.presentationMode) var presentationMode
    var sharingMessage: String
    
    func makeUIViewController(context: Context) -> some UIViewController {
        let controller = UIActivityViewController(activityItems: [sharingMessage], applicationActivities: nil)
        controller.excludedActivityTypes = [.addToReadingList, .copyToPasteboard, .mail, .message, .postToFacebook, .postToTwitter]
        controller.title = "Расскажите о дне рождения"
        controller.completionWithItemsHandler = { _, _, _, _ in
            self.presentationMode.wrappedValue.dismiss()
        }
        return controller
    }
    
    func updateUIViewController(_ uiViewController: UIViewControllerType, context: Context) {}
}
