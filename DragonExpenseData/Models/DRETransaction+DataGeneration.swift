//
//  Expense+DataGeneration.swift
//  DragonExpense
//
//  Created by Martijn van de Wetering on 01/10/2023.
//

import OSLog
import SwiftData

private let logger = Logger(subsystem: "Dragon Expense", category: "Data Generation")

public extension DRETransaction {
    private static func toDate(year: Int, month: Int, day: Int) -> Date {
        let calendar = Calendar.current
        var components = DateComponents()
        components.year = year
        components.month = month
        components.day = day
        
        return calendar.date(from: components)!
    }
    
    static func generateAll(modelContext: ModelContext) {
        logger.info("Generate expenses")
        
        let allCategories = try! modelContext.fetch(FetchDescriptor<DRECategory>())
        let defaultCategory = allCategories.first(where: { $0.name == "No Category" })!
        
        let incommingTransaction = DRETransaction(
            title: "Paycheck",
            amount: DREMoney(
                amount: Decimal(
                    3200.54
                ),
                currency: "EUR"
            ),
            type: DRETransactionType.incomming,
            expenseDate: toDate(year: 2023, month: 10, day: 1)
        )
        modelContext.insert(incommingTransaction)
        incommingTransaction.category = defaultCategory

        for i in 1 ... 3 {
            let transaction = DRETransaction(
                title: "Expense \(i)",
                amount: DREMoney(
                    amount: Decimal(
                        21.54
                    ),
                    currency: "EUR"
                ),
                type: DRETransactionType.outgoing,
                expenseDate: toDate(year: 2023, month: 10, day: 1 + i)
                
            )
            modelContext.insert(transaction)
            transaction.category = defaultCategory
        }
    }
}
