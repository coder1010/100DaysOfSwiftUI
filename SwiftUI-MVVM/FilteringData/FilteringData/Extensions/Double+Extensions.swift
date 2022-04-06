//
//  Double+Extensions.swift
//  FilteringData
//
//  Created by Chhaya on 4/5/22.
//

import Foundation

extension Double {
    func formatAsCurrency() -> String? {
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        return formatter.string(from: NSNumber(value: self))
    }
}
