// WeSplit
// Copyright ©️ 2024 Iván Camilo Fuertes. All rights reserved.


import Foundation

public struct RateTip {
    public init() {}
    
    public func rate(tip: UInt) -> TipRate {
        switch tip {
        case 0...5:
            return .low
        case 6...20:
            return .good
        default:
            return .excellent
        }
    }
}
