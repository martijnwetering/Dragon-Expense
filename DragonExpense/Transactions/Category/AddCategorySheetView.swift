//
//  AddCategorySheetView.swift
//  DragonExpense
//
//  Created by Martijn van de Wetering on 06/10/2023.
//

import DragonExpenseData
import SwiftUI

struct AddCategorySheetView: View {
    @Environment(\.modelContext) var modelContext
    @Environment(\.dismiss) var dismiss
    
    @State private var name = ""
    @State private var selectedColor: Color = .blue
    @State private var selectedSymbol = SFSymbols.list
    
    private let colors: [Color] = [.red, .orange, .yellow, .green, .blue, .mint, .purple, .brown, .gray, .pink]
    
    private let symbols: [String] = [SFSymbols.list, SFSymbols.bookmark, SFSymbols.car, SFSymbols.cloud, SFSymbols.creditCard, SFSymbols.dollarSign, SFSymbols.figureRun, SFSymbols.flag, SFSymbols.forkKnife, SFSymbols.headphones, SFSymbols.aiplane, SFSymbols.moon, SFSymbols.paperPlane, SFSymbols.power, SFSymbols.snowFlake, SFSymbols.squareAndPencil, SFSymbols.tennisball, SFSymbols.trophy]
    
    private let symbolGridRows: [GridItem] = [
        GridItem(.flexible()),
        GridItem(.flexible()),
        GridItem(.flexible()),
    ]
    
    private var isFormValid: Bool {
        !name.isEmpty
    }
    
    func save() {
        let category = DRECategory(id: self.name, name: self.name, icon: selectedSymbol, color: UIColor(selectedColor))
        modelContext.insert(category)
        dismiss()
    }
    
    var body: some View {
        NavigationStack {
            Form {
                Section {
                    HStack {
                        Image(systemName: selectedSymbol)
                            .font(.largeTitle)
                            .symbolVariant(.circle.fill)
                            .foregroundStyle(.white, selectedColor)

                        TextField("Category", text: $name)
                    }
                }
                
                Section {
                    LazyHGrid(rows: [GridItem(.flexible()), GridItem(.flexible())], spacing: 16) {
                        ForEach(colors, id: \.self) { color in
                            ColorCircle(color: color, isSelected: color == selectedColor)
                                .onTapGesture {
                                    withAnimation {
                                        self.selectedColor = color
                                    }
                                }
                        }
                    }
                    .padding(8)
                }
                
                Section {
                    LazyHGrid(rows: symbolGridRows, alignment: .center, spacing: 16) {
                        ForEach(symbols, id: \.self) { symbol in
                            SymbolCircle(symbol: symbol, isSelected: symbol == selectedSymbol, foreground:  Color.black.opacity(0.7))
                                .onTapGesture {
                                    withAnimation {
                                        self.selectedSymbol = symbol
                                    }
                                }
                        }
                    }
                    .padding(8)
                }
            }
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button(action: { dismiss() }) {
                        Text("Cancel")
                    }
                }
                
                ToolbarItem(placement: .topBarTrailing) {
                    Button(action: save) {
                        Text("Done")
                    }
                    .disabled(!isFormValid)
                }
            }
        }
    }
}

struct ColorCircle: View {
    let color: Color
    let isSelected: Bool
    
    var body: some View {
        Circle()
            .fill(color)
            .frame(width: 40, height: 40)
            .overlay(
                Circle()
                    .stroke(Color.gray, lineWidth: isSelected ? 3 : 0)
                    .frame(width: 50, height: 50)
            )
            .padding(4)
    }
}

struct SymbolCircle: View {
    let symbol: String
    let isSelected: Bool
    
    var background: Color = .gray.opacity(0.1)
    var foreground: Color = .white
    
    var body: some View {
        Image(systemName: symbol)
            .font(.system(size: 14))
            .symbolVariant(.fill)
            .padding(10)
            .background(background)
            .clipShape(Circle())
            .foregroundStyle(foreground)
            .overlay(
                Circle()
                    .stroke(Color.gray, lineWidth: isSelected ? 2 : 0)
                    .frame(width: 40, height: 40)
            )
        
    }
}

#Preview {
    AddCategorySheetView()
}
