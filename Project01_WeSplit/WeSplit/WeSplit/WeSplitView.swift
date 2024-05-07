//
//  WeSplitView.swift
//  WeSplit
//
//  Created by Ivan Fuertes on 12/04/20.
//  Copyright © 2020 Ivan Fuertes. All rights reserved.
//

import SwiftUI

struct WeSplitView: View {
    private let tipOptions = [0, 10, 15, 50]
    
    @State private var checkTotal = ""
    @State private var numberOfpeople: Int = 2
    @State private var tipPecentage: Int = 0
    
    var body: some View {
        NavigationView {
            Form {
                Section(header: sectionTitle("How much was the check?"))
                {
                    TextField("Check Total", text: $checkTotal)
                        .keyboardType(.decimalPad)
                }
                
                Section(header: sectionTitle("How many people attend?"))
                {
                    Stepper(value: $numberOfpeople, in: 1...10) {
                        Text("\(numberOfpeople)")
                    }
                }
                
                Section(header: sectionTitle("What about the tip?"))
                {
                    Picker("Tip", selection: $tipPecentage) {
                        ForEach(0..<tipOptions.count) {
                            Text("\(self.tipOptions[$0])")
                        }
                    }
                    .pickerStyle(SegmentedPickerStyle())
                }
                
                Section(header: HeaderTitle(title: "TOTAL"))
                {
                    Text("Tip Over Total: $\(calculateTotal().tipOverTotal)")
                    Text("Total Plus Tip: $\(calculateTotal().totalPlusTip)")
                    Text("Total Per Person: $ \(calculateTotal().totalPerPerson)")
                }
                .foregroundColor(tipPecentage == 0 ? .red : tipPecentage > 2 ? .green : .blue )
                
                
            }
            .navigationBarTitle("We Split")
        }
    }
    
    private func sectionTitle(_ title: String) -> some View {
        HeaderTitle(title: title, font: .headline)
    }
}

private extension WeSplitView {
    
    func calculateTotal() -> (tipOverTotal: Double, totalPlusTip: Double, totalPerPerson: Double) {
        guard let total = Double(checkTotal) else {
            return (0, 0, 0)
        }
        
        let tipOverTotal = total * Double(self.tipOptions[tipPecentage]) / 100
        let totalPlusTip = total + tipOverTotal
        let totalPerPerson = totalPlusTip / Double(numberOfpeople)
        
        return (tipOverTotal, totalPlusTip, totalPerPerson)
    }
    
}

struct WeSplitView_Previews: PreviewProvider {
    static var previews: some View {
        WeSplitView()
    }
}
