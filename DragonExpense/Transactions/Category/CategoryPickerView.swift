//
//  CategoryPickerView.swift
//  DragonExpense
//
//  Created by Martijn van de Wetering on 06/10/2023.
//

import SwiftUI
import SwiftData
import DragonExpenseData

struct CategoryPickerView: View {
    @Query var categories: [DRECategory]
    @Binding var selectedCategory: DRECategory?
    
    @Environment(\.dismiss) var dismiss
    @Environment(\.modelContext) var modelContext
    
    @State private var searchText = ""
    @State private var isAddCategoryPresented = false
    
    var body: some View {
        NavigationStack {
            List {
                ForEach(categories) { category in
                    HStack {
                        CategoryIconView(category: category)
                        Text(category.name)
                            .onTapGesture {
                                selectedCategory = Optional(category)
                                dismiss()
                        }
                    }
                }
            }
            .navigationBarTitle("Select category", displayMode: .inline)
            .toolbar {
                ToolbarItem(placement: .bottomBar) {
                    Button(action: {
                        isAddCategoryPresented = true
                    }, label: {
                        HStack {
                            Image(systemName: "plus.circle")
                            Text("Add category")
                        }
                    })
                }
            }
            .sheet(isPresented: $isAddCategoryPresented) {
                AddCategorySheetView()
            }
            
        }
        .searchable(text: $searchText)
    }
}

#Preview {
    ModelPreview { (category: DRECategory) in
        CategoryPickerView(selectedCategory: .constant(category))
    }
}
