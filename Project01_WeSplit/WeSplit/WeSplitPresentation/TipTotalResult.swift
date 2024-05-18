// WeSplit
// Copyright ©️ 2024 Iván Camilo Fuertes. All rights reserved.


import Foundation
import WeSplitTipCalculator

public struct TipTotalResult {
    private let tipFormatter: NumberFormatter = {
        let resultFormatter = NumberFormatter()
        resultFormatter.numberStyle = .decimal
        resultFormatter.minimumFractionDigits = 2
        resultFormatter.maximumFractionDigits = 2
        resultFormatter.decimalSeparator = "."
        resultFormatter.alwaysShowsDecimalSeparator = false
        
        return resultFormatter
    }()
    
    private let tipTotal: TipTotal
    
    public init(tipTotal: TipTotal) {
        self.tipTotal = tipTotal
    }
    
    public var tipOverTotal: String {
        return "Tip Over Total: $\(tipFormatter.string(from: tipTotal.tipOverTotal))"
    }
    public var tipPlusTip: String {
        return "Tip plus Tip: $\(tipFormatter.string(from: tipTotal.totalPlusTip))"
    }
    public var totalPerPerson: String {
        return "Total per Person: $\(tipFormatter.string(from: tipTotal.totalPerPerson))"
    }
}

// MARK: - NumberFormatter + string(from: Double)
private extension NumberFormatter {
    func string(from double: Double) -> String {
        self.string(from: double as NSNumber) ?? ""
    }
}
