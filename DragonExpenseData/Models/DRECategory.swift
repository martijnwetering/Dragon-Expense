//
//  Categories.swift
//  DragonExpense
//
//  Created by Martijn van de Wetering on 03/10/2023.
//

import Foundation
import SwiftData
import UIKit

@Model public class DRECategory {
    @Attribute(.unique) 
    public var id: String

    @Attribute(.transformable(by: UIColorValueTransformer.self)) 
    public var color: UIColor
    
    public var name: String
    
    @Relationship(deleteRule: .nullify, inverse: \DRETransaction.category)
    public var transactions: [DRETransaction]? = []

    public var icon: String

    public init(id: String, name: String, icon: String, color: UIColor) {
        self.id = id
        self.name = name
        self.icon = icon
        self.color = color
    }
}

