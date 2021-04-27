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
    func getRoomList() -> (Observable<[RoomModel]>, AverageModel)

    @discardableResult
    func sortRoomList(isIncrease: Bool, selectedRoomTypes: [Int], selectedSellingTypes: [Int]) -> Observable<[RoomModel]>
    
    @discardableResult
    func selectRoomKind(selectIndex: Int, isSelect: Bool, isIncrease: Bool, selectedRoomTypes: [Int], selectedSellingTypes: [Int]) -> (Observable<[RoomModel]>, Bool)
    
    @discardableResult
    func selectSaleKind(selectIndex: Int, isSelect: Bool, isIncrease: Bool, selectedRoomTypes: [Int] ,selectedSellingTypes: [Int]) -> (Observable<[RoomModel]>, Bool)
    
    @discardableResult
    func loadMore(selectedRoomTypes: [Int], selectedSellingTypes: [Int], isIncrease: Bool) -> (Observable<[RoomModel]>, Bool)
}
