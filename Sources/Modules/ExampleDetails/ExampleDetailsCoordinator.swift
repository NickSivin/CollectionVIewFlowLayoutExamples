//
//  DetailsCoordinator.swift
//  CollectionViewLayoutExamples
//

import UIKit

class ExampleDetailsCoordinator: BaseCoordinator {
    var childCoordinators: [BaseCoordinator] = []
    var onDidFinish: (() -> Void)?
    
    private let exampleDetailsConfiguration: ExampleDetailsConfiguration
    private let navigationController: UINavigationController
    
    init(exampleDetailsConfiguration: ExampleDetailsConfiguration, navigationController: UINavigationController) {
        self.exampleDetailsConfiguration = exampleDetailsConfiguration
        self.navigationController = navigationController
    }
    
    func start(animated: Bool) {
        showExampleDetailsScreen(animated: animated)
    }
    
    private func showExampleDetailsScreen(animated: Bool) {
        let viewController = ExampleDetailsViewController(viewModel: exampleDetailsConfiguration.viewModel)
        viewController.title = exampleDetailsConfiguration.title
        navigationController.pushViewController(viewController, animated: true)
    }
}
