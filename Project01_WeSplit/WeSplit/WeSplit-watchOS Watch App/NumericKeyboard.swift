// WeSplit
// Copyright ©️ 2024 Iván Camilo Fuertes. All rights reserved.


import SwiftUI

struct NumericKeyboard: View {
    @Binding var text: String
    
    var body: some View {
        VStack {
            Text(text)
                .frame(maxWidth: .infinity, alignment: .trailing)
            HStack {
                VStack {
                    numberKeys(1...3)
                }
                VStack {
                    numberKeys(4...6)
                }
                VStack {
                    numberKeys(7...9)
                }
                VStack {
                    clearKey
                    decimalKey
                    NumberKey(label: 0, result: $text)
                }
            }
        }
    }
    
    private func numberKeys(_ numbers: ClosedRange<UInt>) -> some View {
        ForEach(numbers, id: \.self) {
            NumberKey(label: UInt($0), result: $text)
        }
    }
    
    private var clearKey: some View {
        Key(label: "<", labelColor: .red) {
            text = "0"
        }
    }
    
    private var decimalKey: some View {
        Key(label: ",", labelColor: .green) {
            if text.contains(",") { return }
            text += ","
        }
    }
}

private struct Key: View {
    var label: String
    var labelColor: Color = .white
    var action: () -> Void
    
    var body: some View {
        Button(label, action: action)
            .foregroundStyle(labelColor)
    }
}

private struct NumberKey: View {
    var label: UInt
    @Binding var result: String
    
    private var labelAsString: String {
        "\(label)"
    }
            
    var body: some View {
        Key(label: labelAsString) {
            if result == "0" { result = "" }
            result += labelAsString
        }
    }
}

// MARK: - Previews

#Preview {
    NumericKeyboardTest(text: "")
}

private struct NumericKeyboardTest: View {
    @State var text: String
    @State private var showNumericKeyboard = false
    
    var body: some View {
        Form {
            Section("Tap to Show Numeric Keyboard") {
                Text(text)
                .frame(maxWidth: .infinity, alignment: .trailing)
                .sheet(isPresented: $showNumericKeyboard) {
                    NumericKeyboard(text: $text)
                }
            }
        }
        .onTapGesture {
            showNumericKeyboard.toggle()
        }
    }
}
