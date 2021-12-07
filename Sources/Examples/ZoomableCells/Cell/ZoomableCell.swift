//
//  ZoomableCell.swift
//  CollectionViewLayoutExamples
//

import UIKit

class ZoomableCell: UICollectionViewCell, ConfigurableView {
    private let containerView = UIView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(with viewModel: ConfigurableViewModel) {
        guard let viewModel = viewModel as? ZoomableCellViewModel else { return }
    }
    
    private func setup() {
        setupContainerView()
    }
    
    private func setupContainerView() {
        addSubview(containerView)
        containerView.constraintsSupport.makeConstraints { make in
            make.leadingEqualTo(self, offset: 16)
            make.trailingEqualTo(self, offset: -16)
            make.topEqualTo(self)
            make.bottomEqualTo(self)
        }
        containerView.backgroundColor = .gray
        containerView.layer.cornerRadius = 8
    }
}
