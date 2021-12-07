//
//  ExampleListSectionsFactory.swift
//  CollectionViewLayoutExamples
//

import UIKit

struct ExampleListSectionsFactory {
    static func makeSections() -> [ExampleListSection] {
        return [
            SupplementaryViewExamplesSection()
        ]
    }
}
