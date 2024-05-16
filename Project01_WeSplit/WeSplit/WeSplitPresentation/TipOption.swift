// WeSplit
// Copyright ©️ 2024 Iván Camilo Fuertes. All rights reserved.


import Foundation

public struct TipOption {
    public var value: UInt
    public var description: String { "\(value)%" }
    
    public init(value: UInt) {
        self.value = value
    }
}
