//
//  BookListView.swift
//  TrueDatabase
//
//  Created by Darrien Huntley on 12/30/21.
//

import SwiftUI



// MARK: - VIEW (BOOK)

struct BookListView: View {
    // var books = testData
    
    @ObservedObject private var viewModel = BooksViewModel()
    
    @State private var presentAddNewBookSreen = false
    var body: some View {
        List(viewModel.books) { book in
            VStack(alignment: .leading) {
                Text(book.title)
                    .font(.headline)
                Text(book.author)
                    .font(.subheadline)
                Text("\(book.numberofPages) pages")
                    .font(.subheadline)
                
            }
        }
        .navigationTitle(Text("Books"))
        .sheet(isPresented: $presentAddNewBookSreen) {
            BookEditView()
        //    BookNameEdit()
        }
        .navigationBarItems(
            trailing:
                Button(action: {
                    presentAddNewBookSreen.toggle()
                }) {
                    Image(systemName: "plus")
                }
        )
        .onAppear() {
            self.viewModel.subscribe()
        }
    }
}

struct BookListView_Previews: PreviewProvider {
    static var previews: some View {
        BookListView()
    }
}
