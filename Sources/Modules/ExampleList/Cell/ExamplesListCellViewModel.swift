//
//  ExampleListCellViewModel.swift
//  CollectionViewLayoutExamples
//

import UIKit

struct ExampleListCellViewModel: ConfigurableViewModel {
    var reuseIdentifier: String {
        return ExampleListCell.reuseIdentifier
    }
    
    var title: String? {
        return exampleDetailsConfiguration.title
    }
    
    var description: String? {
        return exampleDetailsConfiguration.description
    }
    
    var icon: UIImage? {
        return exampleDetailsConfiguration.icon
    }
    
    private let exampleDetailsConfiguration: ExampleDetailsConfiguration
    
    init(exampleDetailsConfiguration: ExampleDetailsConfiguration) {
        self.exampleDetailsConfiguration = exampleDetailsConfiguration
    }
}
