//
//  DataGeneration.swift
//  DragonExpense
//
//  Created by Martijn van de Wetering on 01/10/2023.
//

import Foundation
import SwiftData

public class DataGeneration {
    static let schema = Schema([DRETransaction.self, DRECategory.self])
    
    static func generateAll(modelContext: ModelContext) {
        DRECategory.generateAll(modelContext: modelContext)
        DRETransaction.generateAll(modelContext: modelContext)
        DREBudget.generateAll(modelContext: modelContext)
    }
}
