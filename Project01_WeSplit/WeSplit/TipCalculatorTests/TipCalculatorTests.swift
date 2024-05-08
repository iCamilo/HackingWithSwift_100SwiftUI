// WeSplit
// Copyright ©️ 2024 Iván Camilo Fuertes. All rights reserved.


import XCTest

class CalculateTip {
    typealias TipTotal = (tipOverTotal: Double, totalPlusTip: Double, totalPerPerson: Double)
    
    func calculate(forCheckTotal: Double, withTipPercentage: UInt, dividedBetween: UInt) -> TipTotal {
        return (0, 0, 0)
    }
}

final class TipCalculatorTests: XCTestCase {
    
    func test_checkTotalIsZero_tipTotalIsZero() {
        let checkTotal: Double = 0
        let totalPeople: UInt = 1
        let tipPercentage: UInt = 10
        let sut = CalculateTip()
        
        let tipTotal = sut.calculate(forCheckTotal: checkTotal, withTipPercentage: tipPercentage, dividedBetween: totalPeople)
        
        XCTAssertEqual(tipTotal.tipOverTotal, 0)
        XCTAssertEqual(tipTotal.totalPlusTip, 0)
        XCTAssertEqual(tipTotal.totalPerPerson, 0)
    }
    
}
