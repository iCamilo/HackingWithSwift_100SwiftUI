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
                Section(header: Text("How much was the check?")
                    .font(.headline)) {
                        TextField("Check Total", text: $checkTotal)
                            .keyboardType(.decimalPad)
                }
                
                Section(header: Text("How many people attend?")
                    .font(.headline)) {
                        Stepper(value: $numberOfpeople, in: 1...10) {
                            Text("\(numberOfpeople)")
                        }
                }
                
                Section(header: Text("What about the tip?")
                    .font(.headline)) {
                        Picker("Tip", selection: $tipPecentage) {
                            ForEach(0..<tipOptions.count) {
                                Text("\(self.tipOptions[$0])")
                            }
                        }
                        .pickerStyle(SegmentedPickerStyle())
                }
                
                Section(header: Text("How much is it !!!")
                    .font(.headline)) {
                        Text("Tip Over Total: $\(calculateTotal().tipOverTotal)")
                        Text("Total Plus Tip: $\(calculateTotal().totalPlusTip)")
                        Text("Total Per Person: $ \(calculateTotal().totalPerPerson)")
                }
                .foregroundColor(tipPecentage == 0 ? .red : tipPecentage > 2 ? .green : .blue )
                    
                
            }.navigationBarTitle("We Split")
        }
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
