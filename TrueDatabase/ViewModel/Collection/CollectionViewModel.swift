//
//  CollectionViewModel.swift
//  TrueDatabase
//
//  Created by Darrien Huntley on 12/30/21.
//

import SwiftUI
import Foundation
import Combine
import FirebaseFirestoreSwift
import Firebase

class CollectionViewModel: ObservableObject{
    // hold collection called collection and Instantiate and empty array
    @Published var collection : Collection
    
    // track if fields are modified / not empty
    @Published var modified = false
    
    
    private var db = Firestore.firestore()
    
    private var cancellables = Set<AnyCancellable>()
    
    init(collection: Collection = Collection(id: "123" , title: "", author: "", numberofPages: 0 , image: "", images: [""])) {
        self.collection = collection
        
        self.$collection
            .dropFirst()
            .sink { [ weak self ] collection in
                self?.modified = true
            }
            .store(in: &cancellables)
    }
    
    
// MARK: - did not use...
    
    
    // Add a new Collection
    func addCollection1(collection: Collection , image : String) {
        do {
            let _ = try  db
                .collection("collections")
                .addDocument(from: collection)
            
            // update image...
            db
                .collection("collections").document(collection.id!)
            .updateData(["image" : "test"])

        }
        catch {
            print(error)
        }

    }
    
    // Save edits to firebase
    func save1(image: String) {
        addCollection1(collection: collection, image: image)
    }
    
    
  
     func updateCollection(_ collection: Collection) {
        if let documentId = collection.id {
            do {
                try db.collection("collections").document(documentId).setData(from: collection)
            }
            catch {
                print(error)
            }
        }
    }
    
    // Save edits to firebase
    func save() {
        addCollection(collection: collection)
    }
    
    
    
    
    func addCollection(collection: Collection) {
        do {
            let _ = try  db
                .collection("collections")
                .addDocument(from: collection)
      
        }
        catch {
            print(error)
        }
    }
//
    
    
// MARK: - WORKING......

    // upload collection with selected picker image
    func addCollectionToFirebase(selectedImage: UIImage) {
        
        
       
        guard let imageData = selectedImage.jpegData(compressionQuality: 0.3) else { return }
        
        print("DEBUG: 2")
        
        let filename = NSUUID().uuidString
        let storageRef = Storage.storage().reference().child(filename)
        
        storageRef.putData(imageData, metadata: nil) { _, error in
            if let error = error {
                print("DEBUG: Fail tp upload image \(error.localizedDescription)")
            }
            
            
            storageRef.downloadURL { url, _ in
                guard let selectedImage = url?.absoluteString else { return }
                
       
       
                let currentCollectionRef = Firestore.firestore().collection("collections").document()
       
                  //     let collectionID = currentCollectionRef.documentID
       
              //   correct set values... (fix)
                let data: [String: Any] = [ "author" : self.collection.author,
                                          //  "image" : viewModel.collection.image,
                                            "image" : selectedImage,
                                            "images" :  self.collection.images,
                                            "pages" : self.collection.numberofPages,
                                            "title" : self.collection.title,
                                            
                   ]

                   // Add collection to All Collections
                   currentCollectionRef.setData(data)
            //    currentCollectionRef.updateData(["image" : "test"])
               
                
                
       
               // viewModel.collection.image = image
                print("DEBUG: 3")
            //    handleDoneTapped(image: image)

            }
        }
    }
    
    
}

