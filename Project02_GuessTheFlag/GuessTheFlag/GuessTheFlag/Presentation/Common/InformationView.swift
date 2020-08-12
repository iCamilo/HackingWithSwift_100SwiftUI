//  Created by Ivan Fuertes on 22/05/20.
//  Copyright © 2020 Ivan Fuertes. All rights reserved.

import SwiftUI

struct InformationView: View {
    var title: String
    var value: String
    
    var body: some View {
        VStack {
            Text(title)
                .foregroundColor(.white)
                .font(.headline)
                .fontWeight(.black)
            Text(value)
                .foregroundColor(.white)
                .font(.body)
                .fontWeight(.medium)
            
        }
    }
}
