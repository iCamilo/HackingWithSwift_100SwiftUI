//  Created by Ivan Fuertes on 22/05/20.
//  Copyright © 2020 Ivan Fuertes. All rights reserved.

import SwiftUI

struct FeedbackText: View {
    var message: String
    
    var body: some View {
        Text(message)
        .foregroundColor(.red)
        .font(.caption)
        .fontWeight(.semibold)
    }
}
