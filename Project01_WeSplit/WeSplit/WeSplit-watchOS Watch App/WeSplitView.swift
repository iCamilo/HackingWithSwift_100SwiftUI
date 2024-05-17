// WeSplit
// Copyright ©️ 2024 Iván Camilo Fuertes. All rights reserved.


import SwiftUI
import WeSplitPresentation

struct WeSplitView: View {
    @State var viewModel: WeSplitViewModel
    
    var body: some View {
        TabView {
            stepView("1/3 Enter Check Total") {
                TextField("", text: $viewModel.checkTotal)
            }
            
            stepView("2/3 Select Tip") {
                tipPicker
            }
            
            stepView("3/3 Divide between") {
                totalPeopleSelector
            }
                        
            stepView("Total", titleColor: .red) {
                totalView
            }
        }
        .tabViewStyle(.automatic)
    }
    
    private func stepView(_ title: String, titleColor: Color = .blue, content: () -> some View) -> some View {
        VStack(alignment: .leading, spacing: 15) {
            Text(title)
                .font(.caption)
                .foregroundStyle(titleColor)
            
            content()
            
            Spacer()
        }
        .padding(.horizontal)
    }
    
    private var tipPicker: some View {
        Picker("",selection: $viewModel.tip.value) {
            ForEach(viewModel.tipOptions, id: \.self.value) {
                Text($0.description)
            }
        }
    }
    
    private var totalPeopleSelector: some View {
        Stepper(value: $viewModel.totalPeople.value, in: viewModel.totalPeopleRange) {
            Text(viewModel.totalPeople.description)
                .font(.callout)
        }
    }
    
    private var totalView: some View {
        List() {
            if viewModel.showTotal{
                Text(viewModel.tipTotalResult?.tipOverTotal ?? "")
                Text(viewModel.tipTotalResult?.tipPlusTip ?? "")
                Text(viewModel.tipTotalResult?.totalPerPerson ?? "")
            } else {
                Text("Enter Check Total to get results")
            }
        }
    }
}
