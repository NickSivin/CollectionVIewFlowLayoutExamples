//
//  ExampleDetailsItem.swift
//  CollectionViewLayoutExamples
//

import Foundation

struct ExampleDetailsItem: Hashable {
    let cellViewModel: ConfigurableViewModel
    
    private let uuid = UUID()
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(uuid)
    }
}

extension ExampleDetailsItem {
    static func == (lhs: Self, rhs: Self) -> Bool {
        return lhs.uuid == rhs.uuid
    }
}
