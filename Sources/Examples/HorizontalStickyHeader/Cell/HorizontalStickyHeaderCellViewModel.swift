//
//  HorizontalStickyHeaderCellViewModel.swift
//  CollectionViewLayoutExamples
//

import Foundation

class HorizontalStickyHeaderCellViewModel: ConfigurableViewModel {
    var reuseIdentifier: String {
        return HorizontalStickyHeaderCell.reuseIdentifier
    }
    
    var day: String {
        return String(Calendar.current.component(.day, from: date))
    }
    
    private let date: Date
    
    init(date: Date) {
        self.date = date
    }
}
