// WeSplit
// Copyright ©️ 2024 Iván Camilo Fuertes. All rights reserved.


import SwiftUI
import WeSplitPresentation
import WeSplitTipCalculator

@main
struct WeSplit_iOSApp: App {
    var body: some Scene {
        WindowGroup {
           makeWeSplitView()
        }
    }
    
    private func makeWeSplitView() -> WeSplitView {
        let tipCalculator = CalculateTip()
        let tipRater = RateTip()
        let tipOptions = [TipOption(value: 0),
                          TipOption(value: 10),
                          TipOption(value: 15),
                          TipOption(value: 20),
                          TipOption(value: 25),
                          TipOption(value: 50)]
        
        let viewModel = WeSplitViewModel(tipCalculator: tipCalculator,
                                         tipRater: tipRater,
                                         tipOptions: tipOptions,
                                         maxPartySize: 10)!
        
        return WeSplitView(viewModel: viewModel)
    }
}
