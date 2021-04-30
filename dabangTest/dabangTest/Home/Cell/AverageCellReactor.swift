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
        var name: String
        var yearPrice: String
        var monthPrice: String
    }
    
    var initialState: State
    
    init(name: String, yearPrice: String, monthPrice: String) {
        initialState = State(name: name, yearPrice: yearPrice, monthPrice: monthPrice)
        
        initialState.name = name
        initialState.yearPrice = yearPrice
        initialState.monthPrice = monthPrice
    }
    
}
