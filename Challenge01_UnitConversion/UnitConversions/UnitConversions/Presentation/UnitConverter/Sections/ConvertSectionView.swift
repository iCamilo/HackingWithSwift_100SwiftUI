//  Created by Ivan Fuertes on 15/05/20.
//  Copyright © 2020 Ivan Fuertes. All rights reserved.
//

import SwiftUI

struct ConvertSectionView: View {
    private(set) var sectionHeaderTitle: String
    private(set) var inputTextPrompt: String
    private(set) var inputTextInputText: Binding<String>
    private(set) var convertButtonTitle: String
    private(set) var isConvertButtonDisabled: Bool
    private(set) var convertButtonAction: () -> Void
    
    var body: some View {
        Section(header: Text(self.sectionHeaderTitle)) {
            TextField(self.inputTextPrompt,
                      text: self.inputTextInputText)
                .keyboardType(.numbersAndPunctuation)
            
            Button(action: {
                self.convertButtonAction()
            }) {
                Text(self.convertButtonTitle)
            }.disabled(self.isConvertButtonDisabled)
        }
    }
}
