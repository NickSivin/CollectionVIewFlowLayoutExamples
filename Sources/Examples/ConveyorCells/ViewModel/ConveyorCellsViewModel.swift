//
//  ConveyorCellsViewModel.swift
//  CollectionViewLayoutExamples
//

import UIKit

class ConveyorCellsViewModel: ExampleDetailsViewModel {
    var cellsRegistrationInfo: [ViewRegistrationInfo] {
        return [
            ViewRegistrationInfo(viewClass: ConveyorCell.self,
                                 viewIdentifier: ConveyorCell.reuseIdentifier)
        ]
    }
    
    private(set) lazy var collectionViewLayout = makeCollectionViewLayout()
    private(set) lazy var sections = makeSections()
    
    private func makeCollectionViewLayout() -> UICollectionViewLayout {
        let layout = ConveyorCellsCollectionLayout()
        return layout
    }
    
    private func makeSections() -> [ExampleDetailsSection] {
        let elements = Array(repeating: ExampleDetailsElement(cellViewModel: ConveyorCellViewModel()), count: 50)
        return [ExampleDetailsSection(elements: elements)]
    }
}
