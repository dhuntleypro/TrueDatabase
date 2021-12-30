//
//  BookEditView.swift
//  TrueDatabase
//
//  Created by Darrien Huntley on 12/30/21.
//

import SwiftUI
import Foundation
import Combine
import FirebaseFirestoreSwift
import Firebase



struct BookEditView : View {
    // When editing use @StateObject
    @StateObject var viewModel = BookViewModel()
    
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
                    Section(header: Text("Book")) {
                        TextField("Title", text: $viewModel.book.title)
                        
                        // value switch between int and string BUT HAVE TO HIT ENTER INORDER FOR IT TO UPDATE , SO use a  toggle instead
                        TextField("Pages", value: $viewModel.book.numberofPages , formatter: NumberFormatter())
                        
                    }
                    
                    Section(header: Text("Book")) {
                        TextField("Author", text: $viewModel.book.author)
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
            .navigationBarTitle("New Book", displayMode: .inline)
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
                        
                        print("DEBUG: 1")
                       
                        guard let imageData = image.jpegData(compressionQuality: 0.3) else { return }
                        
                        print("DEBUG: 2")
                        
                        let filename = NSUUID().uuidString
                        let storageRef = Storage.storage().reference().child(filename)
                        
                        storageRef.putData(imageData, metadata: nil) { _, error in
                            if let error = error {
                                print("DEBUG: Fail tp upload image \(error.localizedDescription)")
                            }
                            
                            
                            storageRef.downloadURL { url, _ in
                                guard let image = url?.absoluteString else { return }
                                
                       
                       
                                let currentCollectionRef = Firestore.firestore().collection("books").document()
                       
                                  //     let collectionID = currentCollectionRef.documentID
                       
                              //   correct set values... (fix)
                                let data: [String: Any] = [ "author" : viewModel.book.author,
                                                          //  "image" : viewModel.book.image,
                                                            "image" : image,
                                                            "pages" : viewModel.book.numberofPages,
                                                            "title" : viewModel.book.title,
                                                            
                                   ]

                                   // Add collection to All Collections
                                   currentCollectionRef.setData(data)
                            //    currentCollectionRef.updateData(["image" : "test"])
                               
                                
                                
                       
                               // viewModel.book.image = image
                                print("DEBUG: 3")
                            //    handleDoneTapped(image: image)

                            }
                        
                    
                    }
                        
                        
                        
                        
                        
                        
                        
                        //    viewModel.createCollection(pickImageURL: image)
                        
                        
                        
                        
                    }) {
                        Text("Done")
                    }.disabled(!viewModel.modified)
            )
        }
    }
    
    
    func handleCancelTapped() {
        dismiss()
    }
    
    
    func handleDoneTapped(image: String) {
        viewModel.save(image: image)
        dismiss()
    }
    
    
    func dismiss() {
        presentationMode.wrappedValue.dismiss()
    }
}

struct BookEditView_Previews: PreviewProvider {
    static var previews: some View {
        BookEditView()
    }
}
