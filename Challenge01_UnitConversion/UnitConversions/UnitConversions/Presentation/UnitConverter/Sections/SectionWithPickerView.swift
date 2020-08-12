//  Created by Ivan Fuertes on 15/05/20.
//  Copyright © 2020 Ivan Fuertes. All rights reserved.
//

import SwiftUI

struct SectionWithPickerView: View {
    var sectionHeaderTitle: String
    var pickerSelection: Binding<Int>
    var pickerData: [String]
    
    
    var body: some View {
        Section(header: Text(self.sectionHeaderTitle)) {
            Picker("", selection: self.pickerSelection) {
                ForEach(0..<self.pickerData.count, id: \.self) {
                    Text(self.pickerData[$0])
                }
            }
            .pickerStyle(SegmentedPickerStyle())
        }
    }
}
