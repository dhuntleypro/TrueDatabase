//
//  Book.swift
//  TrueDatabase
//
//  Created by Darrien Huntley on 12/30/21.
//

import SwiftUI
import Firebase
import FirebaseFirestoreSwift
import Combine

// MARK: - MODEL (BOOK)
struct Book: Identifiable , Codable {
    // Read Document ID
    @DocumentID var id: String? = UUID().uuidString
    
    var title: String
    var author: String
    var numberofPages: Int
    var image: String
    
    //  Account for different names between firebase and model
    enum CodingKeys : String , CodingKey {
        case title
        case author
        case numberofPages = "pages"
        case image
    }
}
