//
//  ShoppingList.swift
//  BuyPlease
//
//  Created by Vlad Dzirko on 23.07.2023.
//

import Foundation
import RealmSwift

class ShoppingList: Object, Identifiable {
    
    @Persisted(primaryKey: true) var id: ObjectId
    @Persisted var title: String
    @Persisted var address: String
    
    @Persisted var items: List<ShoppingItem> = List<ShoppingItem>()
    
    override class func primaryKey() -> String? {
        "id"
    }
}
