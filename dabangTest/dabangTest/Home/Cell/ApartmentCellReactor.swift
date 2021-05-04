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
        var desc: String
        var hashTags: [String]
        var isCheck: Bool
    }
    
    var initialState: State
    
    init(priceTitle: String, roomType: RoomType, desc: String, hashTags: [String], isCheck: Bool) {
        initialState = State(priceTitle: priceTitle, roomType: roomType, desc: desc, hashTags: hashTags, isCheck: isCheck)
        
        initialState.priceTitle = priceTitle
        initialState.roomType = roomType
        initialState.desc = desc
        initialState.hashTags = hashTags
        initialState.isCheck = isCheck
    }
}
