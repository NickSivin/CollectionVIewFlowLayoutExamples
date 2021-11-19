//
//  HomeCoordinator.swift
//  CollectionViewFlowLayoutExamples
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
        let viewController = HomeViewController(viewModel: viewModel)
        navigationController.pushViewController(viewController, animated: true)
    }
}
