//
//  HorizontalStickyHeaderCell.swift
//  CollectionViewLayoutExamples
//

import UIKit

class HorizontalStickyHeaderCell: UICollectionViewCell, ConfigurableView {
    // MARK: - Properties
    private let containerView = UIView()
    private let titleLabel = UILabel()
    
    // MARK: - Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Public
    func configure(with viewModel: ConfigurableViewModel) {
        guard let viewModel = viewModel as? HorizontalStickyHeaderCellViewModel else { return }
        titleLabel.text = viewModel.day
    }
    
    // MARK: - Private
    private func setup() {
        setupContainerView()
        setupTitleLabel()
    }
    
    private func setupContainerView() {
        addSubview(containerView)
        containerView.constraintsSupport.makeConstraints { make in
            make.edgesEqualTo(self)
        }
    }
    
    private func setupTitleLabel() {
        containerView.addSubview(titleLabel)
        titleLabel.constraintsSupport.makeConstraints { make in
            make.edgesEqualTo(containerView)
        }
        titleLabel.font = .systemFont(ofSize: 22, weight: .thin)
        titleLabel.textAlignment = .center
    }
}
