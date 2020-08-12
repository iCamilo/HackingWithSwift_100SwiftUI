//  Created by Ivan Fuertes on 17/04/20.
//  Copyright © 2020 Ivan Fuertes. All rights reserved.
//

import Foundation

class UnitConverterViewModel: ObservableObject {
    struct Dependencies {
        var listMeasures: ListMeasures
        var converter: Converter
    }
    
    private static let noSelectedIndex = -1
    private let dependencies: Dependencies
    private var measures: [Measure] = []
    lazy private var numberFormatter: NumberFormatter = {
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = .decimal
        
        return numberFormatter
    }()
    
    @Published var measuresDescriptions = [String]()
    @Published var selectedMeasureIndex = UnitConverterViewModel.noSelectedIndex {
        didSet {
            selectedMeasureIndexDidChange()
        }
    }
    @Published var unitsDescriptions = [String]()
    @Published var selectedFromUnitIndex = UnitConverterViewModel.noSelectedIndex
    @Published var selectedToUnitIndex = UnitConverterViewModel.noSelectedIndex
    @Published var inputValue = ""
    @Published var conversionResult = ""    
            
    init(dependencies: Dependencies) {
        self.dependencies = dependencies
    }
    
    func loadMeasures() {
        self.measures = dependencies.listMeasures.execute()
        self.measuresDescriptions = measures.map { $0.description }
    }
    
    func convert() {
        guard let fromValue = Double(inputValue) else {
           conversionResult = "Numbers only you moron!!"
            return
        }
        
        let fromUnit = measures[selectedMeasureIndex].units[selectedFromUnitIndex]
        let toUnit = measures[selectedMeasureIndex].units[selectedToUnitIndex]
        
        let toValue = dependencies.converter.execute(forValue: fromValue, fromUnit: fromUnit, toUnit: toUnit)
                         
        let fromValueAsString = formatToString(number: fromValue)
        let toValueAsString  = formatToString(number: toValue)
        self.conversionResult = "\(fromValueAsString ) \(fromUnit.description) = \(toValueAsString) \(toUnit.description)"
    }
    
    func showUnitSections() -> Bool {
        return selectedMeasureIndex != UnitConverterViewModel.noSelectedIndex
    }
    
    func showValueSection() -> Bool {
        return selectedFromUnitIndex != UnitConverterViewModel.noSelectedIndex &&
               selectedToUnitIndex != UnitConverterViewModel.noSelectedIndex
    }
    
    func disableConvertButton() -> Bool {
        return showValueSection() && inputValue.isEmpty
    }

}

private extension UnitConverterViewModel {
    
    func loadUnitsForSelectedMeasure() {
        let measure = measures[selectedMeasureIndex]
        unitsDescriptions = measure.units.map { $0.description }
    }
    
    func clearForm() {
        inputValue = ""
        conversionResult = ""
        selectedFromUnitIndex = UnitConverterViewModel.noSelectedIndex
        selectedToUnitIndex = UnitConverterViewModel.noSelectedIndex
    }
        
    func formatToString(number: Double) -> String {
        return numberFormatter.string(for: number) ?? ""
    }
    
    func selectedMeasureIndexDidChange() {
        clearForm()
        loadUnitsForSelectedMeasure()
    }
    
}
