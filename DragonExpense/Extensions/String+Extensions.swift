//
//  String+Extensions.swift
//  DragonExpense
//
//  Created by Martijn van de Wetering on 01/10/2023.
//

import Foundation

extension String {
    var isEmptyOrWhiteSpace: Bool {
        self.trimmingCharacters(in: .whitespaces).isEmpty
    }
}
