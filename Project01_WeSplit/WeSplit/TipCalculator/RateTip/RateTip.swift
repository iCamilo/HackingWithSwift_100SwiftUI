// WeSplit
// Copyright ©️ 2024 Iván Camilo Fuertes. All rights reserved.


import Foundation

public struct RateTip {
    private let excellentTipRange: PartialRangeFrom<UInt> = 21...
    private let goodTipRange: Range<UInt> = 6..<21
            
    public init() {}
    
    public func rate(tip: UInt) -> TipRate {
        switch tip {
        case excellentTipRange:
            return .excellent
        case goodTipRange:
            return .good
        default:
            return .low
        }
    }
}
