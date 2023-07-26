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
    @State private var selectedCategory: String = "All"
    @ObservedRealmObject var shoppingList: ShoppingList
    
    var items: [ShoppingItem] {
        if(selectedCategory == "All") {
            return Array(shoppingList.items)
        } else {
            return shoppingList.items.sorted(byKeyPath: "title")
                .filter { $0.category == selectedCategory }
        }
    }
    
    var body: some View {
        VStack {
            
            CategoryFilterView(selectedCategory: $selectedCategory)
                .padding()
            
            if items.isEmpty {
                Text("No items found.")
            }
            
            List {
                ForEach(items) { item in
                    
                    NavigationLink {
                        AddShoppingListItemsScreen(shoppingList: shoppingList, itemToEdit: item)
                    } label: {
                        ShoppingItemCell(item: item, selected: selectedItemIds.contains(item.id)) { selected in
                            if selected {
                                selectedItemIds.append(item.id)
                                if let indexToDelete = shoppingList.items.firstIndex(where: {$0.id == item.id}) {
                                    $shoppingList.items.remove(at: indexToDelete)
                                }
                            }
                        }
                    }

                    
                    
                }
                .onDelete(perform: $shoppingList.items.remove)
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
