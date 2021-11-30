//
//  ExampleListCellViewModel.swift
//  CollectionViewLayoutExamples
//

import UIKit

struct ExampleListCellViewModel: CommonCellViewModel {
    var reuseIdentifier: String {
        return ExampleListCell.reuseIdentifier
    }
    
    var title: String? {
        return layoutInfo.title
    }
    
    var description: String? {
        return layoutInfo.description
    }
    
    var icon: UIImage? {
        return layoutInfo.icon
    }
    
    private let layoutInfo: CollectionLayoutInfo
    
    init(layoutInfo: CollectionLayoutInfo) {
        self.layoutInfo = layoutInfo
    }
}
