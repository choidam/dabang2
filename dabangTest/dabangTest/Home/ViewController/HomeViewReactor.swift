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
        case selectRoom(selectIndex: RoomType, isSelect: Bool)
        case selectSale(selectIndex: SellingType, isSelect: Bool)
        case loadMore
    }
    
    enum Mutation {
        case initList([Room], AverageModel)
        case list([Room])
        case sort([Room], isIncrease: Bool)
        case filterRoomList([Room], isSelect: Bool, selectIndex: RoomType)
        case filterSaleList([Room], isSelect: Bool, selectIndex: SellingType)
        case errorMsg
        
        var bindMutation: BindMutation {
            switch self {
            case .initList: return .initList
            case .list: return .list
            case .sort: return .sort
            case .filterRoomList: return .filterRoomList
            case .filterSaleList: return .filterSaleList
            case .errorMsg: return .errorMsg
            }
        }
    }
    
    enum BindMutation {
        case initialState
        case initList
        case list
        case sort
        case filterRoomList
        case filterSaleList
        case errorMsg
    }
    
    struct State {
        var state: BindMutation = .initialState
        
        var sections: [RoomSection] = []

        var selectedRoomTypes: [RoomType] = [.oneRoom, .twoRoom, .officehotel, .apartment]
        var selectedSellingTypes: [SellingType] = [.monthlyRent, .leaseRent, .sale]
        
        var isIncrease: Bool = true
        
        var errorMsg: String?
    }
    
    let initialState: State = State()
    
    private let service: HomeServiceType
    
    var roomItems: [RoomSectionItem] = []
    var averageItem: AverageModel = AverageModel(monthPrice: "", name: "", yearPrice: "")
    
    init(service: HomeServiceType){
        self.service = service
        
        action.onNext(.getlist)
    }
    
    func mutate(action: Action) -> Observable<Mutation> {
        switch action {
        case .getlist:
            return service.getRoomList().map(Mutation.initList)
            
        case .sort(let isIncrease):
            return service.sortRoomList(isIncrease: isIncrease, selectedRoomTypes: currentState.selectedRoomTypes, selectedSellingTypes: currentState.selectedSellingTypes).map { Mutation.sort($0, isIncrease: isIncrease) }
            
        case .selectRoom(let selectRoomType, let isSelect):
            let request = service.selectRoomKind(selectRoomType: selectRoomType, isSelect: isSelect, isIncrease: currentState.isIncrease, selectedRoomTypes: currentState.selectedRoomTypes, selectedSellingTypes: currentState.selectedSellingTypes)
            
            return request.map { Mutation.filterRoomList($0, isSelect: isSelect, selectIndex: selectRoomType) }

        case .selectSale(let selectSellingType, let isSelect):
            let request = service.selectSaleKind(selectSellingType: selectSellingType, isSelect: isSelect, isIncrease: currentState.isIncrease, selectedRoomTypes: currentState.selectedRoomTypes, selectedSellingTypes: currentState.selectedSellingTypes)
            
            return request.map { Mutation.filterSaleList($0, isSelect: isSelect, selectIndex: selectSellingType) }
            
        case .loadMore:
            let request = service.loadMore(selectedRoomTypes: currentState.selectedRoomTypes, selectedSellingTypes: currentState.selectedSellingTypes)
            
            if request.1 == false {
                return .empty()
            } else {
                return request.0.map(Mutation.list)
            }
        }
    }
    
    func reduce(state: State, mutation: Mutation) -> State {
        var state = state
        state.state = mutation.bindMutation
        
        switch mutation {
        case .initList(let list, let avg):
            averageItem.name = avg.name
            averageItem.monthPrice = avg.monthPrice
            averageItem.yearPrice = avg.yearPrice
            
            setSectionItem(list: list)
            state.sections = [.section(roomItems)]
        
        case .list(let list):
            setSectionItem(list: list)
            state.sections = [.section(roomItems)]
            
        case .sort(let list, let isIncrease):
            state.isIncrease = isIncrease
            
            setSectionItem(list: list)
            state.sections = [.section(roomItems)]
            
        case .filterRoomList(let list, let isSelect, let selectIndex):
            if isSelect {
                state.selectedRoomTypes.append(selectIndex)
            } else {
                if state.selectedRoomTypes.count == 1 {
                    state.state = .errorMsg
                    return state
                }
                state.selectedRoomTypes = state.selectedRoomTypes.filter { $0 != selectIndex }
            }
            
            setSectionItem(list: list)
            state.sections = [.section(roomItems)]
            
        case .filterSaleList(let list, let isSelect, let selectIndex):
            if isSelect {
                state.selectedSellingTypes.append(selectIndex)
            } else {
                if state.selectedSellingTypes.count == 1 {
                    state.state = .errorMsg
                    return state
                }
                state.selectedSellingTypes = state.selectedSellingTypes.filter { $0 != selectIndex }
            }
            
            setSectionItem(list: list)
            state.sections = [.section(roomItems)]
                        
        case .errorMsg:
            state.errorMsg = "에러~~"
            return state
        }
        
        return state
    }
    
    private func setSectionItem(list: [Room]){
        roomItems.removeAll()
        
        if list.count >= 12 {
            for i in 0...list.count {
                if i<12 {
                    switch list[i].roomTypeStr {
                    case .oneRoom, .twoRoom:
                        roomItems.append(RoomSectionItem.room(RoomCellReactor(room: list[i])))
                    case .officehotel, .apartment:
                        roomItems.append(RoomSectionItem.apartment(ApartmentCellReactor(priceTitle: list[i].priceTitle, roomType: list[i].roomTypeStr, desc: list[i].desc, hashTags: list[i].hashTags, isCheck: list[i].isCheck)))
                    }
                } else if i == 12 {
                    roomItems.append(RoomSectionItem.average(AverageCellReactor(name: averageItem.name, yearPrice: averageItem.yearPrice, monthPrice: averageItem.monthPrice)))
                } else {
                    switch list[i-1].roomTypeStr {
                    case .oneRoom, .twoRoom:
                        roomItems.append(RoomSectionItem.room(RoomCellReactor(room: list[i-1])))
                    case .officehotel, .apartment:
                        roomItems.append(RoomSectionItem.apartment(ApartmentCellReactor(priceTitle: list[i-1].priceTitle, roomType: list[i-1].roomTypeStr, desc: list[i-1].desc, hashTags: list[i-1].hashTags, isCheck: list[i-1].isCheck)))
                    }
                }
            }
        } else {
            for room in list {
                switch room.roomTypeStr {
                case .oneRoom, .twoRoom:
                    roomItems.append(RoomSectionItem.room(RoomCellReactor(room: room)))
                case .officehotel, .apartment:
                    roomItems.append(RoomSectionItem.apartment(ApartmentCellReactor(priceTitle: room.priceTitle, roomType: room.roomTypeStr, desc: room.desc, hashTags: room.hashTags, isCheck: room.isCheck)))
                }
            }
        }
        
    }

}
