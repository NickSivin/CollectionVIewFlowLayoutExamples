//
//  Localized.swift
//  CollectionViewLayoutExamples
//

import Foundation

struct Localized {
    static var exampleList: LocalizedStrings {
        return LocalizedStrings(tableName: "ExampleList")
    }
    
    static var exampleDetails: LocalizedStrings {
        return LocalizedStrings(tableName: "ExampleDetails")
    }
}

struct LocalizedStrings {
    private let tableName: String
    
    init(tableName: String) {
        self.tableName = tableName
    }
    
    func string(forKey key: String) -> String {
        return NSLocalizedString(key, tableName: tableName, comment: "")
    }
}
