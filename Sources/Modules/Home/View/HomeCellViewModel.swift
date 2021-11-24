//
//  HomeCellViewModel.swift
//  CollectionViewFlowLayoutExamples
//

import UIKit

struct HomeCellViewModel: CommonCellViewModel {
    var reuseIdentifier: String {
        return HomeCell.reuseIdentifier
    }
    
    var title: String? {
        return nil
    }
    
    var description: String? {
        return nil
    }
    
    var icon: UIImage? {
        return nil
    }
}
