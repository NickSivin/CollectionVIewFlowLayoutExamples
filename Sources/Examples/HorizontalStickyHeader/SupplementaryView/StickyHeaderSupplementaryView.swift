//
//  StickyHeaderSupplementaryView.swift
//  CollectionViewLayoutExamples
//

import UIKit

class StickyHeaderSupplementaryView: UICollectionReusableView, ConfigurableView {
    private let titleLabel = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    func configure(with viewModel: ConfigurableViewModel) {
        guard let viewModel = viewModel as? StickyHeaderSupplementaryViewModel else { return }
        titleLabel.text = viewModel.month
        titleLabel.font = viewModel.font
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setup() {
        addSubview(titleLabel)
        titleLabel.constraintsSupport.makeConstraints { make in
            make.edgesEqualTo(self)
        }
        titleLabel.textAlignment = .center
    }
}
