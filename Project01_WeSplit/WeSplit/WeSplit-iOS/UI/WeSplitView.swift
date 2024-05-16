//
//  WeSplitView.swift
//  WeSplit
//
//  Created by Ivan Fuertes on 12/04/20.
//  Copyright © 2020 Ivan Fuertes. All rights reserved.
//

import SwiftUI
import WeSplitPresentation

struct WeSplitView: View {
    @State var viewModel: WeSplitViewModel
    
    var body: some View {
        NavigationView {
            Form {
                Section(header: sectionTitle("How much was the check?"))
                {
                    TextField("Check Total", text: $viewModel.checkTotal)
                        .keyboardType(.decimalPad)
                }
                
                Section(header: sectionTitle("How many people attend?"))
                {
                    Stepper(value: $viewModel.totalPeople.value, in: 1...5) {
                        Text(viewModel.totalPeople.description)
                    }
                }
                
                Section(header: sectionTitle("What about the tip?"))
                {
                    Picker("Tip", selection: $viewModel.tip.value) {
                        ForEach(viewModel.tipOptions, id:\.self.value) {
                            Text($0.description)
                        }
                    }
                    .pickerStyle(SegmentedPickerStyle())
                }
                
                if viewModel.showTotal {
                    Section(header: HeaderTitle(title: "TOTAL"))
                    {
                        Text(viewModel.tipTotalResult?.tipOverTotal ?? "")
                        Text(viewModel.tipTotalResult?.tipPlusTip ?? "")
                        Text(viewModel.tipTotalResult?.totalPerPerson ?? "")
                    }
                    .foregroundColor(showTotalForegroundColor)
                }
            }
            .navigationBarTitle("We Split")
        }
    }
    
    private var showTotalForegroundColor: Color {
        switch viewModel.tipRateResult {
        case .red:
            return Color.red
        case .blue:
            return Color.blue
        case .green:
            return Color.green
        }
    }
    
    private func sectionTitle(_ title: String) -> some View {
        HeaderTitle(title: title, font: .headline)
    }
}

struct WeSplitView_Previews: PreviewProvider {
    static var previews: some View {
        let mockCalculatorAndRater = PreviewsCalculatorAndRater()
        let tipOptions = [TipOption(value: 0), TipOption(value: 50)]
        
        let viewModel = WeSplitViewModel(tipCalculator: mockCalculatorAndRater,
                                         tipRater: mockCalculatorAndRater,
                                         tipOptions: tipOptions,
                                         maxPartySize: 5)
                
        return WeSplitView(viewModel: viewModel!)
    }        
}


