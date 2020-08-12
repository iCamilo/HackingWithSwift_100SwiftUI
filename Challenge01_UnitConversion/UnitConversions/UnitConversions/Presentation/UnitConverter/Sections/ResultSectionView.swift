//  Created by Ivan Fuertes on 15/05/20.
//  Copyright © 2020 Ivan Fuertes. All rights reserved.
//

import SwiftUI

struct ResultSectionView: View {
    private(set) var sectionHeaderTitle: String
    private(set) var conversionResult: String
    private(set) var textColor: Color = .red
    
    var body: some View {
        Section(header: Text(self.sectionHeaderTitle)) {
            Text(self.conversionResult)
                .foregroundColor(self.textColor)
                .multilineTextAlignment(.center)
        }
    }
}

