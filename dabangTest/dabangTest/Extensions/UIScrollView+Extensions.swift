//
//  UIScrollView+Extensions.swift
//  dabangTest
//
//  Created by choidam on 2021/04/22.
//

import UIKit
import RxSwift
import RxCocoa
import ReactorKit

extension UIScrollView {
    
    var isOverflowVertical: Bool {
        return self.contentSize.height > self.frame.size.height && self.frame.size.height > 0
    }
    
    func isReachedBottom(withTolerance tolerance: CGFloat = 0) -> Bool {
        guard self.isOverflowVertical else { return false }
        let contentOffsetBottom = self.contentOffset.y + self.frame.size.height
        return contentOffsetBottom >= self.contentSize.height - tolerance
    }

    func scrollToBottom(animated: Bool) {
        guard self.isOverflowVertical else { return }
        let targetY = self.contentSize.height + self.contentInset.bottom - self.frame.size.height
        let targetOffset = CGPoint(x: 0, y: targetY)
        self.setContentOffset(targetOffset, animated: true)
    }
    
}

extension Reactive where Base: UIScrollView {

    var isReachedBottom: ControlEvent<Void> {
        let source = self.contentOffset
            .filter { [weak base = self.base] offset in
            guard let base = base else { return false }
            return base.isReachedBottom(withTolerance: base.frame.size.height / 2)
        }
        .map { _ in Void() }
        return ControlEvent(events: source)
      }

    func isReachedBottom(multiple: CGFloat) -> ControlEvent<Void> {
        let source = self.contentOffset
            .filter { [weak base = self.base] offset in
            guard let base = base else { return false }
            return base.isReachedBottom(withTolerance: base.frame.size.height * multiple)
        }
        .map { _ in Void() }
      return ControlEvent(events: source)
    }
}

extension Reactive where Base: UITableView {
    var isReachedBottomCell: ControlEvent<Void> {
        let source = willDisplayCell
            .map { (_, indexPath) -> Void? in
                if let count = self.base.dataSource?.tableView(self.base, numberOfRowsInSection: 0) {
                    return (indexPath.row == count - 1) ? () : nil
                }
                
                return nil
                
            }.compactMap { $0 }
        
        return ControlEvent(events: source)
    }
}


