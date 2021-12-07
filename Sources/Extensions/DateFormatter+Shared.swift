//
//  DateFormatter+Shared.swift
//  CollectionViewLayoutExamples
//

import Foundation

extension DateFormatter {
    static var monthAndYear = makeDateFormatter(with: "MM.yyyy")
    
    private static func makeDateFormatter(with dateFormat: String) -> DateFormatter {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = dateFormat
        return dateFormatter
    }
}
