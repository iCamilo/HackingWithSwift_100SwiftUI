// WeSplit
// Copyright ©️ 2024 Iván Camilo Fuertes. All rights reserved.


import XCTest
import WeSplitTipCalculator
@testable import WeSplitPresentation

struct WeSplitViewModel {
    private lazy var tipFormatter: NumberFormatter = {
        let resultFormatter = NumberFormatter()
        resultFormatter.minimumFractionDigits = 0
        resultFormatter.maximumFractionDigits = 2
        resultFormatter.decimalSeparator = "."
        resultFormatter.alwaysShowsDecimalSeparator = false
        
        return resultFormatter
    }()
    
    private(set) var tipCalculator: TipCalculator
    
    init(tipCalculator: TipCalculator) {
        self.tipCalculator = tipCalculator
    }
    
    var checkTotal: String = "" {
        didSet {
            calculateTip()
        }
    }
    var tip: UInt = 0 {
        didSet {
            calculateTip()
        }
    }
    var totalPeople: UInt = 0 {
        didSet {
            calculateTip()
        }
    }
    var showTotal: Bool = false
    
    var tipOverTotal: String = ""
    var tipPlusTip: String = ""
    var totalPerPerson: String = ""
    
    private mutating func calculateTip() {
        guard let checkTotal = tipFormatter.double(from: checkTotal),
                let tipTotal = try? tipCalculator.calculate(forCheckTotal: checkTotal,
                                                          withTipPercentage: tip,
                                                          dividedBetween: totalPeople)
        else {
            showTotal = false
            tipOverTotal = ""
            tipPlusTip = ""
            totalPerPerson = ""
            return
        }
         
        showTotal = true
        tipOverTotal = "Tip Over Total: $\(tipFormatter.string(from: tipTotal.tipOverTotal))"
        tipPlusTip = "Tip plus Tip: $\(tipFormatter.string(from: tipTotal.totalPlusTip))"
        totalPerPerson = "Total per Person: $\(tipFormatter.string(from: tipTotal.totalPerPerson))"
    }
}

private extension NumberFormatter {
    func string(from double: Double) -> String {
        self.string(from: double as NSNumber) ?? ""
    }
    
    func double(from string: String) -> Double? {
        self.number(from: string) as? Double
    }
}

final class WeSplitPresentationTests: XCTestCase {
    
    func test_showTotalIfCheckTotalIsANumber() {
        var (sut, _) = makeSUT()
        
        sut.checkTotal = ""
        assert(sut, showTotal: false)
        
        sut.checkTotal = "invalid"
        assert(sut, showTotal: false)
        
        sut.checkTotal = "100"
        assert(sut, showTotal: true)
    }
    
    func test_showTotalIfCalculateTipSucceeds() {
        var (sut, calculator) = makeSUT()
       
        calculator.makeCalculateSucceed(with: TipTotal(tipOverTotal: 10, 
                                                       totalPlusTip: 100.10,
                                                       totalPerPerson: 100.10))
        sut.checkTotal = "100"
        assert(sut, showTotal: true)
        
        calculator.makeCalculateFail()
        sut.checkTotal = "100"
        assert(sut, showTotal: false)
    }
    
    func test_changeAnyInputParameter_calculateTip() {
        var (sut, tipCalculator) = makeSUT()
        
        sut.checkTotal = "100"
        sut.tip = 10
        sut.totalPeople = 2
        
        XCTAssertEqual(
            tipCalculator.messages,
            [.calculate(checkTotal: 100, tip: 0, partySize: 0),
             .calculate(checkTotal: 100, tip: 10, partySize: 0),
             .calculate(checkTotal: 100, tip: 10, partySize: 2)],
            "Should recalculate tip when any of the input params change"
        )
    }
    
    func test_calculateTip_updateTipResults() {
        let tipTotal: WeSplitTipCalculator.TipTotal = .init(tipOverTotal: 1, totalPlusTip: 100.099, totalPerPerson: 50.9278)
        var (sut, calculator) = makeSUT()
        
        calculator.makeCalculateSucceed(with: tipTotal)
        sut.checkTotal = "100"
       
        XCTAssertEqual(sut.tipOverTotal, "Tip Over Total: $1")
        XCTAssertEqual(sut.tipPlusTip, "Tip plus Tip: $100.1")
        XCTAssertEqual(sut.totalPerPerson, "Total per Person: $50.93")
    }
            
    // MARK: - Utils
    func makeSUT() -> (sut: WeSplitViewModel, tipCalculator: TipCalculatorSpy) {
        let tipCalculator = TipCalculatorSpy()
        let sut = WeSplitViewModel(tipCalculator: tipCalculator)
        
        tipCalculator.makeCalculateSucceed(with: TipTotal(tipOverTotal: 0,
                                                          totalPlusTip: 0,
                                                          totalPerPerson: 0))
        
        return (sut, tipCalculator)
    }
    
    private func assert(_ sut: WeSplitViewModel, showTotal: Bool, file: StaticString = #filePath, line: UInt = #line) {
        XCTAssertEqual(sut.showTotal, showTotal, 
                       "Should \(showTotal ? "" : "NOT") show Total",
                       file: file, line: line)
        XCTAssertEqual(sut.tipOverTotal.isEmpty, !showTotal,
                       "Tip over Total should \(showTotal ? "NOT" : "") be empty",
                       file: file, line: line)
        XCTAssertEqual(sut.tipPlusTip.isEmpty, !showTotal,
                       "Tip plus Tip should \(showTotal ? "NOT" : "") be empty",
                       file: file, line: line)
        XCTAssertEqual(sut.totalPerPerson.isEmpty, !showTotal,
                       "Tip total per person should \(showTotal ? "NOT" : "") be empty",
                       file: file, line: line)
    }
    
    final class TipCalculatorSpy: TipCalculator {
        enum Message: Equatable {
            case calculate(checkTotal: Double, tip: UInt, partySize: UInt)
        }
                
        private var tipTotal: TipTotal?
        private(set) var messages = [Message]()
                                                
        func calculate(forCheckTotal checkTotal: Double,
                       withTipPercentage tipPercentage: UInt,
                       dividedBetween partySize: UInt) throws -> WeSplitTipCalculator.TipTotal {
            messages.append(.calculate(checkTotal: checkTotal, tip: tipPercentage, partySize: partySize))
                        
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
    }
}
