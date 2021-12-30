//
//  CollectionEditView.swift
//  TrueDatabase
//
//  Created by Darrien Huntley on 12/30/21.
//


import SwiftUI
import Foundation
import Combine
import FirebaseFirestoreSwift
import Firebase



struct CollectionEditView : View {
    // When editing use @StateObject
    @StateObject var viewModel = CollectionViewModel()
    
    // dismiss view
    @Environment(\.presentationMode) var presentationMode
    
    
    // Image Picker....
    @State var showImagePicker = false
    @State var selectedUIImage: UIImage?
    @State var image : Image?
    
    
    func loadImage() {
        guard let selectedImage  = selectedUIImage else { return }
        image = Image(uiImage: selectedImage)
    }
    
    
    var body: some View {
        NavigationView{
            VStack {
                Form{
                    Section(header: Text("Collection")) {
                        TextField("Title", text: $viewModel.collection.title)
                        
                        // value switch between int and string BUT HAVE TO HIT ENTER INORDER FOR IT TO UPDATE , SO use a  toggle instead
                        TextField("Pages", value: $viewModel.collection.numberofPages , formatter: NumberFormatter())
                        
                    }
                    
                    Section(header: Text("Collection")) {
                        TextField("Author", text: $viewModel.collection.author)
                    }
                    
                }
                    
                    Button(action: {
                        showImagePicker.toggle()
                    }) {
                        ZStack {
                            if let image = image {
                                image
                                    .resizable()
                                    .scaledToFill()
                                    .frame(width: 140, height: 140)
                                    .clipped()
                                    .cornerRadius(70)
                                    .padding(.top, 88)
                                    .padding(.bottom, 16)
                                
                            } else {
                                Image("plus_photo")
                                    .resizable()
                                //                                      .renderingMode(.template)
                                    .scaledToFill()
                                    .frame(width: 140, height: 140)
                                    .padding(.top, 88)
                                    .padding(.bottom, 16)
                                //   .foregroundColor(.white)
                            }
                        }
                    }
                    .sheet(isPresented: $showImagePicker, onDismiss: loadImage, content: {
                        ImagePicker(image: $selectedUIImage)
                    })
                
            }
            .navigationBarTitle("New Collection", displayMode: .inline)
            .navigationBarItems(
                leading:
                    Button(action: {
                        handleCancelTapped()
                    }) {
                        Text("Cancel")
                    }
                ,trailing:
                    Button(action: {
                        
                        guard let image = selectedUIImage else { return }
                        
                        viewModel.addCollectionToFirebase(selectedImage: image)
                        
                    }) {
                        Text("Done")
                    }.disabled(!viewModel.modified)
            )
        }
    }
    
//
    func handleCancelTapped() {
        dismiss()
    }

//
//    func handleDoneTapped(image: String) {
//        viewModel.save(image: image)
//        dismiss()
//    }
//
//
    func dismiss() {
        presentationMode.wrappedValue.dismiss()
    }
}

struct CollectionEditView_Previews: PreviewProvider {
    static var previews: some View {
        CollectionEditView()
    }
}
