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
            makeConveyorCellsElement()
        ]
    }
    
    private func makeConveyorCellsElement() -> ExampleListElement {
        let viewModel = ConveyorCellsViewModel()
        let strings = Localized.exampleDetails.self
        let configuration = ExampleDetailsConfiguration(title: strings.string(forKey: .conveyorCellsTitle),
                                                        description: strings.string(forKey: .conveyorCellsDescription),
                                                        icon: ImageAsset.image(named: .stickyHeader),
                                                        viewModel: viewModel)
        
        let cellViewModel = ExampleListCellViewModel(exampleDetailsConfiguration: configuration)
        return ExampleListElement(exampleDetailsConfiguration: configuration, cellViewModel: cellViewModel)
    }
}
