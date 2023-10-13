//
//  Budget+DataGeneration.swift
//  DragonExpense
//
//  Created by Martijn van de Wetering on 09/10/2023.
//

import OSLog
import SwiftData

private let logger = Logger(subsystem: "Dragon Expense", category: "Data Generation")

public extension DREBudget {
    static func generateAll(modelContext: ModelContext) {
        logger.info("Generate budgets")
        
        let transactions = try! modelContext.fetch(FetchDescriptor<DRETransaction>())
        
        let budget = DREBudget(name: "Household")
        modelContext.insert(budget)
        budget.transactions?.append(contentsOf: transactions)
        
        modelContext.insert(DREBudget(name: "Vacation"))
        modelContext.insert(DREBudget(name: "Work trip"))
        
    }
}
