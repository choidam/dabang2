//
//  RoomService.swift
//  dabangTest
//
//  Created by choidam on 2021/04/16.
//

import UIKit
import RxSwift
import RxCocoa
import RxDataSources

class HomeService: HomeServiceType {
    
    var roomItems: [Room] = [] // 전체 데이터
    var items: [Room] = []
    
    @discardableResult
    func getRoomList() -> Observable<([Room], AverageModel)> {
        var averageItem = AverageModel(monthPrice: "", name: "", yearPrice: "")
        
        if let filepath = Bundle.main.path(forResource: "RoomListData", ofType: "txt") {
            do {
                let contents = try String(contentsOfFile: filepath)
                let data = contents.data(using: .utf8)!
                let decoder = JSONDecoder()
                let roomData = try decoder.decode(RoomResponseModel.self, from: data)
                
                averageItem.name = roomData.average[0].name
                averageItem.monthPrice = roomData.average[0].monthPrice
                averageItem.yearPrice = roomData.average[0].yearPrice
                
                for room in roomData.rooms {
                    self.roomItems.append(room)
                    roomItems.sort(by: { $0.price < $1.price })
                }
                
                for i in 0...11{
                    items.append(roomItems[i])
                }
                
            } catch let e as NSError{
                print(e.localizedDescription)
            }
        } else {
            print("roadTextFile filepath error")
        }
        
        return Observable.combineLatest(
            Observable.just(items),
            Observable.just(averageItem)
        )
    }
    
    @discardableResult
    func sortRoomList(isIncrease: Bool, selectedRoomTypes: [RoomType], selectedSellingTypes: [SellingType]) -> Observable<[Room]> {
        
        sortItems(isIncrease: isIncrease)
        
        let count = items.count
        items.removeAll()
        
        for room in roomItems {
            if selectedRoomTypes.contains(room.roomTypeStr) && selectedSellingTypes.contains(room.sellingTypeStr) {
                items.append(room)
            }
            if items.count == count { break }
        }
        
        return Observable.just(items)
    }
    
    @discardableResult
    func selectRoomKind(selectRoomType: RoomType, isSelect: Bool, isIncrease: Bool, selectedRoomTypes: [RoomType], selectedSellingTypes: [SellingType]) -> Observable<[Room]> {
        sortItems(isIncrease: isIncrease)
        print("increase \(isIncrease)")
    
        var newSelectedRoomTypes = selectedRoomTypes
        
        if isSelect {
            newSelectedRoomTypes.append(selectRoomType)
        } else {
            newSelectedRoomTypes = newSelectedRoomTypes.filter({ $0 != selectRoomType })
        }
        
        items.removeAll()
        
        for room in roomItems {
            if newSelectedRoomTypes.contains(room.roomTypeStr) && selectedSellingTypes.contains(room.sellingTypeStr) {
                items.append(room)
            }
        }
        
        return Observable.just(items)
    }
    
    @discardableResult
    func selectSaleKind(selectSellingType: SellingType, isSelect: Bool, isIncrease: Bool, selectedRoomTypes: [RoomType] ,selectedSellingTypes: [SellingType]) -> Observable<[Room]> {
        sortItems(isIncrease: isIncrease)
        
        var newSelectedSellingTypes = selectedSellingTypes
        
        if isSelect {
            newSelectedSellingTypes.append(selectSellingType)
        } else {
            newSelectedSellingTypes = newSelectedSellingTypes.filter({ $0 != selectSellingType })
        }
        
        items.removeAll()
        
        for room in roomItems {
            if selectedRoomTypes.contains(room.roomTypeStr) && newSelectedSellingTypes.contains(room.sellingTypeStr) {
                items.append(room)
            }
        }

        return Observable.just(items)
    }
    
    @discardableResult
    func loadMore(selectedRoomTypes: [RoomType], selectedSellingTypes: [SellingType]) -> (Observable<[Room]>, Bool){
        
        var hasNext: Bool = true
        
        let lastRoom = items[items.count-1]
        var idx: Int = 0
        for i in 0...roomItems.count-1{
            if lastRoom.identity == roomItems[i].identity {
                idx = i
            }
        }
        
        if idx+12 <= roomItems.count {
            var addCount = 0

            for index in idx...roomItems.count-1 {
                let room = roomItems[index]

                if selectedRoomTypes.contains(room.roomTypeStr) && selectedSellingTypes.contains(room.sellingTypeStr) {
                    addCount += 1
                    items.append(room)
                }

                if addCount >= 12 { break }
            }

            if addCount < 12 { hasNext = false }

        } else {
            hasNext = false
        }
        
        return (Observable.just(items), hasNext)
    }
    
    private func sortItems(isIncrease: Bool) {
        if isIncrease {
            roomItems.sort(by: { $0.price < $1.price })
            items.sort(by: { $0.price < $1.price })
        } else {
            roomItems.sort(by: { $0.price > $1.price })
            items.sort(by: { $0.price > $1.price })
        }
    }
}
