//
//  ExampleDetailsViewController.swift
//  CollectionViewLayoutExamples
//

import UIKit

class ExampleDetailsViewController: BaseViewController {
    // MARK: - Properties
    private let collectionView: UICollectionView
    
    private let viewModel: ExampleDetailsViewModel
    
    // MARK: - Init
    init(viewModel: ExampleDetailsViewModel) {
        self.collectionView = UICollectionView(frame: .zero, collectionViewLayout: viewModel.collectionViewLayout)
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
        view.backgroundColor = .white
        setupCollcetionView()
    }
    
    private func setupCollcetionView() {
        view.addSubview(collectionView)
        collectionView.constraintsSupport.makeConstraints { make in
            make.leadingEqualTo(view)
            make.trailingEqualTo(view)
            if let height = viewModel.collectionViewHeight {
                make.heightEqualTo(height)
                make.centerEqualTo(view, anchor: .yAnchor)
            } else {
                make.topEqualTo(view)
                make.bottomEqualTo(view)
            }
        }
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.showsVerticalScrollIndicator = false
        collectionView.showsHorizontalScrollIndicator = false
        
        viewModel.cellsRegistrationInfo.forEach {
            collectionView.register($0.viewClass, forCellWithReuseIdentifier: $0.viewIdentifier)
        }
        
        viewModel.supplementaryRegistrationInfo.forEach {
            collectionView.register($0.viewClass,
                                    forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader,
                                    withReuseIdentifier: $0.viewIdentifier)
        }
    }
}

// MARK: - UICollectionViewDelegate
extension ExampleDetailsViewController: UICollectionViewDelegate {
    
}

// MARK: - UICollectionViewDataSource
extension ExampleDetailsViewController: UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return viewModel.numberOfSections
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.numberOfRows(in: section)
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cellViewModel = viewModel.cellViewModelForRow(at: indexPath)
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellViewModel.reuseIdentifier, for: indexPath)
        (cell as? ConfigurableView)?.configure(with: cellViewModel)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        viewForSupplementaryElementOfKind kind: String,
                        at indexPath: IndexPath) -> UICollectionReusableView {
        guard let supplementaryViewModel = viewModel.supplementaryViewModelForSection(at: indexPath) else {
            return UICollectionReusableView()
        }
        
        let view = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader,
                                                                   withReuseIdentifier: supplementaryViewModel.reuseIdentifier,
                                                                   for: indexPath)
        (view as? ConfigurableView)?.configure(with: supplementaryViewModel)
        return view
    }
}
