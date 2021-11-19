//
//  HomeCell.swift
//  CollectionViewFlowLayoutExamples
//

import UIKit

class HomeCell: UITableViewCell {
    private let containerView = UIView()
    private let iconView = UIImageView()
    private let titleLabel = UILabel()
    private let descriptionLabel = UILabel()
    
    private func setup() {
        
    }
    
    private func setupContainerView() {
        addSubview(containerView)
        containerView.layoutMaker.leadingEqualTo(self, offset: 8)
        containerView.layoutMaker.trailingEqualTo(self, offset: 8)
        containerView.layoutMaker.topEqualTo(self)
        containerView.layoutMaker.bottomEqualTo(self)
    }
    
    private func setupIconView() {
        containerView.addSubview(iconView)
        iconView.layoutMaker.leadingEqualTo(containerView, offset: 16)
        iconView.layoutMaker.topEqualTo(containerView, offset: 16)
        iconView.layoutMaker.bottomEqualTo(containerView, offset: 16)
        iconView.layoutMaker.widthEqualToHeight()
    }
    
    private func setupTitleLabel() {
        addSubview(titleLabel)
        
    }
}
