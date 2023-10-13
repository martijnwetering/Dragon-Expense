//
//  Budget.swift
//  DragonExpense
//
//  Created by Martijn van de Wetering on 09/10/2023.
//

import Foundation
import SwiftData

@Model public class DREBudget: Identifiable {
    @Attribute(.unique)
    public var id: String = UUID().uuidString
    
    @Relationship(deleteRule: .cascade, inverse: \DRETransaction.budget) 
    public var transactions: [DRETransaction]? = []
    
    public var name: String
    public var creationDate: Date
    
    public init(name: String, creationDate: Date = .now) {
        self.name = name
        self.creationDate = creationDate
    }
}
