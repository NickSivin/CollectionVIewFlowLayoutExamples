//
//  HomeCellViewModel.swift
//  CollectionViewLayoutExamples
//

import UIKit

struct HomeCellViewModel: CommonCellViewModel {
    var reuseIdentifier: String {
        return HomeCell.reuseIdentifier
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
