//
//  AddShopingListScreen.swift
//  BuyPlease
//
//  Created by Vlad Dzirko on 23.07.2023.
//

import SwiftUI
import RealmSwift

struct AddShopingListScreen: View {
    
    @ObservedResults(ShoppingList.self) var shoppingLists
    
    @State private var title: String = ""
    @State private var address: String = ""
    
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        NavigationView {
            Form {
                TextField("Enter title", text: $title)
                TextField("Enter address", text: $address)
                
                Button(action: {
                    
                    let shoppingList = ShoppingList()
                    shoppingList.title = title
                    shoppingList.address = address
                    $shoppingLists.append(shoppingList)
                    
                    dismiss()
                }, label: {
                    Text("Save")
                        .frame(maxWidth: .infinity)
                })
                
            }
            
            
            
            .navigationTitle("New List")
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}

struct AddShopingListScreen_Previews: PreviewProvider {
    static var previews: some View {
        AddShopingListScreen()
    }
}
