//
//  AddScreen.swift
//  Birthdays
//
//  Created by Дмитрий Юдин on 07.08.2021.
//

import SwiftUI

struct AddScreen: View {
    @Environment(\.presentationMode) var presentationMode
    @Binding var persons: [PersonData]
    @State var person = PersonData(firstName: "", secondName: "", image: Image(systemName: "camera"))
    @State var galleryPresented = false
    @State var alertShowing = false
    
    var body: some View {
        List {
            Section(header: Text("1. Укажите имя и фамилию")
                        .fontWeight(.medium)) {
                VStack(alignment: .leading) {
                    
                    TextField("Дима", text: $person.firstName)
                        .overlay(
                            Divider(),
                            alignment: .bottom)
                    TextField("Юдин", text: $person.secondName)
                        .overlay(
                            Divider(),
                            alignment: .bottom)
                        .padding(.top, 5)
                }.padding(.vertical, 10)
            }
            
            Section(header: Text("2. Укажите дату рождения")
                        .fontWeight(.medium)) {
                DatePicker("", selection: $person.date, in: PartialRangeThrough(Date()), displayedComponents: [.date])
                    .datePickerStyle(WheelDatePickerStyle())
                    .labelsHidden()
            }
            
            Section(header: Text("3. Добавьте фотографию")
                        .fontWeight(.medium)) {
                LazyVStack {
                    Button(action: {
                        withAnimation {
                            galleryPresented.toggle()
                        }
                    }, label: {
                        ImageButtonView(image: $person.image)
                })
                }
            }.padding(.vertical, 10)
            
            Section(header: Text("4. Сохраните")
                        .fontWeight(.medium)) {
                LazyVStack {
                    Button(action: {
                        validation()
                    }, label: {
                        Text("Сохранить")
                            .fontWeight(.medium)
                    }).padding()
                    .padding(.horizontal, 10)
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(30)
                }
            }.padding(.vertical, 10)
            
        }.listStyle(InsetGroupedListStyle())
        .navigationTitle("Добавление")
        .navigationBarItems(trailing: Button("Готово", action: {
            validation()
        }))
        .sheet(isPresented: $galleryPresented,
               content: {
                ImagePicker(image: $person.image)
               })
        .alert(isPresented: $alertShowing, content: {
            Alert(title: Text("Пожалуйста, заполните все поля"))
        })
    }
    
    func validation() {
        if person.firstName.isEmpty || person.secondName.isEmpty {
            alertShowing = true
        } else {
            persons.append(person)
            presentationMode.wrappedValue.dismiss()
        }
    }
}

