//
//  RoomModel.swift
//  dabangTest
//
//  Created by choidam on 2021/04/20.
//

import Foundation
import RxDataSources

// MARK: - RoomModel
struct RoomModel: Equatable, IdentifiableType {
    let identity = UUID().uuidString
    
    var desc: String
    var isCheck: Bool
    var priceTitle: String
    var price: Int
    var roomType: Int
    var sellingType: Int
    var hashTags: [String]
    var imgURL: String
    
    init(desc: String, isCheck: Bool, priceTitle: String, price: Int, roomType: Int, sellingType: Int, hashTags: [String], imgURL: String) {
        self.desc = desc
        self.isCheck = isCheck
        self.priceTitle = priceTitle
        self.price = price
        self.roomType = roomType
        self.sellingType = sellingType
        self.hashTags = hashTags
        self.imgURL = imgURL
    }
}
