// WeSplit
// Copyright ©️ 2024 Iván Camilo Fuertes. All rights reserved.


import SwiftUI
import WeSplitTipCalculator
import WeSplitPresentation

@main
struct WeSplit_watchOS_Watch_AppApp: App {
    var body: some Scene {
        WindowGroup {
           makeWeSplitView()
        }
    }
    
    private func makeWeSplitView() -> WeSplitView {
        let tipOptions = [TipOption(value: 0), 
                          TipOption(value: 10),
                          TipOption(value: 20),
                          TipOption(value: 25),
                          TipOption(value: 50)]
        guard let viewModel = WeSplitViewModel(
            tipCalculator: CalculateTip(),
            tipRater: RateTip(),
            tipOptions: tipOptions,
            maxPartySize: 10
        )
        else {
            fatalError("Failed to init WeSplitViewModel")
        }
        
        return WeSplitView(viewModel: viewModel)
    }
}
