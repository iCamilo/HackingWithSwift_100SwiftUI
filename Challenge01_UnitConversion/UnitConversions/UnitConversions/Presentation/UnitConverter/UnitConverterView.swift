//  Created by Ivan Fuertes on 16/04/20.
//  Copyright © 2020 Ivan Fuertes. All rights reserved.
//

import SwiftUI

struct UnitConverterView: View {
        
    @ObservedObject private var viewModel: UnitConverterViewModel
    
    init(viewModel: UnitConverterViewModel) {
        self.viewModel = viewModel
    }
    
    var body: some View {
        NavigationView {
            Form {
                SectionWithPickerView(sectionHeaderTitle: "Measure Options", pickerSelection: $viewModel.selectedMeasureIndex, pickerData: self.viewModel.measuresDescriptions)
                
                if viewModel.showUnitSections() {
                    SectionWithPickerView(sectionHeaderTitle: "From Unit", pickerSelection: $viewModel.selectedFromUnitIndex, pickerData: self.viewModel.unitsDescriptions)
                    
                    SectionWithPickerView(sectionHeaderTitle: "To Unit", pickerSelection: $viewModel.selectedToUnitIndex, pickerData: self.viewModel.unitsDescriptions)
                }
                
                if viewModel.showValueSection() {
                    ConvertSectionView(sectionHeaderTitle: "Value",
                                       inputTextPrompt: "Enter Value",
                                       inputTextInputText: $viewModel.inputValue,
                                       convertButtonTitle: "Convert",
                                       isConvertButtonDisabled: viewModel.disableConvertButton()) {
                                        self.viewModel.convert()
                        }
                    ResultSectionView(sectionHeaderTitle: "Result",
                                      conversionResult: viewModel.conversionResult,
                                      textColor: .green)
                }
            }                
            .keyboardResponsive()
            .navigationBarTitle("Converter")
            .onAppear() {
                self.viewModel.loadMeasures()
            }            
        }
        
    }
}
