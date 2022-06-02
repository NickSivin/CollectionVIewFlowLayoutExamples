//
//  ExampleDetailsSection.swift
//  CollectionViewLayoutExamples
//

import Foundation

struct ExampleDetailsSection: Hashable {
    let supplementaryViewModel: ConfigurableViewModel?
    let items: [ExampleDetailsItem]
    
    private let uuid = UUID()
    
    init(supplementaryViewModel: ConfigurableViewModel? = nil,
         items: [ExampleDetailsItem]) {
        self.supplementaryViewModel = supplementaryViewModel
        self.items = items
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(uuid)
    }
}

extension ExampleDetailsSection {
    static func == (lhs: Self, rhs: Self) -> Bool {
        return lhs.uuid == rhs.uuid
    }
}
