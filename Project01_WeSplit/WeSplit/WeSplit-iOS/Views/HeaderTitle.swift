// WeSplit
// Copyright ©️ 2024 Iván Camilo Fuertes. All rights reserved.


import SwiftUI

struct HeaderTitle: View {
    var title: String
    var font: Font = .title
    
    var body: some View {
        Text(title)
            .font(font)
    }
}

struct HeaderTitle_Preview: PreviewProvider  {
    static var previews: some View {
        HeaderTitle(title: "A Title")
            .previewLayout(.sizeThatFits)
    }
}

