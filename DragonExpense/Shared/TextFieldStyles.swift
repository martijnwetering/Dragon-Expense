//
//  TextFieldStyles.swift
//  DragonExpense
//
//  Created by Martijn van de Wetering on 02/10/2023.
//

import SwiftUI

struct FilledTextFieldStyle: TextFieldStyle {
    func _body(configuration: TextField<Self._Label>) -> some View {
        configuration
            .padding(.horizontal, 12)
            .padding(.vertical, 8)
            .frame(height: 35)
            .background(
                RoundedRectangle(cornerRadius: 5).fill(Color.gray.opacity(0.2))
            )
            .textFieldStyle(.plain)
    }
}
