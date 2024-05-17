// WeSplit
// Copyright ©️ 2024 Iván Camilo Fuertes. All rights reserved.


import SwiftUI
import WeSplitPresentation

struct WeSplitView: View {
    @State var viewModel: WeSplitViewModel
    
    var body: some View {
        TabView {
            TextField("Check", text: $viewModel.checkTotal)
            
            Picker("Tip",selection: $viewModel.tip.value) {
                ForEach(viewModel.tipOptions, id: \.self.value) {
                    Text($0.description)
                }
            }
            
            Stepper(value: $viewModel.totalPeople.value, in: viewModel.totalPeopleRange) {
                Text(viewModel.totalPeople.description)
                    .font(.callout)
            }
            
            List {
                Text(viewModel.tipTotalResult?.tipOverTotal ?? "")
                Text(viewModel.tipTotalResult?.tipPlusTip ?? "")
                Text(viewModel.tipTotalResult?.totalPerPerson ?? "")
            }
            
        }
        .tabViewStyle(.automatic)
    }
}
