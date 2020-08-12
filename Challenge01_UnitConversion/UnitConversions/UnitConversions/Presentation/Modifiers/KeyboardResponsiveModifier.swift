//  Created by Ivan Fuertes on 15/05/20.
//  Copyright © 2020 Ivan Fuertes. All rights reserved.
//

import SwiftUI
import Combine


struct KeyboardResponsiveModifier: ViewModifier {
    @State private var bottomPadding: CGFloat = 0

    func body(content: Content) -> some View {
        content
            .padding(.bottom, bottomPadding)
            .onReceive(Publishers.keyboardHeight) { self.bottomPadding = $0 }
    }

}

extension View {
    func keyboardResponsive() -> ModifiedContent<Self, KeyboardResponsiveModifier> {
         ModifiedContent(content: self, modifier: KeyboardResponsiveModifier())
    }
}

extension Publishers {
    static var keyboardHeight: AnyPublisher<CGFloat, Never> {
        let willShow = NotificationCenter.default.publisher(for: UIApplication.keyboardWillShowNotification)
            .map { ($0.userInfo![UIResponder.keyboardFrameEndUserInfoKey] as! CGRect).height }
        
        let willHide = NotificationCenter.default.publisher(for: UIApplication.keyboardWillHideNotification)
            .map { _ in CGFloat(0) }
                
        return MergeMany(willShow, willHide)
            .eraseToAnyPublisher()
    }
}
