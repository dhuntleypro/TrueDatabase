//
//  CollectionUpdateView.swift
//  TrueDatabase
//
//  Created by Darrien Huntley on 12/30/21.
//

import SwiftUI

struct CollectionUpdateView: View {
    @StateObject var viewModel = CollectionViewModel()

    var collection: Collection
    
    

    
    
    
    var body: some View {
        VStack {
//            TextField("Title", text: $viewModel.collection.title)
//
//            // value switch between int and string BUT HAVE TO HIT ENTER INORDER FOR IT TO UPDATE , SO use a  toggle instead
//            TextField("Pages", value: $viewModel.collection.numberofPages , formatter: NumberFormatter())
//
            CustomTextField(text:  $viewModel.collection.title, placeholder: Text("\(collection.title)") , imageName: "envelope", color: .black)
                .padding()
                .foregroundColor(.black)
            
            CustomTextField(text:   $viewModel.collection.author, placeholder: Text("Announcement Name"), imageName: "tag.fill", color: .black)
                .font(.system(size: 23))
                .foregroundColor(.black)
            
            Button(action: {
//                if let _ = collection.id {
//                    viewModel.updateCollection(self.collection)
//                    print("DEBUG: update Collection")
//                }
//                else {
//               //     addCollection(collection)
//                    guard let image = selectedUIImage else { return }
//                   addCollectionToFirebase(selectedImage: image)
//                    print("DEBUG: add Collection")
//                }
//
            }) {
                Text("Update")
            }
            
        }
        
    }
    
}

struct CollectionUpdateView_Previews: PreviewProvider {
    static var previews: some View {
        CollectionUpdateView(collection: Collection(id: "", title: "test title", author: "test author", numberofPages: 3, image: "plus_photo", images: ["plus_photo" , "plus_photo"]))
    }
}
