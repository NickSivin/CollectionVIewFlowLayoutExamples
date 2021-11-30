//
//  ExampleListViewModel.swift
//  CollectionViewLayoutExamples
//

import Foundation

protocol ExampleListViewModelDelegate: AnyObject {
    func exampleListViewModel(_ viewModel: ExampleListViewModel, didRequestShowCollectionLayoutExample layoutInfo: CollectionLayoutInfo)
}

class ExampleListViewModel {
    // MARK: - Properties
    weak var delegate: ExampleListViewModelDelegate?
    
    var numberOfSections: Int {
        return sections.count
    }
    
    private let sections = ExampleListSectionsFactory.makeSections()
    
    func numberOfRows(in section: Int) -> Int {
        return sections[section].elements.count
    }
    
    func cellViewModel(at indexPath: IndexPath) -> CommonCellViewModel {
        let section = sections[indexPath.section]
        let element = section.elements[indexPath.row]
        return element.cellViewModel
    }
    
    func selectElement(at indexPath: IndexPath) {
        let section = sections[indexPath.section]
        let element = section.elements[indexPath.row]
        delegate?.exampleListViewModel(self, didRequestShowCollectionLayoutExample: element.layoutInfo)
    }
}
