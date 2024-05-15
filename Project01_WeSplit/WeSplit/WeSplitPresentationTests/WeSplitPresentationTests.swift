// WeSplit
// Copyright ©️ 2024 Iván Camilo Fuertes. All rights reserved.


import XCTest
import WeSplitTipCalculator
@testable import WeSplitPresentation

struct WeSplitViewModel {
    private lazy var tipFormatter: NumberFormatter = {
        let resultFormatter = NumberFormatter()
        resultFormatter.numberStyle = .currency
        resultFormatter.minimumFractionDigits = 0
        resultFormatter.maximumFractionDigits = 2
        resultFormatter.currencyDecimalSeparator = "."
        resultFormatter.currencySymbol = "$"
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
    var showTotal: Bool {
        Double(checkTotal) != nil
    }
    
    var tipOverTotal: String = ""
    var tipPlusTip: String = ""
    var totalPerPerson: String = ""
    
    private mutating func calculateTip() {
        guard let checkTotal = Double(checkTotal) else {
            return
        }
        guard let tipTotal = try? tipCalculator.calculate(forCheckTotal: checkTotal, withTipPercentage: tip, dividedBetween: totalPeople) else { return }
        
        tipOverTotal = "Tip Over Total: \(tipFormatter.string(from: tipTotal.tipOverTotal))"
        tipPlusTip = "Tip plus Tip: \(tipFormatter.string(from: tipTotal.totalPlusTip))"
        totalPerPerson = "Total per Person: \(tipFormatter.string(from: tipTotal.totalPerPerson))"
    }
}

private extension NumberFormatter {
    func string(from double: Double) -> String {
        self.string(from: double as NSNumber) ?? ""
    }
}

final class WeSplitPresentationTests: XCTestCase {
    
    func test_showTotalOnlyIfCheckTotalIsANumber() {
        var (sut, _) = makeSUT()
        
        sut.checkTotal = ""
        XCTAssertFalse(sut.showTotal)
        
        sut.checkTotal = "invalid"
        XCTAssertFalse(sut.showTotal)
        
        sut.checkTotal = "100"
        XCTAssertTrue(sut.showTotal)
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
        var (sut, _) = makeSUT(tipTotal: tipTotal)
        
        sut.checkTotal = "100"
       
        XCTAssertEqual(sut.tipOverTotal, "Tip Over Total: $ 1")
        XCTAssertEqual(sut.tipPlusTip, "Tip plus Tip: $ 100.1")
        XCTAssertEqual(sut.totalPerPerson, "Total per Person: $ 50.93")
    }
    
    // MARK: - Utils
    func makeSUT(tipTotal: WeSplitTipCalculator.TipTotal = .init(tipOverTotal: 0, totalPlusTip: 0, totalPerPerson: 0)) -> (sut: WeSplitViewModel, tipCalculator: TipCalculatorSpy) {
        let tipCalculator = TipCalculatorSpy(tipTotal: tipTotal)
        let sut = WeSplitViewModel(tipCalculator: tipCalculator)
        
        return (sut, tipCalculator)
    }
    
    final class TipCalculatorSpy: TipCalculator {
        enum Message: Equatable {
            case calculate(checkTotal: Double, tip: UInt, partySize: UInt)
        }
        
        private let tipTotal: WeSplitTipCalculator.TipTotal
        private(set) var messages = [Message]()
        
        init(tipTotal: WeSplitTipCalculator.TipTotal) {
            self.tipTotal = tipTotal
        }
        
        func calculate(forCheckTotal checkTotal: Double,
                       withTipPercentage tipPercentage: UInt,
                       dividedBetween partySize: UInt) throws -> WeSplitTipCalculator.TipTotal {
            messages.append(.calculate(checkTotal: checkTotal, tip: tipPercentage, partySize: partySize))
            
            return tipTotal
        }
    }
}
