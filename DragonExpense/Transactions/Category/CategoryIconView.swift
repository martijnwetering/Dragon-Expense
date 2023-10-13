//
//  CategoryIconView.swift
//  DragonExpense
//
//  Created by Martijn van de Wetering on 04/10/2023.
//

import SwiftUI
import DragonExpenseData

struct CategoryIconView: View {
    let category: DRECategory
    
    var body: some View {
        Circle()
            .foregroundStyle(Color(uiColor: category.color))
            .frame(width: 30, height: 30)
            .overlay {
                Image(systemName: category.icon)
                    .font(.system(size: 15))
                    .foregroundStyle(.white)
            }
    }
}

#Preview {
    ModelPreview { category in
        CategoryIconView(category: category)
    }
}
