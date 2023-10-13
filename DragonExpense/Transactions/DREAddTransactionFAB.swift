//
//  DREAddTransactionFAB.swift
//  DragonExpense
//
//  Created by Martijn van de Wetering on 10/10/2023.
//

import SwiftUI

struct DREAddTransactionFAB: View {
    let action: () -> Void
    
    var body: some View {
        Button(action: action) {
            Image(systemName: "plus")
                .font(.title.weight(.semibold))
                .padding()
                .background(Color.blue)
                .foregroundStyle(.white)
                .clipShape(Circle())
                .shadow(radius: 4, x: 0, y: 4)
        }    }
}

#Preview {
    DREAddTransactionFAB(action: {})
}
