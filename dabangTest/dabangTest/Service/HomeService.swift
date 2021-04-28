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
    
    var roomItems: [RoomModel] = [] // 전체 데이터
    var items: [RoomModel] = []
    
    @discardableResult
    func getRoomList() -> (Observable<[RoomModel]>, AverageModel) {
        var averageItem = AverageModel(monthPrice: "", name: "", yearPrice: "")
        
        if let filepath = Bundle.main.path(forResource: "RoomListData", ofType: "txt") {
            do {
                let contents = try String(contentsOfFile: filepath)
                let data = contents.data(using: .utf8)!
                let decoder = JSONDecoder()
                let roomData = try decoder.decode(RoomResponseString.self, from: data)
                
                averageItem.name = roomData.average[0].name
                averageItem.monthPrice = roomData.average[0].monthPrice
                averageItem.yearPrice = roomData.average[0].yearPrice
                
                for room in roomData.rooms {
                    var tmp = ""
                    var price = 0
                    for ch in room.priceTitle {
                        if ch.isNumber == true {
                            tmp.append(ch)
                        } else {
                            if ch == "억" {
                                price += Int(tmp)!*10000
                                tmp = ""
                            } else if ch == "천" {
                                price += Int(tmp)!*1000
                                continue
                            } else if ch == "만" {
                                price += Int(tmp)!
                                continue
                            }
                        }
                    }
                    
                    self.roomItems.append(RoomModel(desc: room.desc, isCheck: room.isCheck, priceTitle: room.priceTitle, price: price, roomType: room.roomType, sellingType: room.sellingType, hashTags: room.hashTags, imgURL: room.imgURL))
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
        
        return (Observable.just(items), averageItem)
    }
    
    @discardableResult
    func sortRoomList(isIncrease: Bool, selectedRoomTypes: [Int], selectedSellingTypes: [Int]) -> Observable<[RoomModel]> {
        sortItems(isIncrease: isIncrease)

        for i in 0...11{
            if selectedRoomTypes.contains(roomItems[i].roomType) && selectedSellingTypes.contains(roomItems[i].sellingType) {
                items.append(roomItems[i])
            }
        }
        
        return Observable.just(items)
    }
    
    @discardableResult
    func selectRoomKind(selectIndex: Int, isSelect: Bool, isIncrease: Bool, selectedRoomTypes: [Int], selectedSellingTypes: [Int]) -> (Observable<[RoomModel]>, Bool) {
        sortItems(isIncrease: isIncrease)
        
        var newRoomItems: [RoomModel] = roomItems
        
        for room in items {
            newRoomItems = newRoomItems.filter({ $0.identity != room.identity })
        }
        
        var hasNext: Bool = true
        
        if newRoomItems.count <= 0 {
            hasNext = false
            return (Observable.just(items), hasNext)
        }
        
        if !isSelect {
            items.removeAll(where: { $0.roomType == selectIndex })
            
            if items.count < 12 {
                for room in newRoomItems {
                    if selectedRoomTypes.contains(room.roomType) && selectedSellingTypes.contains(room.sellingType) {
                        if room.roomType != selectIndex {
                            items.append(room)
                        }
                    }
                    if items.count >= 12 { break }
                }
            }
            
        } else {
            for room in roomItems {
                if room.roomType == selectIndex {
                    items.append(room)
                }
            }
        }
        
        sortItems(isIncrease: isIncrease)
        
        return (Observable.just(items), hasNext)
    }
    
    @discardableResult
    func selectSaleKind(selectIndex: Int, isSelect: Bool, isIncrease: Bool, selectedRoomTypes: [Int] ,selectedSellingTypes: [Int]) -> (Observable<[RoomModel]>, Bool) {
        sortItems(isIncrease: isIncrease)
        
        var newRoomItems: [RoomModel] = roomItems
        
        for room in items {
            newRoomItems = newRoomItems.filter({ $0.identity != room.identity })
        }
        
        var hasNext: Bool = true
        
        if newRoomItems.count <= 0 {
            hasNext = false
            return (Observable.just(items), hasNext)
        }
        
        if !isSelect {
            items.removeAll(where: { $0.sellingType == selectIndex })
            
            if items.count < 12 {
                for room in newRoomItems {
                    if selectedSellingTypes.contains(room.sellingType) && selectedRoomTypes.contains(room.roomType) {
                        if room.sellingType != selectIndex {
                            items.append(room)
                        }
                    }
                    if items.count >= 12 { break }
                }
            }
            
        } else {
            for room in roomItems {
                if room.sellingType == selectIndex {
                    items.append(room)
                }
            }
        }
        
        sortItems(isIncrease: isIncrease)
        
        return (Observable.just(items), hasNext)
    }
    
    @discardableResult
    func loadMore(selectedRoomTypes: [Int], selectedSellingTypes: [Int]) -> (Observable<[RoomModel]>, Bool){
        
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
                
                if selectedRoomTypes.contains(room.roomType) && selectedSellingTypes.contains(room.sellingType) {
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
