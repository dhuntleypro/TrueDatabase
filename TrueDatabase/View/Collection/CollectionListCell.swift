//
//  CollectionListCell.swift
//  TrueDatabase
//
//  Created by Darrien Huntley on 12/30/21.
//

import SwiftUI
import Kingfisher

struct CollectionListCell: View {
    var collection: Collection
    var body: some View {
        HStack {
            
            KFImage(URL(string: collection.image))
                .resizable()
                .scaledToFill()
                .clipped()
                .frame(width: 64, height: 64)
                .cornerRadius(32)
            
            VStack(alignment: .leading) {
                Text(collection.title)
                    .font(.headline)
                Text(collection.author)
                    .font(.subheadline)
                Text("\(collection.numberofPages) pages")
                    .font(.subheadline)
                
            }
        }
    }
}

struct CollectionListCell_Previews: PreviewProvider {
    static var previews: some View {
        CollectionListCell(collection: Collection(id: "", title: "test title", author: "test author", numberofPages: 3, image: "plus_photo"))
    }
}
