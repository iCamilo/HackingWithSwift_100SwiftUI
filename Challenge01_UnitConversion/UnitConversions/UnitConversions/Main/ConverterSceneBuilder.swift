//  Created by Ivan Fuertes on 15/05/20.
//  Copyright © 2020 Ivan Fuertes. All rights reserved.
//

import Foundation

struct ConverterSceneBuilder {
            
    private func makeListeMeasures() -> ListMeasures {
        return ListMeasuresAdapter()
    }
    
    private func makeConverter() -> Converter {
        return ConverterAdapter()
    }
    
    private func makeUnitConverterViewModel() -> UnitConverterViewModel {
        let dependencies: UnitConverterViewModel.Dependencies = .init(listMeasures: makeListeMeasures(), converter: makeConverter())
        
        return UnitConverterViewModel(dependencies: dependencies)
    }
    
    func makeUnitConverterView() -> UnitConverterView {
        return UnitConverterView(viewModel: makeUnitConverterViewModel())
    }    
}
