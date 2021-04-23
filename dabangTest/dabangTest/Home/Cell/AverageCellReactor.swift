//
//  AverageCellReactor.swift
//  dabangTest
//
//  Created by choidam on 2021/04/19.
//

import Foundation
import RxSwift
import RxCocoa
import ReactorKit

class AverageCellReactor: Reactor {
    
    typealias Action = NoAction
    
    struct State {
        var average: AverageModel
    }
    
    var initialState: State
    
    init(average: AverageModel) {
        initialState = State(average: average)
    }
    
}
