//
//  DragonExpenseDataContainer.swift
//  DragonExpense
//
//  Created by Martijn van de Wetering on 01/10/2023.
//

import SwiftData
import SwiftUI

struct DragonExpenseDataContainerModifier: ViewModifier {
    let container: ModelContainer
    
    init(inMemory: Bool) {
        container = try! ModelContainer(for: DataGeneration.schema, configurations: [ModelConfiguration(isStoredInMemoryOnly: inMemory)])
    }
    
    func body(content: Content) -> some View {
        content
            .generateData()
            .modelContainer(container)
    }
}

struct DragonExpenseDataGenerationModifier: ViewModifier {
    @Environment(\.modelContext) var modelContext: ModelContext
    
    func body(content: Content) -> some View {
        content
            .onAppear {
                DataGeneration.generateAll(modelContext: modelContext)
            }
    }
}

public extension View {
    func dragonExpenseDataContainer(inMemory: Bool = true) -> some View {
        modifier(DragonExpenseDataContainerModifier(inMemory: inMemory))
    }
}

fileprivate extension View {
    func generateData() -> some View {
        modifier(DragonExpenseDataGenerationModifier())
    }
}
