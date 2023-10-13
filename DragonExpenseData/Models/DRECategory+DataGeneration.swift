//
//  Category+DataGeneration.swift
//  DragonExpense
//
//  Created by Martijn van de Wetering on 04/10/2023.
//

import Foundation
import SwiftData
import SwiftUI

public extension DRECategory {
    static func generateAll(modelContext: ModelContext) {
        modelContext.insert(DRECategory(id: "No Category", name: "No Category", icon: SFSymbols.list, color: UIColor(Color.gray)))
        modelContext.insert(DRECategory(id: "Groceries", name: "Groceries", icon: SFSymbols.car, color: UIColor(Color.blue)))
        modelContext.insert(DRECategory(id: "Food & Drink", name: "Food & Drink", icon: SFSymbols.forkKnife, color: UIColor(Color.red)))
        modelContext.insert(DRECategory(id: "Entertainment", name: "Entertainment", icon: SFSymbols.headphones, color: UIColor(Color.green)))
    }
}
