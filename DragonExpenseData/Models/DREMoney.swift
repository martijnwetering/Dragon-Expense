//
//  Money.swift
//  DragonExpense
//
//  Created by Martijn van de Wetering on 01/10/2023.
//

import Foundation
import SwiftData

public enum DRECurrency: String {
    case EUR = "EUR"
    case USD = "USD"
    case GB = "GB"
    
    public init(rawValue: String) {
        switch rawValue {
        case "EUR": self = .EUR
        case "USD": self = .USD
        case "GB": self = .GB
        default:
            self = .EUR
        }
    }
}

@Model public class DREMoney {
    public var currency: Locale.Currency
    public var amount: Decimal
    
    public init(amount: Decimal, currency: Locale.Currency) {
        self.currency = currency
        self.amount = amount
    }
}
