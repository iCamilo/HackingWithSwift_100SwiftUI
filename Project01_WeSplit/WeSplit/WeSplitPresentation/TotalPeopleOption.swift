// WeSplit
// Copyright ©️ 2024 Iván Camilo Fuertes. All rights reserved.


import Foundation

public struct TotalPeopleOption {
    public var value: UInt
    public var description: String {
        "\(value) \(isPlural ? "people" : "person")"
    }
    
    private var isPlural: Bool {
        value > 1
    }
    
    init(value: UInt) {
        self.value = value
    }
}
