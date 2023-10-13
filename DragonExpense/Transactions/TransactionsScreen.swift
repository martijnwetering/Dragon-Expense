//
//  ExpenseListView.swift
//  DragonExpense
//
//  Created by Martijn van de Wetering on 22/09/2023.
//

import SwiftData
import SwiftUI
import DragonExpenseData

struct TransactionsScreen: View {
    @Query(sort: \DREBudget.name) private var budgets: [DREBudget]
    
    @State private var showAddExpenseSheet = false
    @State private var selectedBudget: DREBudget?
    
    var body: some View {
        ZStack {
            if let selectedBudget {
                VStack {
                    Picker(selectedBudget.name, selection: $selectedBudget) {
                        ForEach(budgets, id: \.id) { budget in
                            Text(budget.name).tag(Optional(budget))
                        }
                    }
                    
                    if let transactions = selectedBudget.transactions {
                        if !transactions.isEmpty {
                            TransactionListView(transactions: transactions)
                        }
                        else {
                            ContentUnavailableView(label: {
                                Text("You have no transactions")
                            })
                        }
                    }
                }
            }
            
            DREAddTransactionFAB(action: { showAddExpenseSheet = true })
                .padding()
                .position(x: UIScreen.main.bounds.width - 55, y: UIScreen.main.bounds.height - 125)
                .sheet(isPresented: $showAddExpenseSheet) {
                    if let selectedBudget {
                        AddTransactionView(budget: selectedBudget)
                    }
                }
        }
        .onAppear {
            selectedBudget = budgets.first(where: { $0.name == "Household" })
        }
    }
}

fileprivate extension Date {
    func toDateHeader() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "EEE, d MMMM, yyyy"
        return dateFormatter.string(from: self)
    }
}

#Preview {
    ModelPreview { (transaction: DRETransaction) in
        TransactionsScreen()
    }
}
