//
//  CollectionListView.swift
//  TrueDatabase
//
//  Created by Darrien Huntley on 12/30/21.
//

import SwiftUI
import Kingfisher




// MARK: - VIEW (BOOK)

struct CollectionListView: View {
    // var collections = testData
    
    @ObservedObject private var viewModel = CollectionsViewModel()
    
    @State private var presentAddNewCollectionSreen = false
    var body: some View {
        List(viewModel.collections) { collection in
            NavigationLink(destination: CollectionUpdateView(collection: collection)){
                CollectionListCell(collection: collection)
            }
        }
        .navigationTitle(Text("Collections"))
        .sheet(isPresented: $presentAddNewCollectionSreen) {
            CollectionEditView()
        //    CollectionNameEdit()
        }
        .navigationBarItems(
            trailing:
                Button(action: {
                    presentAddNewCollectionSreen.toggle()
                }) {
                    Image(systemName: "plus")
                }
        )
        .onAppear() {
            self.viewModel.subscribe()
        }
    }
}

struct CollectionListView_Previews: PreviewProvider {
    static var previews: some View {
        CollectionListView()
    }
}
