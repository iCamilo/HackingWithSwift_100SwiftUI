// WeSplit
// Copyright ©️ 2024 Iván Camilo Fuertes. All rights reserved.


import Foundation
import WeSplitTipCalculator

public struct WeSplitViewModel {
    private let tipRater: TipRater
    private let tipCalculator: TipCalculator
    public private(set) var tipOptions: [TipOption]
    public private(set) var totalPeopleRange: ClosedRange<Int>
    
    ///  ViewModel used to capture the required data to calculate a check tip. Tip calculation results are stored in `tipTotalResult`
    ///
    /// - Precondition: `maxPartySize` should be greater than one
    /// - Precondition:  `tipOptions` should not be empty
    public init?(tipCalculator: TipCalculator, tipRater: TipRater, tipOptions: [TipOption], maxPartySize: UInt) {
        guard maxPartySize >= 1,
            !tipOptions.isEmpty
        else {
            return nil
        }
        
        self.tipRater = tipRater
        self.tipCalculator = tipCalculator
        self.tipOptions = tipOptions
        self.totalPeople = .init(value: 1)
        self.tip = tipOptions.first ?? .init(value: 0)
        self.totalPeopleRange = 1...Int(maxPartySize)
    }
    
    public var checkTotal: String = "" {
        didSet {
            calculateTip()
        }
    }
    public var tip: TipOption {
        didSet {
            calculateTip()
            rateTip()
        }
    }
    public var totalPeople: TotalPeopleOption {
        didSet {
            calculateTip()
        }
    }
    
    public private(set) var tipTotalResult: TipTotalResult?
    public var showTotal: Bool {
        tipTotalResult != nil
    }
    
    private mutating func calculateTip() {
        guard let checkTotal = Double(checkTotal),
              let tipTotal = try? tipCalculator.calculate(forCheckTotal: checkTotal,
                                                          withTipPercentage: tip.value,
                                                          dividedBetween: totalPeople.value)
        else {
            tipTotalResult = nil
            return
        }
                
        tipTotalResult = .init(tipTotal: tipTotal)
    }
    
    private func rateTip() {
        _ = tipRater.rate(tip: tip.value)
    }
}
