//
//  ModelPreview.swift
//  DragonExpense
//
//  Created by Martijn van de Wetering on 01/10/2023.
//

import SwiftUI
import SwiftData

struct ModelPreview<Model: PersistentModel, Content: View>: View {
    var content: (Model) -> Content
    
    init(content: @escaping (Model) -> Content) {
        self.content = content
    }
    
    var body: some View {
        ZStack {
            PreviewContent(content: content)
        }
        .dragonExpenseDataContainer(inMemory: true)
    }
    
    struct PreviewContent: View {
        var content: (Model) -> Content
        @Query private var models: [Model]
        
        var body: some View {
            if let model = models.first {
                content(model)
            } else {
                ContentUnavailableView {
                    Text("No content could be loaded")
                }
            }
        }
    }
}

