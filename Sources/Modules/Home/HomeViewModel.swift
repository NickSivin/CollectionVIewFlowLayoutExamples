//
//  HomeViewModel.swift
//  CollectionViewFlowLayoutExamples
//

import Foundation

protocol HomeViewModelDelegate: AnyObject {
    func homeViewModel(_ viewModel: HomeViewModel, didRequestShowFlowLayoutExample layoutInfo: FlowLayoutInfo)
}

struct HomeViewModel {
    // MARK: - Properties
    weak var delegate: HomeViewModelDelegate?
    
    var numberOfSections: Int {
        return sections.count
    }
    
    private let sections = HomeSectionsFactory.makeSections()
    
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
        delegate?.homeViewModel(self, didRequestShowFlowLayoutExample: element.layoutInfo)
    }
}
