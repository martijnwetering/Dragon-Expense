//
//  AddExpenseView.swift
//  DragonExpense
//
//  Created by Martijn van de Wetering on 01/10/2023.
//

import DragonExpenseData
import Observation
import SwiftData
import SwiftUI

@Observable
class AddTransactionState {
    var title = ""
    var amount = ""
    var expenseDate: Date = .now
    var category: DRECategory?
}

struct AddTransactionView: View {
    let budget: DREBudget
    
    @Environment(\.dismiss) private var dismiss
    @Environment(\.modelContext) private var modelContext
    
    @Query private var categories: [DRECategory]
    
    @State private var selectedTab = 0
    @State private var expenseFormState = AddTransactionState()
    @State private var incomeFormState = AddTransactionState()
    
    var transactionType: DRETransactionType {
        selectedTab == 0 ? .outgoing : .incomming
    }
    
    var isFormValid: Bool {
        switch (transactionType) {
        case .outgoing:
            !expenseFormState.title.isEmptyOrWhiteSpace && (Double(expenseFormState.amount) ?? 0) > 0
        case .incomming: 
            !incomeFormState.title.isEmptyOrWhiteSpace && (Double(incomeFormState.amount) ?? 0) > 0
        }
    }

    func saveExpense() {
        let transaction = transactionType == .outgoing ? expenseFormState : incomeFormState
        
        if let category = transaction.category {
            let transaction = DRETransaction(
                title: transaction.title,
                amount: DREMoney(
                    amount: Decimal(
                        string: transaction.amount
                    )!,
                    currency: "EUR"
                ),
                type: transactionType,
                expenseDate: transaction.expenseDate
            )
            modelContext.insert(transaction)
            transaction.budget = budget
            transaction.category = category
            dismiss()
        }
    }
    
    var body: some View {
        NavigationView {
            VStack {
                Picker(selection: $selectedTab, label: Text("")) {
                    Text("Expense").tag(0)
                    Text("Income").tag(1)
                }
                .pickerStyle(SegmentedPickerStyle())
                .padding(.horizontal)
                
                TabView(selection: $selectedTab) {
                    AddTransactionForm(transactionType: .outgoing, state: $expenseFormState)
                        .tag(0)
                    
                    AddTransactionForm(transactionType: .incomming, state: $incomeFormState)
                        .tag(1)
                }
                .tabViewStyle(.page(indexDisplayMode: .always))
            }
            .background(.gray.opacity(0.1))
            .navigationBarTitle("New expense", displayMode: .inline)
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    Button("Cancel") {
                        dismiss()
                    }
                }
                ToolbarItem {
                    Button("Save", action: saveExpense)
                        .disabled(!isFormValid)
                }
            }
        }
        .onAppear {
            let category = categories.first(where: { $0.id == "No Category" })!
            expenseFormState.category = category
            incomeFormState.category = category
        }
    }
}

struct AddTransactionForm: View {
    let transactionType: DRETransactionType
    
    @Binding var state: AddTransactionState
    
    var body: some View {
        Form {
            TextField("Description", text: $state.title)
            
            AmountTextField(amount: $state.amount)
            
            DatePicker(selection: $state.expenseDate, in: ...Date.now, displayedComponents: .date) {
                Image(systemName: "calendar").font(.title2)
            }
            
            if let category = state.category {
                HStack {
                    NavigationLink {
                        CategoryPickerView(selectedCategory: $state.category)
                    } label: {
                        HStack {
                            CategoryIconView(category: category)
                            Spacer()
                            Text(category.name)
                        }
                    }
                }
            }
        }
    }
}

#Preview {
    ModelPreview { budget in
        Text("preview").sheet(isPresented: .constant(true), content: {
            AddTransactionView(budget: budget)
        })
    }
}
