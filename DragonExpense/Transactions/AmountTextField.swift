//
//  AmountTextField.swift
//  DragonExpense
//
//  Created by Martijn van de Wetering on 03/10/2023.
//

import Combine
import SwiftUI

struct AmountTextField: View {
    let euroSign = "\u{20AC}"
    
    @Binding var amount: String
    
    func formatAmountTextField(_ input: String) {
            // Split the input into integer and decimal parts
            let filteredInput = input.filter { char in
                char.isNumber || char == "."
            }
            
            guard !filteredInput.isEmpty else {
                amount = ""
                return
            }
            
            let parts = filteredInput.components(separatedBy: ".")
            if parts.count > 2 {
                // If there are more than two parts, remove the extra decimal points
                let integerPart = parts[0]
                let decimalPart = parts[1]
                amount = "\(integerPart).\(decimalPart.prefix(2))"
            } else if parts.count == 2 && parts[1].count > 2 {
                // If there are two parts with more than two decimal places, truncate to two decimal places
                let integerPart = parts[0]
                let decimalPart = String(parts[1].prefix(2))
                amount = "\(integerPart).\(decimalPart)"
            } else {
                // Otherwise, just update the input
                amount = "\(filteredInput)"
            }
        }
    
    var body: some View {
        ZStack(alignment: .leading) {
            HStack {
                Text(euroSign)
                    .font(.system(size: 22))
                    .foregroundColor(amount.isEmpty ? .gray.opacity(0.6) : .black)
                
                TextField("0.00", text: $amount)
                    .textFieldStyle(.plain)
                    .keyboardType(.decimalPad)
                    .onReceive(Just(amount), perform: formatAmountTextField)
            }
        }

    }
}

#Preview {
    AmountTextField(amount: .constant(""))
}
