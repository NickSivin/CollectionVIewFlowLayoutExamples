//
//  CellsBehaviourExamplesSection.swift
//  CollectionViewLayoutExamples
//

import Foundation

struct CellsBehaviourExamplesSection: ExampleListSection {
    var title: String {
        return Localized.exampleList.string(forKey: .cellsBehaviourSectionTitle)
    }
    
    var elements: [ExampleListElement] {
        return [
            makeZoomableCellsElement()
        ]
    }
    
    private func makeZoomableCellsElement() -> ExampleListElement {
        let viewModel = ZoomableCellsViewModel()
        let strings = Localized.exampleDetails.self
        let configuration = ExampleDetailsConfiguration(title: strings.string(forKey: .zoomableCellsTitle),
                                                        description: strings.string(forKey: .zoomableCellsDescription),
                                                        icon: ImageAsset.image(named: .stickyHeader),
                                                        viewModel: viewModel)
        
        let cellViewModel = ExampleListCellViewModel(exampleDetailsConfiguration: configuration)
        return ExampleListElement(exampleDetailsConfiguration: configuration, cellViewModel: cellViewModel)
    }
}
