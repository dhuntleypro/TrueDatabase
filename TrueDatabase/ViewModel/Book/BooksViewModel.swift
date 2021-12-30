//
//  BooksViewModel.swift
//  TrueDatabase
//
//  Created by Darrien Huntley on 12/30/21.
//

import SwiftUI
import Firebase
import FirebaseFirestoreSwift
import Combine

class BooksViewModel: ObservableObject{
    // hold collection called book and Instantiate and empty array
    @Published var books = [Book]()
    
    
    
    private var db = Firestore.firestore()
    
    
    // Subscribe to any changes in Book
    func subscribe() {
        db
            .collection("books")
            .addSnapshotListener { (querySnapshot, error) in
                // Checks if docmuent exist
                guard let documents = querySnapshot?.documents else {
                    print("No documents")
                    return
                }
                
                //   self.books = documents.compactMap { (queryDocumentSnapshot) -> Book? in
                self.books = documents.compactMap { queryDocumentSnapshot in
                    
                    //  return
                    try? queryDocumentSnapshot.data(as: Book.self)
                    
                }
            }
    }
}
