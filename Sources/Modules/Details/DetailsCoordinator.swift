//
//  DetailsCoordinator.swift
//  CollectionViewLayoutExamples
//

import UIKit

class DetailsCoordinator: BaseCoordinator {
    var childCoordinators: [BaseCoordinator] = []
    var onDidFinish: (() -> Void)?
    
    private let layoutInfo: CollectionLayoutInfo
    private let navigationController: UINavigationController
    
    init(layoutInfo: CollectionLayoutInfo, navigationController: UINavigationController) {
        self.layoutInfo = layoutInfo
        self.navigationController = navigationController
    }
    
    func start(animated: Bool) {
        showDetailsScreen(animated: animated)
    }
    
    private func showDetailsScreen(animated: Bool) {
        let viewModel = DetailsViewModel(layoutInfo: layoutInfo)
        let viewController = DetailsViewController(viewModel: viewModel)
        viewController.title = layoutInfo.title
        navigationController.pushViewController(viewController, animated: true)
    }
}
