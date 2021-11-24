//
//  HomeCell.swift
//  CollectionViewLayoutExamples
//

import UIKit

class HomeCell: UITableViewCell, CommonCell {
    // MARK: - Properties
    private let containerView = UIView()
    private let iconView = UIImageView()
    private let titleLabel = UILabel()
    private let descriptionLabel = UILabel()
    
    // MARK: - Init
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Public
    func configure(with viewModel: CommonCellViewModel) {
        guard let viewModel = viewModel as? HomeCellViewModel else { return }
        titleLabel.text = viewModel.title
        descriptionLabel.text = viewModel.description
        iconView.image = viewModel.icon
    }
    
    // MARK: - Private
    private func setup() {
        setupContainerView()
        setupIconView()
        setupTitleLabel()
        setupDescriptionLabel()
    }
    
    private func setupContainerView() {
        addSubview(containerView)
        containerView.constraintsSupport.makeConstraints { make in
            make.leadingEqualTo(self, offset: 8)
            make.trailingEqualTo(self, offset: 8)
            make.topEqualTo(self)
            make.bottomEqualTo(self)
        }
    }
    
    private func setupIconView() {
        containerView.addSubview(iconView)
        iconView.constraintsSupport.makeConstraints { make in
            make.leadingEqualTo(containerView, offset: 16)
            make.topEqualTo(containerView, offset: 16)
            make.sizeEqualTo(24)
        }
    }
    
    private func setupTitleLabel() {
        containerView.addSubview(titleLabel)
        titleLabel.constraintsSupport.makeConstraints { make in
            make.leadingEqualTo(iconView, anchor: .trailing, offset: 16)
            make.topEqualTo(iconView)
            make.trailingEqualTo(containerView, offset: -4)
        }
        titleLabel.font = .boldSystemFont(ofSize: 14)
    }
    
    private func setupDescriptionLabel() {
        containerView.addSubview(descriptionLabel)
        descriptionLabel.constraintsSupport.makeConstraints { make in
            make.topEqualTo(titleLabel, anchor: .bottom, offset: 4)
            make.leadingEqualTo(titleLabel)
            make.trailingEqualTo(titleLabel)
            make.bottomEqualTo(containerView, offset: -16)
        }
        descriptionLabel.numberOfLines = 0
        descriptionLabel.font = .systemFont(ofSize: 12)
    }
}
