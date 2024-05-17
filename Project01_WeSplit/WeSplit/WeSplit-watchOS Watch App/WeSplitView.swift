// WeSplit
// Copyright ©️ 2024 Iván Camilo Fuertes. All rights reserved.


import SwiftUI
import WeSplitPresentation

struct WeSplitView: View {
    @State var viewModel: WeSplitViewModel
    @State private var showNumericKeyboard = false
    
    var body: some View {
        TabView {
            stepView("1/3 Tap to enter Check Total") {
                checkInput
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
    
    private var checkInput: some View {
        Text(viewModel.checkTotal)
            .frame(maxWidth: .infinity, alignment: .trailing)
            .background(Color.black)
            .padding()
            .sheet(isPresented: $showNumericKeyboard) {
                NumericKeyboard(text: $viewModel.checkTotal)
            }
            .onTapGesture {
                showNumericKeyboard.toggle()
            }
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

#Preview {
    let tipCalculatorAndRater = PreviewsCalculatorAndRater()
    let viewModel = WeSplitViewModel(tipCalculator: tipCalculatorAndRater, tipRater: tipCalculatorAndRater, tipOptions: [.init(value: 10)], maxPartySize: 2)!
    
    return WeSplitView(viewModel: viewModel)
}
