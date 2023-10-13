//
//  UIColorValueTransformer.swift
//  DragonExpense
//
//  Created by Martijn van de Wetering on 07/10/2023.
//

import Foundation
import UIKit

public class UIColorValueTransformer: ValueTransformer {
    public override func transformedValue(_ value: Any?) -> Any? {
        guard let color = value as? UIColor else {return nil}
        return try? NSKeyedArchiver.archivedData(withRootObject: color, requiringSecureCoding: true)
    }
    
    public override func reverseTransformedValue(_ value: Any?) -> Any? {
        guard let data = value as? Data else {return nil}
        return try? NSKeyedUnarchiver.unarchivedObject(ofClass: UIColor.self, from: data)
    }
}
