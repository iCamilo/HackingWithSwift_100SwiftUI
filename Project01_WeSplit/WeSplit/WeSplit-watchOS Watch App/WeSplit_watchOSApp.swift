// WeSplit
// Copyright ©️ 2024 Iván Camilo Fuertes. All rights reserved.


import SwiftUI
import WeSplitTipCalculator
import WeSplitPresentation

@main
struct WeSplit_watchOS_Watch_AppApp: App {
    var body: some Scene {
        WindowGroup {
            let tipOptions = [TipOption(value: 0), TipOption(value: 10), TipOption(value: 50)]
            let viewModel = WeSplitViewModel(tipCalculator: CalculateTip(), tipRater: RateTip(), tipOptions: tipOptions, maxPartySize: 5)!
            
            WeSplitView(viewModel: viewModel)
        }
    }
}
