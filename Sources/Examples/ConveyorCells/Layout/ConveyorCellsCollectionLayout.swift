//
//  ConveyorCellsCollectionLayout.swift
//  CollectionViewLayoutExamples
//

import UIKit

class ConveyorCellsCollectionLayout: BaseCollectionViewLayout {
    private var itemSize: CGSize = .zero
    private let spacing: CGFloat = 16
    private let topContentInset: CGFloat = 16
    
    private var topAdjustedContentInset: CGFloat {
        return collectionView?.adjustedContentInset.top ?? 0
    }
    
    private var yContentOffset: CGFloat {
        return (collectionView?.contentOffset.y ?? 0) + topAdjustedContentInset
    }
    
    private var visibleAreaHeight: CGFloat {
        guard let collectionView = collectionView else { return 0 }
        return collectionView.bounds.height
        - collectionView.adjustedContentInset.top
        - collectionView.adjustedContentInset.bottom
    }
    
    override func shouldInvalidateLayout(forBoundsChange newBounds: CGRect) -> Bool {
        return true
    }
    
    override func targetContentOffset(forProposedContentOffset proposedContentOffset: CGPoint,
                                      withScrollingVelocity velocity: CGPoint) -> CGPoint {
        let itemHeight = itemSize.height + spacing
        let reminder = proposedContentOffset.y.truncatingRemainder(dividingBy: itemHeight)
        let shouldScrollToNext = reminder > 0 && reminder < itemHeight / 2
        let whole = proposedContentOffset.y - reminder
        
        let highestPoint = topAdjustedContentInset + topContentInset
        let yValue = max(-highestPoint, whole + round(reminder / itemHeight) * itemHeight - topAdjustedContentInset)
        let contentOffset = CGPoint(x: proposedContentOffset.x, y: shouldScrollToNext ? yValue + itemHeight : yValue)
        
        return super.targetContentOffset(forProposedContentOffset: contentOffset, withScrollingVelocity: velocity)
    }
    
    override func setup(collectionView: UICollectionView) {
        super.setup(collectionView: collectionView)
        
        itemSize = makeItemSize(itemsCount: 7, collectionView: collectionView)
        
        var sectionOffset: CGFloat = topContentInset
        
        let numberOfSections = collectionView.numberOfSections
        for sectionIndex in 0..<numberOfSections {
            setupSectionAttributes(at: sectionIndex,
                                   sectionOffset: sectionOffset,
                                   collectionView: collectionView)
            let numberOfItems = CGFloat(collectionView.numberOfItems(inSection: sectionIndex))
            sectionOffset += numberOfItems * itemSize.width
            sectionOffset += (numberOfItems - 1) * spacing
        }
        
        let expectedContentSize = CGSize(width: contentBounds.width, height: contentBounds.height)
        contentBounds = CGRect(origin: contentBounds.origin, size: expectedContentSize)
    }
    
    private func setupSectionAttributes(at sectionIndex: Int,
                                        sectionOffset: CGFloat,
                                        collectionView: UICollectionView) {
        let numberOfItems = collectionView.numberOfItems(inSection: sectionIndex)
        for itemIndex in 0..<numberOfItems {
            setupItemAttributes(at: itemIndex,
                                sectionIndex: sectionIndex,
                                sectionOffset: sectionOffset,
                                collectionView: collectionView)
        }
    }
    
    private func setupItemAttributes(at itemIndex: Int,
                                     sectionIndex: Int,
                                     sectionOffset: CGFloat,
                                     collectionView: UICollectionView) {
        let nextItemIndex = itemIndex + 1
        let expectedYValue = sectionOffset + CGFloat(itemIndex) * itemSize.height + CGFloat(itemIndex) * spacing
        let nextYValue = sectionOffset + CGFloat(nextItemIndex) * itemSize.height + CGFloat(nextItemIndex) * spacing
        
        let yAnchor = yContentOffset + topContentInset
        let zoomAreaHeight = itemSize.height + spacing
        let zoomThreshold = yAnchor + zoomAreaHeight
        
        let isZoomAvailable = ((yAnchor - itemSize.height)...zoomThreshold).contains(nextYValue)
        
        let prevItemIndex = itemIndex - 1
        let prevYValue = sectionOffset + CGFloat(prevItemIndex) * itemSize.height + CGFloat(prevItemIndex) * spacing
        
        let yAnchorBottom = yContentOffset + topContentInset + visibleAreaHeight - zoomAreaHeight
        let zoomThresholdBottom = yAnchorBottom - zoomAreaHeight
        
        let isZoomAvailableBottom = (zoomThresholdBottom...(yAnchorBottom + itemSize.height)).contains(prevYValue)
        
        var yValue: CGFloat
        let distancePassed: CGFloat
        
        if isZoomAvailable {
            yValue = yAnchor
            distancePassed = zoomThreshold - nextYValue
        } else if isZoomAvailableBottom {
            yValue = yAnchorBottom
            distancePassed = prevYValue - zoomThresholdBottom
        } else {
            yValue = expectedYValue
            distancePassed = 0
        }
        
        yValue = correctedYValueForUpperBound(yValue: correctedYValueForLowerBound(yValue: yValue))
        
        let minZoomScale: CGFloat = 0.75
        let zoomPercent = (isZoomAvailable || isZoomAvailableBottom) ? (distancePassed * minZoomScale.inversed / zoomAreaHeight).inversed : 1
        
        let width = itemSize.width * zoomPercent
        let widthDiff = itemSize.width - width
        let height = itemSize.height * zoomPercent
        let frame = CGRect(x: widthDiff / 2, y: yValue, width: width, height: height)
        
        let attributes = UICollectionViewLayoutAttributes(forCellWith: IndexPath(item: itemIndex, section: sectionIndex))
        attributes.frame = frame
        attributes.zIndex = Int(zoomPercent * 100)
        
        var sectionAttributes = cachedAttributes[sectionIndex] ?? []
        sectionAttributes.append(attributes)
        cachedAttributes[sectionIndex] = sectionAttributes
        
        let actualFrame = CGRect(x: 0, y: expectedYValue, width: itemSize.width, height: itemSize.height)
        contentBounds = contentBounds.union(actualFrame)
    }
    
    private func makeItemSize(itemsCount: Int, collectionView: UICollectionView) -> CGSize {
        let spacingTotalHeight = spacing * CGFloat(itemsCount - 1)
        let height = (visibleAreaHeight - spacingTotalHeight - topContentInset) / CGFloat(itemsCount)
        return CGSize(width: collectionView.bounds.width, height: height)
    }
    
    private func correctedYValueForUpperBound(yValue: CGFloat) -> CGFloat{
        guard yValue <= -topContentInset else { return yValue }
        return -(itemSize.height + spacing)
    }
    
    private func correctedYValueForLowerBound(yValue: CGFloat) -> CGFloat {
        guard yValue >= yContentOffset + topContentInset + visibleAreaHeight else { return yValue }
        return collectionViewContentSize.height + spacing
    }
}

private extension CGFloat {
    var inversed: CGFloat {
        return 1 - self
    }
}
