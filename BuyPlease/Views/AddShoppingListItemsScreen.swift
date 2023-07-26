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
    var itemToEdit: ShoppingItem?
    
    @State private var title: String = ""
    @State private var quantity: String = ""
    @State private var selectedCategory = ""
    
    @Environment(\.dismiss) private var dismiss
    
    let columns = [GridItem(.flexible()), GridItem(.flexible()), GridItem(.flexible())]
    let data = ["Produce", "Fruit", "Meat", "Condiments", "Beverages", "Snacks", "Dairy"]
    
    init(shoppingList: ShoppingList, itemToEdit: ShoppingItem? = nil) {
        self.shoppingList = shoppingList
        self.itemToEdit = itemToEdit
        
        if let itemToEdit = itemToEdit {
            _title = State(initialValue: itemToEdit.title)
            _quantity = State(initialValue: String(itemToEdit.quantity))
            _selectedCategory = State(initialValue: itemToEdit.category)
        }
    }
    
    var isEditing: Bool {
        itemToEdit == nil ? false : true
    }
    
    var body: some View {
        VStack(alignment: .leading) {
            if !isEditing {
                Text("Add New Item")
                    .font(.largeTitle)
                    .padding()
            }
            
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
                
                if let _ = itemToEdit {
                    update()
                } else {
                    save()
                }
                
                dismiss()
                
            } label: {
                Text(isEditing ? "Update" : "Save")
                    .frame(maxWidth: .infinity, maxHeight: 40)
                    .foregroundColor(.green)
            }
            .buttonStyle(.bordered)
            .padding(.top, 20)
            
            Spacer()
            
                .navigationTitle(isEditing ? "Update Item" : "Add item")
                .navigationBarTitleDisplayMode(.inline)
        }
    }
    
    private func save() {
        let shoppingItem = ShoppingItem()
        shoppingItem.title = title
        shoppingItem.quantity = Int(quantity) ?? 1
        shoppingItem.category = selectedCategory
        $shoppingList.items.append(shoppingItem)
    }
    
    private func update() {
        if let itemToEdit = itemToEdit {
            do {
                let realm = try Realm()
                guard let objectToUpdate = realm.object(ofType: ShoppingItem.self, forPrimaryKey: itemToEdit.id) else { return }
                try realm.write {
                    objectToUpdate.title = title
                    objectToUpdate.category = selectedCategory
                    objectToUpdate.quantity = Int(quantity) ?? 1
                }
            }
            catch {
                print(error)
            }
        }
    }
}

struct AddShoppingListItemsScreen_Previews: PreviewProvider {
    static var previews: some View {
        AddShoppingListItemsScreen(shoppingList: ShoppingList())
    }
}
