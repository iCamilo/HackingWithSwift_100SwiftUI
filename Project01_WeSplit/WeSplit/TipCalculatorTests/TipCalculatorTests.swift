// WeSplit
// Copyright ©️ 2024 Iván Camilo Fuertes. All rights reserved.


import XCTest

class CalculateTip {
    typealias TipTotal = (tipOverTotal: Double, totalPlusTip: Double, totalPerPerson: Double)
    
    enum Error: Swift.Error {
        case invalidPartySize
    }
    
    func calculate(forCheckTotal: Double, withTipPercentage: UInt, dividedBetween partySize: UInt) throws -> TipTotal {
        guard partySize > 0 else {
            throw Error.invalidPartySize
        }
        
        return (0, 0, 0)
    }
}

final class TipCalculatorTests: XCTestCase {
    
    func test_checkTotalIsZero_tipTotalIsZero() {
        let checkTotal: Double = 0
        let totalPeople: UInt = 1
        let tipPercentage: UInt = 10
        let sut = CalculateTip()
        
        let tipTotal = try? sut.calculate(forCheckTotal: checkTotal, withTipPercentage: tipPercentage, dividedBetween: totalPeople)
        
        XCTAssertEqual(tipTotal?.tipOverTotal, 0)
        XCTAssertEqual(tipTotal?.totalPlusTip, 0)
        XCTAssertEqual(tipTotal?.totalPerPerson, 0)
    }
    
    func test_totalPartyIsZero_failWithInvalidPartySizeError() {
        let checkTotal: Double = 10
        let totalPeople: UInt = 0
        let tipPercentage: UInt = 10
        let sut = CalculateTip()
        
        XCTAssertThrowsError(try sut.calculate(forCheckTotal: checkTotal, withTipPercentage: tipPercentage, dividedBetween: totalPeople)) {
            XCTAssertEqual($0 as? CalculateTip.Error, .invalidPartySize)
        }
    }
    
}
