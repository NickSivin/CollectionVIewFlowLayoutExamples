//
//  ExampleDetailsSection.swift
//  CollectionViewLayoutExamples
//

import Foundation

struct ExampleDetailsSection {
    let supplementaryViewModel: ConfigurableViewModel?
    let elements: [ExampleDetailsElement]
    
    init(supplementaryViewModel: ConfigurableViewModel? = nil,
         elements: [ExampleDetailsElement]) {
        self.supplementaryViewModel = supplementaryViewModel
        self.elements = elements
    }
}
