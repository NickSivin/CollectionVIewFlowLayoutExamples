//
//  ExampleDetailsViewController.swift
//  CollectionViewLayoutExamples
//

import UIKit

class ExampleDetailsViewController: BaseViewController {
    // MARK: - Properties
    private let collectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
    
    private let viewModel: ExampleDetailsViewModel
    
    // MARK: - Init
    init(viewModel: ExampleDetailsViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
    
    // MARK: - Private
    private func setup() {
        setupCollcetionView()
    }
    
    private func setupCollcetionView() {
        view.addSubview(collectionView)
        collectionView.constraintsSupport.makeConstraints { make in
            make.edgesEqualTo(view)
        }
    }
}
