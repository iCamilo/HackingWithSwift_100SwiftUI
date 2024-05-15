// WeSplit
// Copyright ©️ 2024 Iván Camilo Fuertes. All rights reserved.


import XCTest
import WeSplitTipCalculator
@testable import WeSplitPresentation

struct TipOption {
    var value: UInt
    var description: String { "\(value)%" }
}

struct TotalPeopleOption {
    var value: UInt
    var description: String {
        "\(value) \(isPlural ? "people" : "person")"
    }
    
    private var isPlural: Bool {
        value > 1
    }
}

struct WeSplitViewModel {
    private lazy var tipFormatter: NumberFormatter = {
        let resultFormatter = NumberFormatter()
        resultFormatter.numberStyle = .decimal
        resultFormatter.minimumFractionDigits = 2
        resultFormatter.maximumFractionDigits = 2
        resultFormatter.decimalSeparator = "."
        resultFormatter.alwaysShowsDecimalSeparator = false
        
        return resultFormatter
    }()
    
    private let tipCalculator: TipCalculator
    private(set) var tipOptions: [TipOption]
    
    init(tipCalculator: TipCalculator, tipOptions: [TipOption]) {
        self.tipCalculator = tipCalculator
        self.tipOptions = tipOptions
        self.totalPeople = .init(value: 1)
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
    var totalPeople: TotalPeopleOption {
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
                                                          dividedBetween: totalPeople.value)
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
    
    func test_tipOptions_descriptionsShowTipAsPercentages() {
        let tipOptions: [TipOption] = [
            .init(value: 0),
            .init(value: 5)
        ]
        
        let (sut, _) = makeSUT(tipOptions: tipOptions)
        
        XCTAssertEqual(sut.tipOptions.map { $0.description },
                       ["0%", "5%"])
    }
    
    func test_totalPeopleDescription_showPluralWhenMoreThanOne() {
        var (sut, _) = makeSUT()
        
        sut.totalPeople.value = 1
        XCTAssertEqual(sut.totalPeople.description, "1 person")
        
        sut.totalPeople.value = 2
        XCTAssertEqual(sut.totalPeople.description, "2 people")
    }
    
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
    
    func test_changeAnyInputParameter_shouldReCalculateAndFormatTipResults() {
        let tipTotal: TipTotal = .init(tipOverTotal: 10,
                                       totalPlusTip: 100.10,
                                       totalPerPerson: 33.366666)
        var (sut, calculator) = makeSUT()
        calculator.makeCalculateSucceed(with: tipTotal)
        assert(sut, showTotal: false)
        
        sut.checkTotal = "100"
        sut.tip = 10
        sut.totalPeople.value = 3
        
        XCTAssertEqual(
            calculator.messages,
            [.calculate(checkTotal: 100, tip: 0, partySize: 1),
             .calculate(checkTotal: 100, tip: 10, partySize: 1),
             .calculate(checkTotal: 100, tip: 10, partySize: 3)],
            "Should recalculate tip when any of the input params change"
        )
        
        assert(sut, showTotal: true)
        XCTAssertEqual(sut.tipOverTotal, "Tip Over Total: $10.00")
        XCTAssertEqual(sut.tipPlusTip, "Tip plus Tip: $100.10")
        XCTAssertEqual(sut.totalPerPerson, "Total per Person: $33.37")
    }
    
    
    // MARK: - Utils
    func makeSUT(tipOptions: [TipOption] = []) -> (sut: WeSplitViewModel, tipCalculator: TipCalculatorSpy) {
        let tipCalculator = TipCalculatorSpy()
        let sut = WeSplitViewModel(tipCalculator: tipCalculator, tipOptions: tipOptions)
        
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
