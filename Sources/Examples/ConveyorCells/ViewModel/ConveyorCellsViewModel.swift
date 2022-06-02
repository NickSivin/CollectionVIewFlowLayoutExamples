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
        let items = Array(repeating: 0, count: 50).map { _ in ExampleDetailsItem(cellViewModel: ConveyorCellViewModel()) }
        return [ExampleDetailsSection(items: items)]
    }
}
