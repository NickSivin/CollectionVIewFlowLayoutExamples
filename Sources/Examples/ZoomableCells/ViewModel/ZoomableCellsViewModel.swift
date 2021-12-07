//
//  ZoomableCellsViewModel.swift
//  CollectionViewLayoutExamples
//

import UIKit

class ZoomableCellsViewModel: ExampleDetailsViewModel {
    var cellsRegistrationInfo: [ViewRegistrationInfo] {
        return [
            ViewRegistrationInfo(viewClass: ZoomableCell.self,
                                 viewIdentifier: ZoomableCell.reuseIdentifier)
        ]
    }
    
    private(set) lazy var collectionViewLayout = makeCollectionViewLayout()
    private(set) lazy var sections = makeSections()
    
    private func makeCollectionViewLayout() -> UICollectionViewLayout {
        let layout = ZoomableCellsCollectionLayout()
        return layout
    }
    
    private func makeSections() -> [ExampleDetailsSection] {
        return []
    }
}
