//
//  ContentView.swift
//  SwiftUI_Assignment_Ultimez
//
//  Created by Coditas on 02/10/24.
//

import SwiftUI

struct ProductListView: View {
    var body: some View {
        VStack {
            NavigationStack{
                Text("Hello world!")
                    .navigationTitle(Constants.Titles.appTitle)
            }
        }
        .padding()
    }
}

#Preview {
    ProductListView()
}
