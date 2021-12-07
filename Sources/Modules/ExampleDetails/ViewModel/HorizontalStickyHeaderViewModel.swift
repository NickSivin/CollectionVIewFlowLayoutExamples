//
//  HorizontalStickyHeaderViewModel.swift
//  CollectionViewLayoutExamples
//

import UIKit

class HorizontalStickyHeaderViewModel: ExampleDetailsViewModel {
    var collectionViewHeight: CGFloat? {
        return 80
    }
    
    var cellsRegistrationInfo: [ViewRegistrationInfo] {
        return [
            ViewRegistrationInfo(viewClass: HorizontalStickyHeaderCell.self,
                                 viewIdentifier: HorizontalStickyHeaderCell.reuseIdentifier)
        ]
    }
    
    var supplementaryRegistrationInfo: [ViewRegistrationInfo] {
        return [
            ViewRegistrationInfo(viewClass: StickyHeaderSupplementaryView.self,
                                 viewIdentifier: StickyHeaderSupplementaryView.reuseIdentifier)
        ]
    }
    
    private(set) lazy var collectionViewLayout = makeCollectionViewLayout()
    private(set) lazy var sections = makeSections()
    
    private func makeCollectionViewLayout() -> UICollectionViewLayout {
        let layout = HorizontalStickyHeaderCollectionLayout()
        layout.itemSize = CGSize(width: 120, height: 60)
        layout.delegate = self
        return layout
    }
    
    private func makeSections() -> [ExampleDetailsSection] {
        let groupedDates = makeGroupedDatesByMonths()
        let keys = groupedDates.keys
        return keys
            .sorted {
                guard let lhs = DateFormatter.monthAndYear.date(from: $0),
                      let rhs = DateFormatter.monthAndYear.date(from: $1) else {
                    return false
                }
                return lhs > rhs
            }
            .compactMap {
                guard let dates = groupedDates[$0], let firstDate = dates.first else { return nil }
                let elements = makeElements(from: dates.reversed())
                let supplementaryViewModel = StickyHeaderSupplementaryViewModel(date: firstDate)
                return ExampleDetailsSection(supplementaryViewModel: supplementaryViewModel, elements: elements)
            }
    }
    
    private func makeGroupedDatesByMonths() -> [String: [Date]] {
        let dates = makeDatesForLastYear()
        return Dictionary(grouping: dates) { DateFormatter.monthAndYear.string(from: $0) }
    }
    
    private func makeDatesForLastYear() -> [Date] {
        guard let twoMonthAgo = Calendar.current.date(byAdding: .month, value: -2, to: .now) else {
            return []
        }
        
        var result: [Date] = []
        var date = twoMonthAgo
        while date <= .now {
            result.append(date)
            guard let nextDate =  Calendar.current.date(byAdding: .day, value: 1, to: date) else {
                break
            }
            date = nextDate
        }
        return result
    }
    
    private func makeElements(from dates: [Date]) -> [ExampleDetailsElement] {
        return dates.map {
            let cellViewModel = HorizontalStickyHeaderCellViewModel(date: $0)
            return ExampleDetailsElement(cellViewModel: cellViewModel)
        }
    }
}

extension HorizontalStickyHeaderViewModel: HorizontalStickyHeaderCollectionLayoutDelegate {
    func horizontalStickyHeaderCollectionLayout(_ collectionView: UICollectionView,
                                                layout collectionViewLayout: UICollectionViewLayout,
                                                referenceSizeForHeaderInSection section: Int) -> CGSize {
        guard let supplementaryViewModel = sections[section].supplementaryViewModel as? StickyHeaderSupplementaryViewModel else {
            return .zero
        }
        
        let title = supplementaryViewModel.month ?? ""
        let rect = (title as NSString).boundingRect(with: CGSize(width: .greatestFiniteMagnitude, height: 17.0),
                                                    options: [.usesLineFragmentOrigin, .usesFontLeading],
                                                    attributes: [.font: supplementaryViewModel.font],
                                                    context: nil)
        return rect.size
    }
}
