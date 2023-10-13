//
//  Styles.swift
//  DragonExpense
//
//  Created by Martijn van de Wetering on 29/09/2023.
//

import SwiftUI

struct Colors {
    static let background = Color("BG")
}

extension ShapeStyle where Self == Color {
    static var background: Color { Colors.background }
}
