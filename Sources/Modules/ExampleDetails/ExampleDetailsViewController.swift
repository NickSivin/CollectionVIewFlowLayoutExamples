//
//  ExampleDetailsViewController.swift
//  CollectionViewLayoutExamples
//

import UIKit

class ExampleDetailsViewController: BaseViewController {
    // MARK: - Types
    typealias SectionIdentifier = ExampleDetailsSection
    typealias ItemIdentifier = ExampleDetailsItem
    typealias DataSource = UICollectionViewDiffableDataSource<SectionIdentifier, ItemIdentifier>
    typealias Snapshot = NSDiffableDataSourceSnapshot<SectionIdentifier, ItemIdentifier>
    
    // MARK: - Properties
    private let collectionView: UICollectionView
    private let cellProvider: DataSource.CellProvider
    private let supplementaryViewProvider: DataSource.SupplementaryViewProvider
    private let dataSource: DataSource
    
    private let viewModel: ExampleDetailsViewModel
    
    // MARK: - Init
    init(viewModel: ExampleDetailsViewModel) {
        self.collectionView = UICollectionView(frame: .zero, collectionViewLayout: viewModel.collectionViewLayout)
        self.cellProvider = { collectionView, indexPath, item -> UICollectionViewCell in
            let cellViewModel = item.cellViewModel
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellViewModel.reuseIdentifier, for: indexPath)
            (cell as? ConfigurableView)?.configure(with: cellViewModel)
            return cell
        }
        self.supplementaryViewProvider = { collectionView, elementKind, indexPath -> UICollectionReusableView? in
            guard let supplementaryViewModel = viewModel.supplementaryViewModelForSection(at: indexPath) else {
                return UICollectionReusableView()
            }
            
            let view = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader,
                                                                       withReuseIdentifier: supplementaryViewModel.reuseIdentifier,
                                                                       for: indexPath)
            (view as? ConfigurableView)?.configure(with: supplementaryViewModel)
            return view
        }
        self.dataSource = DataSource(collectionView: collectionView, cellProvider: cellProvider)
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
        reloadData()
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
        
        dataSource.supplementaryViewProvider = supplementaryViewProvider
        
        collectionView.delegate = self
        collectionView.dataSource = dataSource
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
    
    private func reloadData() {
        var snapshot = Snapshot()
        snapshot.appendSections(viewModel.sections)
        
        viewModel.sections.forEach { snapshot.appendItems($0.items, toSection: $0) }
        dataSource.apply(snapshot)
    }
}

// MARK: - UICollectionViewDelegate
extension ExampleDetailsViewController: UICollectionViewDelegate {
    
}
