//
//  BuyPleaseApp.swift
//  BuyPlease
//
//  Created by Vlad Dzirko on 23.07.2023.
//

import SwiftUI

@main
struct BuyPleaseApp: App {
    
    let migrator = Migrator()
    
    var body: some Scene {
        WindowGroup {
            let _ = UserDefaults.standard.set(false, forKey: "_UIConstraintBasedLayoutLogUnsatisfiable")
            let _ = print(FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!.path())
            ContentView()
        }
    }
}
