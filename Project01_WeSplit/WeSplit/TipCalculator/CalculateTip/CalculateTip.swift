// WeSplit
// Copyright ©️ 2024 Iván Camilo Fuertes. All rights reserved.


import Foundation

public final class CalculateTip {    
    public enum Error: Swift.Error {
        case invalidPartySize
    }
    
    public init() { }
    
    public func calculate(forCheckTotal checkTotal: Double, withTipPercentage tipPercentage: UInt, dividedBetween partySize: UInt) throws -> TipTotal {
        guard partySize > 0 else {
            throw Error.invalidPartySize
        }
        
        let tipOverTotal: Double = checkTotal * Double(tipPercentage) / 100
        let totalPlusTip: Double = checkTotal + tipOverTotal
        let totalPerPerson: Double = totalPlusTip / Double(partySize)
        
        return .init(tipOverTotal: tipOverTotal,
                     totalPlusTip: totalPlusTip,
                     totalPerPerson: totalPerPerson)
    }
}
