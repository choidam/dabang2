//
//  ApartmentCellReactor.swift
//  dabangTest
//
//  Created by choidam on 2021/04/23.
//

import Foundation
import RxSwift
import RxCocoa
import ReactorKit

class ApartmentCellReactor: Reactor {
    
    typealias Action = NoAction
        
    struct State {
        var priceTitle: String
        var roomType: RoomType
        var sellingType: SellingType
        var desc: String
        var hashTags: [String]
        var isCheck: Bool
    }
    
    var initialState: State
    
    init(priceTitle: String, roomType: RoomType, sellingType: SellingType, desc: String, hashTags: [String], isCheck: Bool) {
        initialState = State(priceTitle: priceTitle, roomType: roomType, sellingType: sellingType, desc: desc, hashTags: hashTags, isCheck: isCheck)
        
        initialState.priceTitle = priceTitle
        initialState.roomType = roomType
        initialState.sellingType = sellingType
        initialState.desc = desc
        initialState.hashTags = hashTags
        initialState.isCheck = isCheck
    }
}
