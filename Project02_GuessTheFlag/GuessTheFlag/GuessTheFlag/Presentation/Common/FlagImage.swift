//  Created by Ivan Fuertes on 22/05/20.
//  Copyright © 2020 Ivan Fuertes. All rights reserved.

import SwiftUI

struct FlagImage: View {
    var imageName: String
    
    var body: some View {
        Image(imageName)
            .renderingMode(.original)        
            .shadow(color: .gray, radius: 10)
    }
}
