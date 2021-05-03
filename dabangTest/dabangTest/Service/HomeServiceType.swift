//
//  RoomServiceType.swift
//  dabangTest
//
//  Created by choidam on 2021/04/16.
//

import Foundation
import RxSwift

protocol HomeServiceType {
    @discardableResult
    func getRoomList() -> Observable<([RoomModel], AverageModel)>
    
    @discardableResult
    func sortRoomList(isIncrease: Bool, selectedRoomTypes: [RoomType], selectedSellingTypes: [SellingType]) -> Observable<[RoomModel]>
    
    @discardableResult
    func selectRoomKind(selectRoomType: RoomType, isSelect: Bool, isIncrease: Bool, selectedRoomTypes: [RoomType], selectedSellingTypes: [SellingType]) -> Observable<[RoomModel]>
    
    @discardableResult
    func selectSaleKind(selectSellingType: SellingType, isSelect: Bool, isIncrease: Bool, selectedRoomTypes: [RoomType] ,selectedSellingTypes: [SellingType]) -> Observable<[RoomModel]>
    
    @discardableResult
    func loadMore(selectedRoomTypes: [RoomType], selectedSellingTypes: [SellingType]) -> (Observable<[RoomModel]>, Bool)
}
