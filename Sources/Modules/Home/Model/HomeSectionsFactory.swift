//
//  HomeSectionsFactory.swift
//  CollectionViewFlowLayoutExamples
//

import Foundation

struct HomeSectionsFactory {
    static func makeSections() -> [HomeSection] {
        return []
    }
}

private protocol HomeElementsFactory {
    func makeElements() -> [HomeElementDetails]
}
