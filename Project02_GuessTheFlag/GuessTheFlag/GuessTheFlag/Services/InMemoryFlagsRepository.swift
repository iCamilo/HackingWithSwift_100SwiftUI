////  Created by Ivan Fuertes on 18/05/20.
//  Copyright © 2020 Ivan Fuertes. All rights reserved.

import Foundation

class InMemoryFlagsRepository: FlagsRepository {
    private let flags = ["Estonia", "France", "Germany",
                         "Ireland", "Italy", "Monaco",
                         "Nigeria", "Poland", "Russia",
                         "Spain", "UK", "US"]
    
    func retrieve() -> [String] {
        return flags
    }
}
