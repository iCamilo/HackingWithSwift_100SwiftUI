// WeSplit
// Copyright ©️ 2024 Iván Camilo Fuertes. All rights reserved.


import Foundation

public struct TipTotal: Equatable {
    public var tipOverTotal: Double
    public var totalPlusTip: Double
    public var totalPerPerson: Double
    
    public init(tipOverTotal: Double, totalPlusTip: Double, totalPerPerson: Double) {
        self.tipOverTotal = tipOverTotal
        self.totalPlusTip = totalPlusTip
        self.totalPerPerson = totalPerPerson
    }
}
