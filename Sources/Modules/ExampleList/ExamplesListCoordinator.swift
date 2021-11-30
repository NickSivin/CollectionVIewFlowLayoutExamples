//
//  ExampleListCoordinator.swift
//  CollectionViewLayoutExamples
//

import Foundation
import UIKit

class ExampleListCoordinator: BaseCoordinator {
    var childCoordinators: [BaseCoordinator] = []
    var onDidFinish: (() -> Void)?
    
    private let navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start(animated: Bool) {
        showExampleListScreen(animated: animated)
    }
    
    private func showExampleListScreen(animated: Bool) {
        let viewModel = ExampleListViewModel()
        viewModel.delegate = self
        let viewController = ExampleListViewController(viewModel: viewModel)
        navigationController.pushViewController(viewController, animated: true)
    }
    
    private func showDetailsScreen(layoutInfo: CollectionLayoutInfo) {
        let coordinator = ExampleDetailsCoordinator(layoutInfo: layoutInfo, navigationController: navigationController)
        add(child: coordinator)
        coordinator.start(animated: true)
    }
}


// MARK: - ExampleListViewModelDelegate
extension ExampleListCoordinator: ExampleListViewModelDelegate {
    func exampleListViewModel(_ viewModel: ExampleListViewModel,
                               didRequestShowCollectionLayoutExample layoutInfo: CollectionLayoutInfo) {
        showDetailsScreen(layoutInfo: layoutInfo)
    }
}
