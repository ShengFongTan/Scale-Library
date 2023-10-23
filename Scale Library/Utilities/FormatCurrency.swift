//
//  FormatCurrency.swift
//  Scale Library
//
//  Created by Tan Sheng Fong on 21/10/23.
//

import Foundation

func formatCurrency(amount: Decimal) -> String {
    let formatter = NumberFormatter()
    formatter.minimumFractionDigits = 2
    formatter.maximumFractionDigits = 2
    formatter.currencyCode = "SGD"
    formatter.numberStyle = .currency
    let string = formatter.string(for: amount) ?? "?"
    return string
}
