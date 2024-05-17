// WeSplit
// Copyright ©️ 2024 Iván Camilo Fuertes. All rights reserved.


import Foundation
import WeSplitTipCalculator

class PreviewsCalculatorAndRater: TipRater, TipCalculator {
    func rate(tip: UInt) -> WeSplitTipCalculator.TipRate {
        return .excellent
    }
    
    func calculate(forCheckTotal checkTotal: Double, withTipPercentage tipPercentage: UInt, dividedBetween partySize: UInt) throws -> WeSplitTipCalculator.TipTotal {
        return .init(tipOverTotal: 10,
                     totalPlusTip: 100.199,
                     totalPerPerson: 1.557)
    }
}
