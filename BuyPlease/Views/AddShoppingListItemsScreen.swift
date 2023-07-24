//
//  AddShoppingListItemsScreen.swift
//  BuyPlease
//
//  Created by Vlad Dzirko on 24.07.2023.
//

import SwiftUI
import RealmSwift

struct AddShoppingListItemsScreen: View {
    
    @ObservedRealmObject var shoppingList: ShoppingList
    
    @State private var title: String = ""
    @State private var quantity: String = ""
    @State private var selectedCategory = ""
    
    @Environment(\.dismiss) private var dismiss
    
    let columns = [GridItem(.flexible()), GridItem(.flexible()), GridItem(.flexible())]
    let data = ["Produce", "Fruit", "Meat", "Condiments", "Beverages", "Snacks", "Dairy"]
    
    var body: some View {
        NavigationView {
            VStack {
                LazyVGrid(columns: columns) {
                    ForEach(data, id: \.self) { item in
                        Text(item)
                            .padding()
                            .frame(width: 130)
                            .background(selectedCategory == item ? .orange : .green)
                            .clipShape(RoundedRectangle(cornerRadius: 10, style: .continuous))
                            .foregroundColor(.white)
                            .onTapGesture {
                                selectedCategory = item
                            }
                    }
                }
                Spacer() .frame(height: 60)
                
                TextField("Enter title", text: $title)
                    .textFieldStyle(.roundedBorder)
                TextField("Enter quantity", text: $quantity)
                    .textFieldStyle(.roundedBorder)
                
                Button {
                    let shoppingItem = ShoppingItem()
                    shoppingItem.title = title
                    shoppingItem.quantity = Int(quantity) ?? 1
                    shoppingItem.category = selectedCategory
                    $shoppingList.items.append(shoppingItem)
                    
                    dismiss()
                } label: {
                    Text("Save")
                        .frame(maxWidth: .infinity, maxHeight: 40)
                        .foregroundColor(.green)
                }
                .buttonStyle(.bordered)
                .padding(.top, 20)

                Spacer()
                
                .navigationTitle("Add item")
                .navigationBarTitleDisplayMode(.inline)
            }
        }
    }
}

struct AddShoppingListItemsScreen_Previews: PreviewProvider {
    static var previews: some View {
        AddShoppingListItemsScreen(shoppingList: ShoppingList())
    }
}
