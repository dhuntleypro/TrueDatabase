//
//  BookViewModel.swift
//  TrueDatabase
//
//  Created by Darrien Huntley on 12/30/21.
//

import SwiftUI
import Firebase
import FirebaseFirestoreSwift
import Combine

class BookViewModel: ObservableObject{
    // hold collection called book and Instantiate and empty array
    @Published var book : Book
    
    // track if fields are modified / not empty
    @Published var modified = false
    
    
    private var db = Firestore.firestore()
    
    private var cancellables = Set<AnyCancellable>()
    
    init(book: Book = Book(id: "123" , title: "", author: "", numberofPages: 0 , image: "")) {
        self.book = book
        
        self.$book
            .dropFirst()
            .sink { [ weak self ] book in
                self?.modified = true
            }
            .store(in: &cancellables)
    }
    // Add a new Book
    func addBook(book: Book , image : String) {
        do {
            let _ = try  db
                .collection("books")
                .addDocument(from: book)
            
            // update image...
            db
                .collection("books").document(book.id!)
            .updateData(["image" : "test"])
            
//            { _ in
//                collectionWantRef.document(uid).setData([:]) { _ in
//                    userWantRef.document(self.collection.id).setData([:]) { _ in
//                        self.didWant = true
//                    }
//                }
//            }
            
            
            
              //  .append("image").
           //     .replacingOccurrences(of: "image", with: ["":""])
//        //        .append(book: book, image: image)
//      //          .addDocument(from: book)
                
        }
        catch {
            print(error)
        }
//
//        do {
//            let _ = try  db
//                .collection("books")
//                .document(book.id!)
//                .append(data: ["image" : "Any"])
//
//        }
//        catch {
//            print(error)
//        }
    }
    
    // Save edits to firebase
    func save(image: String) {
        addBook(book: book, image: image)
    }
}

