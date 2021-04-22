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
    func getRoomList() -> Observable<[RoomModel]>

    @discardableResult
    func sortRoomList(isIncrease: Bool) -> Observable<[RoomModel]>
    
    @discardableResult
    func selectRoomKind(selectIndex: Int, isSelect: Bool, isIncrease: Bool) -> Observable<[RoomModel]>
    
    @discardableResult
    func selectSaleKind(selectIndex: Int, isSelect: Bool, isIncrease: Bool) -> Observable<[RoomModel]>
}
