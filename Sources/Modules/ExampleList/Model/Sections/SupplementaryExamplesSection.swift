//
//  SupplementaryViewExamplesSection.swift
//  CollectionViewLayoutExamples
//

import Foundation

struct SupplementaryViewExamplesSection: ExampleListSection {
    var title: String {
        return Localized.exampleList.string(forKey: .supplementarySectionTitle)
    }
    
    var elements: [ExampleListElement] {
        return [
            makeHorizontalStickyHeaderElement()
        ]
    }
    
    private func makeHorizontalStickyHeaderElement() -> ExampleListElement {
        let viewModel = HorizontalStickyHeaderViewModel()
        let strings = Localized.exampleDetails.self
        let configuration = ExampleDetailsConfiguration(title: strings.string(forKey: .horizontalStickyHeaderTitle),
                                                        description: strings.string(forKey: .horizontalStickyHeaderDescription),
                                                        icon: ImageAsset.image(named: .stickyHeader),
                                                        viewModel: viewModel)
        
        let cellViewModel = ExampleListCellViewModel(exampleDetailsConfiguration: configuration)
        return ExampleListElement(exampleDetailsConfiguration: configuration, cellViewModel: cellViewModel)
    }
}
