//
//  RoomCellReactor.swift
//  dabangTest
//
//  Created by choidam on 2021/04/19.
//

import Foundation
import RxSwift
import RxCocoa
import ReactorKit

class RoomCellReactor: Reactor {
    
    typealias Action = NoAction
        
    struct State {
        var room: Room
    }
    
    var initialState: State
    
    init(room: Room) {
        initialState = State(room: room)
    }
}
