//
//  ShoppingListItemsScreen.swift
//  BuyPlease
//
//  Created by Vlad Dzirko on 24.07.2023.
//

import SwiftUI
import RealmSwift

struct ShoppingListItemsScreen: View {
    
    @State private var isPresented: Bool = false
    @State private var selectedItemIds: [ObjectId] = []
    @ObservedRealmObject var shoppingList: ShoppingList
    
    var body: some View {
        VStack {
            if shoppingList.items.isEmpty {
                Text("No items found.")
            }
            
            List {
                ForEach(shoppingList.items) { item in
                    ShoppingItemCell(item: item, selected: selectedItemIds.contains(item.id)) { selected in
                        if selected {
                            selectedItemIds.append(item.id)
                        }
                    }
                }
            }
            
            
            
            .navigationTitle(shoppingList.title)
            .navigationBarTitleDisplayMode(.inline)
        }
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                Button {
                    isPresented = true
                } label: {
                    Image(systemName: "plus")
                }
            }
        }
        .sheet(isPresented: $isPresented) {
            AddShoppingListItemsScreen(shoppingList: shoppingList)
        }
    }
}

struct ShoppingListItemsScreen_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            ShoppingListItemsScreen(shoppingList: ShoppingList())
        }
    }
}
