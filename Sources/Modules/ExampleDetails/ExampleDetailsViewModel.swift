//
//  ExampleDetailsViewModel.swift
//  CollectionViewLayoutExamples
//

import UIKit

protocol ExampleDetailsViewModel {
    var collectionViewHeight: CGFloat? { get }
    var collectionViewLayout: UICollectionViewLayout { get }
    var sections: [ExampleDetailsSection] { get }
    var cellsRegistrationInfo: [ViewRegistrationInfo] { get }
    var supplementaryRegistrationInfo: [ViewRegistrationInfo] { get }
    
    var numberOfSections: Int { get }
    
    func numberOfRows(in sectionIndex: Int) -> Int
    func cellViewModelForRow(at indexPath: IndexPath) -> ConfigurableViewModel
    func supplementaryViewModelForSection(at indexPath: IndexPath) -> ConfigurableViewModel?
}

extension ExampleDetailsViewModel {
    var collectionViewHeight: CGFloat? {
        return nil
    }
    
    var numberOfSections: Int {
        return sections.count
    }
    
    var supplementaryRegistrationInfo: [ViewRegistrationInfo] {
        return []
    }
    
    func numberOfRows(in sectionIndex: Int) -> Int {
        let section = sections[sectionIndex]
        return section.elements.count
    }
    
    func cellViewModelForRow(at indexPath: IndexPath) -> ConfigurableViewModel {
        let section = sections[indexPath.section]
        let element = section.elements[indexPath.row]
        return element.cellViewModel
    }
    
    func supplementaryViewModelForSection(at indexPath: IndexPath) -> ConfigurableViewModel? {
        let section = sections[indexPath.section]
        return section.supplementaryViewModel
    }
}
