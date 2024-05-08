// WeSplit
// Copyright ©️ 2024 Iván Camilo Fuertes. All rights reserved.


import XCTest
import TipCalculator

final class TipCalculatorTests: XCTestCase {
            
    func test_totalPartyIsZero_failWithInvalidPartySizeError() {
        let testInput = TestItem.Input(checkTotal: 100, tipPercentage: 10, partySize: 0)
        let sut = CalculateTip()
        
        assertCalculate(sut, forInput: testInput, throws: .invalidPartySize,
                        "Should throw invalid party size if party size is zero")
    }
            
    func test_calculateTip_addsTipToCheckTotalAndDividesItBetweenPartyMembers() {
        let testItems: [TestItem] = [
            .init(input: .init(checkTotal: 0, tipPercentage: 10, partySize: 5),
                  expectedResult: .init(tipOverTotal: 0, totalPlusTip: 0, totalPerPerson: 0),
                  message: "Tip Total should be zero if the check total is zero"),
            .init(input: .init(checkTotal: 10, tipPercentage: 0, partySize: 1),
                  expectedResult: .init(tipOverTotal: 0, totalPlusTip: 10, totalPerPerson: 10),
                  message: "Tip Total should not add tip to check total if tip percentage is zero"),
            .init(input: .init(checkTotal: 10, tipPercentage: 10, partySize: 1),
                  expectedResult: .init(tipOverTotal: 1, totalPlusTip: 11, totalPerPerson: 11),
                  message: "Tip Total should add tip to check total"),
            .init(input: .init(checkTotal: 10, tipPercentage: 10, partySize: 2),
                  expectedResult: .init(tipOverTotal: 1, totalPlusTip: 11, totalPerPerson: 5.5),
                  message: "Tip Total should divide check total between party members"),
        ]
        
        let sut = CalculateTip()
        for test in testItems {
            assertCalculate(sut, forInput: test.input, isExpectedResult: test.expectedResult, test.message)
        }
    }
    
    // MARK: - Utils
    
    private func assertCalculate(_ sut: CalculateTip, forInput input: TestItem.Input, isExpectedResult expected: TipTotal, _ message: String, file: StaticString = #filePath, line: UInt = #line) {
        let tipTotal = try? sut.calculate(forCheckTotal: input.checkTotal,
                                          withTipPercentage: input.tipPercentage,
                                          dividedBetween: input.partySize)
        
        XCTAssertEqual(tipTotal, expected, message, file: file, line: line)
    }
    
    private func assertCalculate(_ sut: CalculateTip, forInput input: TestItem.Input, throws error: CalculateTip.Error, _ message: String, file: StaticString = #filePath, line: UInt = #line) {
        XCTAssertThrowsError(
            try sut.calculate(forCheckTotal: input.checkTotal,
                              withTipPercentage: input.tipPercentage,
                              dividedBetween: input.partySize)
        ) {
            XCTAssertEqual($0 as? CalculateTip.Error, error, message, file: file, line: line)
        }
    }
    
    private struct TestItem {
        var input: Input
        var expectedResult: TipTotal
        var message: String
        
        struct Input {
            var checkTotal: Double
            var tipPercentage: UInt
            var partySize: UInt
        }
    }
}
