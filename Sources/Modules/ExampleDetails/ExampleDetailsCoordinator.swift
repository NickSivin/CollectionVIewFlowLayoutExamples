//
//  DetailsCoordinator.swift
//  CollectionViewLayoutExamples
//

import UIKit

class ExampleDetailsCoordinator: BaseCoordinator {
    var childCoordinators: [BaseCoordinator] = []
    var onDidFinish: (() -> Void)?
    
    private let layoutInfo: CollectionLayoutInfo
    private let navigationController: UINavigationController
    
    init(layoutInfo: CollectionLayoutInfo, navigationController: UINavigationController) {
        self.layoutInfo = layoutInfo
        self.navigationController = navigationController
    }
    
    func start(animated: Bool) {
        showExampleDetailsScreen(animated: animated)
    }
    
    private func showExampleDetailsScreen(animated: Bool) {
        let viewModel = ExampleDetailsViewModel(layoutInfo: layoutInfo)
        let viewController = ExampleDetailsViewController(viewModel: viewModel)
        viewController.title = layoutInfo.title
        navigationController.pushViewController(viewController, animated: true)
    }
}
