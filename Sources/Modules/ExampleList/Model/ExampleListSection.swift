//
//  ExampleListSection.swift
//  CollectionViewLayoutExamples
//

import Foundation

protocol ExampleListSection {
    var title: String { get }
    var elements: [ExampleListElement] { get }
}
