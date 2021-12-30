//
//  CollectionsViewModel.swift
//  TrueDatabase
//
//  Created by Darrien Huntley on 12/30/21.
//

import SwiftUI
import Firebase
import FirebaseFirestoreSwift
import Combine

class CollectionsViewModel: ObservableObject{
    // hold collection called collection and Instantiate and empty array
    @Published var collections = [Collection]()
    
    
    
    private var db = Firestore.firestore()
    
    
    // Subscribe to any changes in Collection
    func subscribe() {
        db
            .collection("collections")
            .addSnapshotListener { (querySnapshot, error) in
                // Checks if docmuent exist
                guard let documents = querySnapshot?.documents else {
                    print("No documents")
                    return
                }
                
                //   self.collections = documents.compactMap { (queryDocumentSnapshot) -> Collection? in
                self.collections = documents.compactMap { queryDocumentSnapshot in
                    
                    //  return
                    try? queryDocumentSnapshot.data(as: Collection.self)
                    
                }
            }
    }
}
