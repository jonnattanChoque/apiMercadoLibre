//
//  Helpers.swift
//  mercadoLibre
//
//  Created by jonnattan Choque on 22/11/21.
//

import Foundation

class Helpers {
    
    /// Function that formats a number to money
    /// - Parameter number: Double number Price
    /// - Returns: String formatted price
    static func convertPrice(number: Double)->String{
        let currencyFormatter = NumberFormatter()
        currencyFormatter.usesGroupingSeparator = true
        currencyFormatter.numberStyle = .currency
        currencyFormatter.locale = Locale.current
        let priceString = currencyFormatter.string(from: NSNumber(value: number))!
        
        return priceString
    }
}
