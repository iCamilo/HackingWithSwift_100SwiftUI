//  Created by Ivan Fuertes on 16/04/20.
//  Copyright © 2020 Ivan Fuertes. All rights reserved.
//

import Foundation

// List all supported measures

protocol ListMeasures {
    func execute() -> [Measure]
}

struct ListMeasuresAdapter: ListMeasures {
    private var measures: [Measure] = [Distance(), Mass()]
    
    func execute() -> [Measure] {
        return measures
    }

}

