//
//  ContentView.swift
//  TrueDatabase
//
//  Created by Darrien Huntley on 12/30/21.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        NavigationView {
            CollectionListView()
          //  CollectionArrayView()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
