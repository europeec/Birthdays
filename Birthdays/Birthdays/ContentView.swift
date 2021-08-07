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
            .navigationBarItems(trailing: AddButton())
        }
    }
}

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

struct AddScreen: View {
    @State var date = Date()
    @State var firstName = ""
    @State var secondName = ""
    @State var galleryPresented = false
    @State var selectedImage = Image(systemName: "camera")
    
    var body: some View {
        VStack(spacing: 50) {
            VStack(alignment: .leading) {
                Text("1. Укажите имя и фамилию")
                    .font(.title2)
                    .fontWeight(.medium)
                
                TextField("Дима", text: $firstName)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                TextField("Юдин", text: $secondName)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
            }
                        
            VStack {
                HStack {
                    Text("2. Укажите дату рождения")
                        .font(.title2)
                        .fontWeight(.medium)
                    
                    Spacer()
                }
                
                DatePicker("", selection: $date, in: PartialRangeThrough(Date()), displayedComponents: [.date])
                    .datePickerStyle(WheelDatePickerStyle())
                    .labelsHidden()
            }
            
            VStack {
                HStack {
                    Text("3. Добавим фотографию (необязательно)")
                        .font(.title2)
                        .fontWeight(.medium)
                    
                    Spacer()
                }
                
                Button("add", action: {
                    withAnimation {
                        galleryPresented.toggle()
                    }
                })
            }
            
            Spacer()
        }.padding()
        .navigationTitle("Добавление")
        .sheet(isPresented: $galleryPresented, content: {
            ImagePicker(image: $selectedImage)
        })
    }
}

struct ImagePicker: UIViewControllerRepresentable {
    @Environment(\.presentationMode) var presentationMode
    @Binding var image: Image
    
    class Coordinator: NSObject, UINavigationControllerDelegate, UIImagePickerControllerDelegate {
        
        @Binding var presentationMode: PresentationMode
        @Binding var image: Image
        
        init(presentationMode: Binding<PresentationMode>, image: Binding<Image>) {
            _presentationMode = presentationMode
            _image = image
        }
        
        func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
            let uiImage = info[UIImagePickerController.InfoKey.originalImage] as! UIImage
            image = Image(uiImage: uiImage)
            presentationMode.dismiss()
        }
        
        func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
            presentationMode.dismiss()
        }
    }
    
    func makeCoordinator() -> Coordinator {
        return Coordinator(presentationMode: presentationMode, image: $image)
    }
    
    func makeUIViewController(context: Context) -> some UIViewController {
        let picker = UIImagePickerController()
        picker.delegate = context.coordinator
        return picker
    }
    
    func updateUIViewController(_ uiViewController: UIViewControllerType, context: Context) { }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
