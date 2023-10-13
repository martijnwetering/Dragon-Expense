//
//  TransactionListView.swift
//  DragonExpense
//
//  Created by Martijn van de Wetering on 09/10/2023.
//

import Collections
import SwiftUI
import DragonExpenseData

struct TransactionListView: View {
    let transactions: [DRETransaction]
    
    var transactionsByDate: OrderedDictionary<Date, [DRETransaction]> {
       transactions.reduce(into: [:]) { result, transaction in
            let calendar = Calendar.current
            let components = calendar.dateComponents([.year, .month, .day], from: transaction.expenseDate)
            
            if let dateKey = calendar.date(from: components) {
                result[dateKey, default: []].append(transaction)
            }
        }
    }
    
    var body: some View {
        List {
            ForEach(transactionsByDate.keys.sorted(by: >), id: \.self) { date in
                Text(date.toDateHeader())
                    .font(.caption)
                
                ForEach(transactionsByDate[date]!, id: \.id) { transaction in
                    ZStack {
                        NavigationLink(value: transaction) {
                            EmptyView()
                        }
                        .opacity(0.0)
                        .buttonStyle(.plain)
                        
                        HStack {
                            if let category = transaction.category {
                                Circle()
                                    .foregroundStyle(Color(uiColor: category.color))
                                    .frame(width: 30, height: 30)
                                    .overlay {
                                        Image(systemName: category.icon)
                                            .font(.system(size: 15))
                                            .foregroundStyle(.white)
                                    }
                                    .padding(.trailing, 8)
                            }
                            
                            VStack(alignment: .leading, spacing: 4) {
                                Text(transaction.title)
                                    .font(.system(size: 14, weight: .light))
                                if let category = transaction.category {
                                    Text(category.name)
                                        .font(.caption)
                                        .fontWeight(.light)
                                        .foregroundStyle(.gray)
                                }
                            }
                            
                            Spacer()
                            
                            HStack(alignment: .firstTextBaseline, spacing: 0) {
                                if transaction.type == .incomming {
                                    Image(systemName: "plus")
                                        .font(.caption)
                                        .imageScale(.small)
                                        .foregroundStyle(.green)
                                }
                                Image(systemName: "eurosign")
                                    .foregroundColor(transaction.type == .outgoing ? .black : .green)
                                    .font(.system(size: 14))
                                    .padding(.trailing, 4)
                                Text(transaction.amount.amount.formatted())
                                    .font(.system(size: 14))
                                    .foregroundColor(transaction.type == .outgoing ? .black : .green)
                           
                            }
                        }
                    }
                    .padding(.vertical, 4)
                }
            }
        }
        .listStyle(.plain)
        .navigationDestination(for: DRETransaction.self) { transaction in
            Text(transaction.title)
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
    ModelPreview { transaction in
        TransactionListView(transactions: [transaction])
    }
}
