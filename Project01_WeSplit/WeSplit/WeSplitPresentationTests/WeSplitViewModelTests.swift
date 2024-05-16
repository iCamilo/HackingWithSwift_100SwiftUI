// WeSplit
// Copyright ©️ 2024 Iván Camilo Fuertes. All rights reserved.


import XCTest
import WeSplitTipCalculator
import WeSplitPresentation

final class WeSplitViewModelTests: XCTestCase {
    
    func test_initWithPartySizeZero_shouldFail() {
        var (sut, _) = makeSUT(maxPartySize: 0)
        XCTAssertNil(sut, "Init should fail if party size is less than one")
        
        (sut, _) = makeSUT(maxPartySize: 1)
        XCTAssertNotNil(sut, "Init should NOT fail if party size is at least one")
    }
    
    func test_initWithEmptyTipsOptions_shouldFail() {
        var (sut, _) = makeSUT(tipOptions: [])
        XCTAssertNil(sut, "Init should fail if party size is less than one")
        
        (sut, _) = makeSUT(tipOptions: [.init(value: 0)])
        XCTAssertNotNil(sut, "Init should NOT fail if party size is at least one")
    }
    
    func test_tipOptions_descriptionsShowTipAsPercentages() {
        let tipOptions: [TipOption] = [
            .init(value: 0),
            .init(value: 5)
        ]
        
        let (sut, _) = makeSUT(tipOptions: tipOptions)
        
        XCTAssertEqual(sut?.tipOptions.map { $0.description },
                       ["0%", "5%"])
    }
    
    func test_totalPeopleDescription_showPluralWhenMoreThanOne() {
        var (sut, _) = makeSUT()
        
        sut?.totalPeople.value = 1
        XCTAssertEqual(sut?.totalPeople.description, "1 person")
        
        sut?.totalPeople.value = 2
        XCTAssertEqual(sut?.totalPeople.description, "2 people")
    }
    
    func test_showTotalIfCheckTotalIsANumber() {
        var (sut, _) = makeSUT()
        
        sut?.checkTotal = ""
        assert(sut, showTotal: false)
        
        sut?.checkTotal = "invalid"
        assert(sut, showTotal: false)
        
        sut?.checkTotal = "100"
        assert(sut, showTotal: true)
    }
    
    func test_showTotalIfCalculateTipSucceeds() {
        var (sut, calculator) = makeSUT()
        
        calculator.makeCalculateSucceed(with: TipTotal(tipOverTotal: 10,
                                                       totalPlusTip: 100.10,
                                                       totalPerPerson: 100.10))
        sut?.checkTotal = "100"
        assert(sut, showTotal: true)
        
        calculator.makeCalculateFail()
        sut?.checkTotal = "100"
        assert(sut, showTotal: false)
    }
    
    func test_changeAnyInputParameter_shouldReCalculateAndFormatTipResults() {
        let tipOptions = [TipOption(value: 0), TipOption(value: 10)]
        let tipTotal: TipTotal = .init(tipOverTotal: 10,
                                       totalPlusTip: 100.10,
                                       totalPerPerson: 33.366666)
        var (sut, calculator) = makeSUT(tipOptions: tipOptions)
        calculator.makeCalculateSucceed(with: tipTotal)
        assert(sut, showTotal: false)
        
        sut?.checkTotal = "100"
        sut?.tip.value = 10
        sut?.totalPeople.value = 3
        
        XCTAssertEqual(
            calculator.calculateMessages,
            [.calculate(checkTotal: 100, tip: 0, partySize: 1),
             .calculate(checkTotal: 100, tip: 10, partySize: 1),
             .calculate(checkTotal: 100, tip: 10, partySize: 3)],
            "Should recalculate tip when any of the input params change"
        )
        
        assert(sut, showTotal: true)
        XCTAssertEqual(sut?.tipTotalResult?.tipOverTotal, "Tip Over Total: $10.00")
        XCTAssertEqual(sut?.tipTotalResult?.tipPlusTip, "Tip plus Tip: $100.10")
        XCTAssertEqual(sut?.tipTotalResult?.totalPerPerson, "Total per Person: $33.37")
    }
    
    func test_changeTipOption_shouldRateTip() {
        var (sut, rater) = makeSUT()
        
        sut?.tip.value = 0
        sut?.tip.value = 10
        sut?.tip.value = 50
        
        XCTAssertEqual(rater.rateMessages,
                       [.rate(tip: 0),
                        .rate(tip: 10),
                        .rate(tip: 50)])
    }
    
    // MARK: - Utils
    func makeSUT(tipOptions: [TipOption] = [.init(value: 100)], maxPartySize: UInt = 1) -> (sut: WeSplitViewModel?, tipCalculator: TipCalculatorAndRaterSpy) {
        let tipCalculatorAndRater = TipCalculatorAndRaterSpy()
        let sut = WeSplitViewModel(tipCalculator: tipCalculatorAndRater,
                                   tipRater: tipCalculatorAndRater,
                                   tipOptions: tipOptions,
                                   maxPartySize: maxPartySize)
        
        tipCalculatorAndRater.makeCalculateSucceed(with: TipTotal(tipOverTotal: 0,
                                                          totalPlusTip: 0,
                                                          totalPerPerson: 0))
        
        return (sut, tipCalculatorAndRater)
    }
    
    private func assert(_ sut: WeSplitViewModel?, showTotal: Bool, file: StaticString = #filePath, line: UInt = #line) {
        XCTAssertEqual(sut?.showTotal, showTotal,
                       "Should \(showTotal ? "" : "NOT") show Total",
                       file: file, line: line)
        
        if !showTotal {
            XCTAssertNil(sut?.tipTotalResult,
                         "Tip total results should be nil when total is not showing",
                         file: file, line: line)
        } else {
            XCTAssertEqual(sut?.tipTotalResult?.tipOverTotal.isEmpty, false,
                           "Tip over Total should NOT be empty",
                           file: file, line: line)
            XCTAssertEqual(sut?.tipTotalResult?.tipPlusTip.isEmpty, false,
                           "Tip plus Tip should NOT be empty",
                           file: file, line: line)
            XCTAssertEqual(sut?.tipTotalResult?.totalPerPerson.isEmpty, false,
                           "Tip total per person should NOT be empty",
                           file: file, line: line)
        }
    }
    
    final class TipCalculatorAndRaterSpy: TipCalculator, TipRater {
        enum Message: Equatable {
            case rate(tip: UInt)
            case calculate(checkTotal: Double, tip: UInt, partySize: UInt)
        }
        
        // MARK: - TipCalculator
        
        private var tipTotal: TipTotal?
        private(set) var calculateMessages = [Message]()
        
        func calculate(forCheckTotal checkTotal: Double,
                       withTipPercentage tipPercentage: UInt,
                       dividedBetween partySize: UInt) throws -> WeSplitTipCalculator.TipTotal {
            calculateMessages.append(.calculate(checkTotal: checkTotal, tip: tipPercentage, partySize: partySize))
            
            guard let tipTotal = tipTotal  else {
                throw NSError(domain: "Test - Calculator Spy Failed", code: 0)
            }
            
            return tipTotal
        }
        
        func makeCalculateSucceed(with tipTotal: TipTotal) {
            self.tipTotal = tipTotal
        }
        
        func makeCalculateFail() {
            self.tipTotal = nil
        }
        
        // MARK: - TipRater
        
        private(set) var rateMessages = [Message]()
        
        func rate(tip: UInt) -> WeSplitTipCalculator.TipRate {
            rateMessages.append(.rate(tip: tip))
            return .low
        }
    }
}
