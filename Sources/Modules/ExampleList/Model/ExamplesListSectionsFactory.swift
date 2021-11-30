//
//  ExampleListSectionsFactory.swift
//  CollectionViewLayoutExamples
//

import UIKit

struct ExampleListSectionsFactory {
    static func makeSections() -> [ExampleListSection] {
        let testLayoutInfo = CollectionLayoutInfo(title: "Horizontal Sticky Header",
                                                  description: "Any description",
                                                  icon: UIImage(named: "test_icon"),
                                                  type: .horizontalStickyHeader)
        return [
            ExampleListSection(title: "Test",
                                elements: [ExampleListElement(layoutInfo: testLayoutInfo,
                                                               cellViewModel: ExampleListCellViewModel(layoutInfo: testLayoutInfo))])
        ]
    }
}
