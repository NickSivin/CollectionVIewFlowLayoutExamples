//
//  StickyHeaderSupplementaryViewModel.swift
//  CollectionViewLayoutExamples
//

import UIKit

struct StickyHeaderSupplementaryViewModel: ConfigurableViewModel {
    var reuseIdentifier: String {
        return StickyHeaderSupplementaryView.reuseIdentifier
    }
    
    var month: String? {
        let dateFormatter = DateFormatter()
        let months = dateFormatter.standaloneMonthSymbols
        let monthIndex = Calendar.current.component(.month, from: date)
        return months?[monthIndex - 1]
    }
    
    var font: UIFont {
        return .systemFont(ofSize: 17, weight: .bold)
    }
    
    private let date: Date
    
    init(date: Date) {
        self.date = date
    }
}
