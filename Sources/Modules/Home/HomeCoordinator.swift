//
//  HomeCoordinator.swift
//  CollectionViewLayoutExamples
//

import Foundation
import UIKit

class HomeCoordinator: BaseCoordinator {
    var childCoordinators: [BaseCoordinator] = []
    var onDidFinish: (() -> Void)?
    
    private let navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start(animated: Bool) {
        showHomeScreen(animated: animated)
    }
    
    private func showHomeScreen(animated: Bool) {
        let viewModel = HomeViewModel()
        viewModel.delegate = self
        let viewController = HomeViewController(viewModel: viewModel)
        navigationController.pushViewController(viewController, animated: true)
    }
    
    private func showDetailsScreen(layoutInfo: CollectionLayoutInfo) {
        let coordinator = DetailsCoordinator(layoutInfo: layoutInfo, navigationController: navigationController)
        add(child: coordinator)
        coordinator.start(animated: true)
    }
}


// MARK: - HomeViewModelDelegate
extension HomeCoordinator: HomeViewModelDelegate {
    func homeViewModel(_ viewModel: HomeViewModel, didRequestShowCollectionLayoutExample layoutInfo: CollectionLayoutInfo) {
        showDetailsScreen(layoutInfo: layoutInfo)
    }
}
