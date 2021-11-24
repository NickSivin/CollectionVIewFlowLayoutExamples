//
//  HomeSectionsFactory.swift
//  CollectionViewLayoutExamples
//

import UIKit

struct HomeSectionsFactory {
    static func makeSections() -> [HomeSection] {
        let testLayoutInfo = CollectionLayoutInfo(title: "Horizontal Sticky Header",
                                                  description: "Any description",
                                                  icon: UIImage(named: "test_icon"),
                                                  type: .horizontalStickyHeader)
        return [
            HomeSection(title: "Test",
                        elements: [HomeElementDetails(layoutInfo: testLayoutInfo,
                                                      cellViewModel: HomeCellViewModel(layoutInfo: testLayoutInfo))])
        ]
    }
}
