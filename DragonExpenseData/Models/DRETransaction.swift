//
//  File.swift
//  DragonExpense
//
//  Created by Martijn van de Wetering on@ 22/09/2023.
//

import Foundation
import SwiftData
import SwiftUI

@Model public class DRETransaction {
    @Attribute(.unique)
    public let id: String = UUID().uuidString
    
    public  var category: DRECategory?
    public  var budget: DREBudget?
    
    public var title: String
    public var amount: DREMoney
    public  var type: DRETransactionType
    public var creationDate: Date
    public  var expenseDate: Date
    
    public init(
        title: String,
        amount: DREMoney,
        type: DRETransactionType,
        creationDate: Date = .now,
        expenseDate: Date = .now
    ) {
        self.title = title
        self.amount = amount
        self.type = type
        self.creationDate = creationDate
        self.expenseDate = expenseDate
    }
}


