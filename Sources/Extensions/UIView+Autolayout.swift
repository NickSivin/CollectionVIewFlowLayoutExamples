//
//  UIView+Autolayout.swift
//  CollectionViewFlowLayoutExamples
//

import UIKit

enum LayoutXAxisAnchor {
    case leading
    case trailing
}

enum LayoutYAxisAnchor {
    case top
    case bottom
}

extension UIView {
    var layoutMaker: LayoutConstraintMaker {
        return LayoutConstraintMaker(view: self)
    }
}

struct LayoutConstraintMaker {
    private weak var view: UIView?
    
    init(view: UIView) {
        self.view = view
    }
    
    func edgesEqualTo(_ view: UIView) {
        leadingEqualTo(view)
        trailingEqualTo(view)
        topEqualTo(view)
        bottomEqualTo(view)
    }
    
    func leadingEqualTo(_ view: UIView, anchor: LayoutXAxisAnchor = .leading, offset: CGFloat = 0) {
        self.view?.leadingAnchor.constraint(equalTo: view.makeLayoutAnchor(from: anchor), constant: offset).isActive = true
    }
    
    func trailingEqualTo(_ view: UIView, anchor: LayoutXAxisAnchor = .trailing, offset: CGFloat = 0) {
        self.view?.trailingAnchor.constraint(equalTo: view.makeLayoutAnchor(from: anchor), constant: offset).isActive = true
    }
    
    func topEqualTo(_ view: UIView, anchor: LayoutYAxisAnchor = .top, offset: CGFloat = 0) {
        self.view?.topAnchor.constraint(equalTo: view.makeLayoutAnchor(from: anchor), constant: offset).isActive = true
    }
    
    func bottomEqualTo(_ view: UIView, anchor: LayoutYAxisAnchor = .bottom, offset: CGFloat = 0) {
        self.view?.bottomAnchor.constraint(equalTo: view.makeLayoutAnchor(from: anchor), constant: offset).isActive = true
    }
    
    func widthEqualToHeight() {
        guard let view = view else { return }
        view.widthAnchor.constraint(equalTo: view.heightAnchor).isActive = true
    }
}

extension UIView {
    fileprivate func makeLayoutAnchor(from anchor: LayoutXAxisAnchor) -> NSLayoutAnchor<NSLayoutXAxisAnchor> {
        switch anchor {
        case .leading:
            return leadingAnchor
        case .trailing:
            return trailingAnchor
        }
    }
    
    fileprivate func makeLayoutAnchor(from anchor: LayoutYAxisAnchor) -> NSLayoutAnchor<NSLayoutYAxisAnchor> {
        switch anchor {
        case .top:
            return topAnchor
        case .bottom:
            return bottomAnchor
        }
    }
}
