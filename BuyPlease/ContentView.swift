//
//  ContentView.swift
//  BuyPlease
//
//  Created by Vlad Dzirko on 23.07.2023.
//

import SwiftUI
import RealmSwift

struct ContentView: View {
    
    @ObservedResults(ShoppingList.self) var shoppingLists
    
    @State private var isPresented: Bool = false
    
    var body: some View {
        NavigationView {
            VStack {
                if shoppingLists.isEmpty {
                    Text("No shopping list")
                }
                
                List {
                    ForEach(shoppingLists, id: \.id) { shoppingList in
                        NavigationLink {
                            ShoppingListItemsScreen(shoppingList: shoppingList)
                        } label: {
                            VStack(alignment: .leading) {
                                Text(shoppingList.title)
                                Text(shoppingList.address)
                                    .opacity(0.4)
                            }
                        }
                    }
                    .onDelete(perform: $shoppingLists.remove)
                }
                
                .navigationTitle("Magazin")
                .navigationBarTitleDisplayMode(.inline)
            }
            .sheet(isPresented: $isPresented, content: {
                AddShopingListScreen()
            })
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button {
                        isPresented = true
                    } label: {
                        Image(systemName: "plus")
                    }

                }
        }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
