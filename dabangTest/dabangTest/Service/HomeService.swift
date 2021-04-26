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
    var averageItem: AverageModel = AverageModel(monthPrice: "", name: "", yearPrice: "")
    
    var items: [RoomModel] = []
    
    @discardableResult
    func getRoomList() -> (Observable<[RoomModel]>, AverageModel) {
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
                }
                
                for i in 0...11{
                    items.append(roomItems[i])
                }
                
                self.sortRoomList(isIncrease: true)
                
            } catch let e as NSError{
                print(e.localizedDescription)
            }
        } else {
            print("roadTextFile filepath error")
        }
        
        return (Observable.just(items), averageItem)
    }
    
    @discardableResult
    func sortRoomList(isIncrease: Bool) -> Observable<[RoomModel]> {
        if isIncrease {
            items.sort(by: { $0.price < $1.price })
        } else {
            items.sort(by: { $0.price > $1.price })
        }
        
        return Observable.just(items)
    }
    
    // TODO: hasNext
    @discardableResult
    func selectRoomKind(selectIndex: Int, isSelect: Bool, isIncrease: Bool) -> Observable<[RoomModel]> {
        if !isSelect {
            items.removeAll(where: { $0.roomType == selectIndex })
            
            if items.count < 12 {
                for index in items.count...roomItems.count-1 {
                    let room = roomItems[index]
                    if roomItems[index].roomType != selectIndex {
                        items.append(room)
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
        
        sortRoomList(isIncrease: isIncrease)
        
        return Observable.just(items)
    }
    
    @discardableResult
    func selectSaleKind(selectIndex: Int, isSelect: Bool, isIncrease: Bool) -> Observable<[RoomModel]> {
        if !isSelect {
            items.removeAll(where: { $0.sellingType == selectIndex })
            
            if items.count < 12 {
                for index in items.count...roomItems.count-1 {
                    let room = roomItems[index]
                    if roomItems[index].roomType != selectIndex {
                        items.append(room)
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
        
        sortRoomList(isIncrease: isIncrease)
        
        return Observable.just(items)
    }
    
    @discardableResult
    func loadMore(selectedRoomTypes: [Int], selectedSellingTypes: [Int], isIncrease: Bool) -> (Observable<[RoomModel]>, Bool){
        
        var hasNext: Bool = true
        
        if items.count + 12 <= roomItems.count {
            var addCount = 0
            
            for index in items.count...roomItems.count-1 {
                let room = roomItems[index]
                
                if selectedRoomTypes.contains(room.roomType) && selectedSellingTypes.contains(room.sellingType) {
                    addCount += 1
                    items.append(room)
                }
                
                if addCount >= 12 {
                    break
                }
            }
            
            sortRoomList(isIncrease: isIncrease)
        } else {
            hasNext = false
        }
        
        return (Observable.just(items), hasNext)
    }

}
