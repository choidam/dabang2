//
//  HomeReactor.swift
//  dabangTest
//
//  Created by 최담 on 2021/04/15.
//

import Foundation
import ReactorKit
import RxSwift
import RxDataSources

final class HomeViewReactor: Reactor {
    
    enum Action {
        case getlist
        case sort(isIncrease: Bool)
        case selectRoom(selectIndex: Int, isSelect: Bool, isIncrease: Bool)
        case selectSale(selectIndex: Int, isSelect: Bool, isIncrease: Bool)
        case loadMore
    }
    
    enum Mutation {
        case list([RoomModel])
        case filterRoomList([RoomModel], isSelect: Bool)
        case filterSaleList([RoomModel], isSelect: Bool)
        case errorMsg
        
        var bindMutation: BindMutation {
            switch self {
            case .list: return .list
            case .filterRoomList: return .filterRoomList
            case .filterSaleList: return .filterSaleList
            case .errorMsg: return .errorMsg
            }
        }
    }
    
    enum BindMutation {
        case initialState
        case list
        case filterRoomList
        case filterSaleList
        case errorMsg
    }
    
    struct State {
        var state: BindMutation = .initialState
        
        var sections: [RoomSection] = []
        
        var roomTypeCount: Int = 4
        var saleTypeCount: Int = 3
        
        var errorMsg: String?
    }
    
    let initialState: State = State()
    
    private let service: HomeService
    
    var roomItems: [RoomSectionItem] = []
    var averageItems: [AverageModel] = []
    
    init(service: HomeService){
        self.service = service
        
        action.onNext(.getlist)
    }
    
    func mutate(action: Action) -> Observable<Mutation> {
        switch action {
        case .getlist:
            averageItems.append(service.getAverageList()[0]) // 평균가 데이터
            return service.getRoomList().map(Mutation.list) // 방 데이터
            
        case .sort(let isIncrease):
            return service.sortRoomList(isIncrease: isIncrease).map(Mutation.list)
            
        case .selectRoom(let selectIndex, let isSelect, let isIncrease):
            return service.selectRoomKind(selectIndex: selectIndex, isSelect: isSelect, isIncrease: isIncrease).map { Mutation.filterRoomList($0, isSelect: isSelect) }
 
        case .selectSale(let selectIndex, let isSelect, let isIncrease):
            return service.selectSaleKind(selectIndex: selectIndex, isSelect: isSelect, isIncrease: isIncrease).map { Mutation.filterSaleList($0, isSelect: isSelect) }
            
        case .loadMore:
            return service.scroll().map(Mutation.list)
        }
    }
    
    func reduce(state: State, mutation: Mutation) -> State {
        var state = state
        state.state = mutation.bindMutation
        
        switch mutation {
        case .list(let list):
            setSectionItem(list: list)
            state.sections = [.section(roomItems)]
            
        case .filterRoomList(let list, let isSelect):
            if isSelect {
                state.roomTypeCount += 1
            } else {
                if state.roomTypeCount == 1 {
                    state.state = .errorMsg
                    return state
                }
                state.roomTypeCount -= 1
            }
            
            setSectionItem(list: list)
            state.sections = [.section(roomItems)]
            
        case .filterSaleList(let list, let isSelect):
            if isSelect {
                state.saleTypeCount += 1
            } else {
                if state.saleTypeCount == 1 {
                    state.state = .errorMsg
                    return state
                }
                state.saleTypeCount -= 1
            }
            
            setSectionItem(list: list)
            state.sections = [.section(roomItems)]
            
        case .errorMsg:
            state.errorMsg = "에러~~"
            return state
        }
        
        return state
    }
    
    private func setSectionItem(list: [RoomModel]){
        roomItems.removeAll()
        
        let size = list.count + (list.count/12)
        for index in 0...size-1 {
            if (index+1) % 13 == 0 {
                roomItems.append(RoomSectionItem.average(AverageCellReactor(average: averageItems[0])))
            } else {
                let idx = index - (index/12)
                roomItems.append(RoomSectionItem.room(RoomCellReactor(room: list[idx])))
            }
        }
    }

}
