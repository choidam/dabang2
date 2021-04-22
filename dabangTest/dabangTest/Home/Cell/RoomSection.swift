//
//  RoomSection.swift
//  dabangTest
//
//  Created by choidam on 2021/04/16.
//

import UIKit
import RxSwift
import RxCocoa
import RxDataSources

enum RoomSection {
    case section([RoomSectionItem])
}

extension RoomSection: SectionModelType {
    var items: [RoomSectionItem] {
        switch self {
        case .section(let items): return items
        }
    }
    
    init(original: RoomSection, items: [RoomSectionItem]) {
        switch original {
        case .section: self = .section(items)
        }
    }
}

enum RoomSectionItem {
    case room(RoomCellReactor)
    case average(AverageCellReactor)
}
