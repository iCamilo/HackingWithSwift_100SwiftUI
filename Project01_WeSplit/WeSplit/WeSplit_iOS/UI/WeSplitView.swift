//
//  WeSplitView.swift
//  WeSplit
//
//  Created by Ivan Fuertes on 12/04/20.
//  Copyright © 2020 Ivan Fuertes. All rights reserved.
//

import SwiftUI

struct ViewModel {
    var checkTotal: String = "" {
        didSet {
            calculateTotal()
        }
    }
    var tipPecentage: Int = 0 {
        didSet {
            calculateTotal()
        }
    }
    var numberOfpeople: Int  = 1 {
        didSet {
            calculateTotal()
        }
    }
    var showTotal: Bool = false
    
    var tipOverTotal: String = ""
    var totalPlusTip: String = ""
    var totalPerPerson: String = ""
    
    private(set) var tipOptions: [UInt]
    
    init(tips: [UInt]) {
        self.tipOptions = tips
    }
    
    mutating private func calculateTotal() {
        guard let total = Double(checkTotal) else {
            showTotal = false
            return
        }
        
        let tipOverTotal = total * Double(self.tipOptions[tipPecentage]) / 100
        let totalPlusTip = total + tipOverTotal
        let totalPerPerson = totalPlusTip / Double(numberOfpeople)
        
        showTotal = true
        self.tipOverTotal = "Tip Over Total: $\(tipOverTotal)"
        self.totalPlusTip = "Total Plus Tip: $\(totalPlusTip)"
        self.totalPerPerson = "Total Per Person: $\(totalPerPerson)"
    }
}

struct WeSplitView: View {
    @State var viewModel: ViewModel = ViewModel(tips: [0, 10, 15, 20, 25, 50])
    /*
    private let tipOptions = [0, 10, 15, 50]
    
    @State private var checkTotal = ""
    @State private var numberOfpeople: Int = 2
    @State private var tipPecentage: Int = 0
     **/
    
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
                    Stepper(value: $viewModel.numberOfpeople, in: 1...10) {
                        Text("\(viewModel.numberOfpeople)")
                    }
                }
                
                Section(header: sectionTitle("What about the tip?"))
                {
                    Picker("Tip", selection: $viewModel.tipPecentage) {
                        ForEach(viewModel.tipOptions.indices, id:\.self) {
                            Text("\(viewModel.tipOptions[$0])")
                        }
                    }
                    .pickerStyle(SegmentedPickerStyle())
                }
                
                if viewModel.showTotal {
                    Section(header: HeaderTitle(title: "TOTAL"))
                    {
                        Text(viewModel.tipOverTotal)
                        Text(viewModel.totalPlusTip)
                        Text(viewModel.totalPerPerson)
                    }
                    
                    .foregroundColor(viewModel.tipPecentage == 0 ? .red : viewModel.tipPecentage > 2 ? .green : .blue )
                }
            }
            .navigationBarTitle("We Split")
        }
    }
    
    private func sectionTitle(_ title: String) -> some View {
        HeaderTitle(title: title, font: .headline)
    }
}

private extension WeSplitView {
    
    /**
    func calculateTotal() -> (tipOverTotal: Double, totalPlusTip: Double, totalPerPerson: Double) {
        guard let total = Double(checkTotal) else {
            return (0, 0, 0)
        }
        
        let tipOverTotal = total * Double(self.tipOptions[tipPecentage]) / 100
        let totalPlusTip = total + tipOverTotal
        let totalPerPerson = totalPlusTip / Double(numberOfpeople)
        
        return (tipOverTotal, totalPlusTip, totalPerPerson)
    }
     */
    
}

struct WeSplitView_Previews: PreviewProvider {
    static var previews: some View {
        WeSplitView()
    }
}
