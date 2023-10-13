//
//  DragonExpenseApp.swift
//  DragonExpense
//
//  Created by Martijn van de Wetering on 22/09/2023.
//

import SwiftUI
import SwiftData
import DragonExpenseData

@main
struct DragonExpenseApp: App {
    init() {
        ValueTransformer.setValueTransformer(UIColorValueTransformer(), forName: NSValueTransformerName("UIColorValueTransformer"))
    }
    
    
    var body: some Scene {
        WindowGroup {
            NavigationStack {
                TransactionsScreen()
            }
            .dragonExpenseDataContainer(inMemory: true)
        }
    }
}
