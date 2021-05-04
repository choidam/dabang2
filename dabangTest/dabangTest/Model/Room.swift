//
//  Room.swift
//  dabangTest
//
//  Created by 최담 on 2021/04/15.
//

import Foundation

// MARK: - RoomResponseModel
struct RoomResponseModel: Codable {
    let average: [Average]
    let rooms: [Room]
}

// MARK: - Average
struct Average: Codable {
    let monthPrice, name, yearPrice: String
}

// MARK: - Room
struct Room: Codable {
    let identity = UUID().uuidString
    
    let desc: String
    let isCheck: Bool
    let priceTitle: String
    let price: Int
    let roomType: Int
    let sellingType: Int
    let roomTypeStr: RoomType
    let sellingTypeStr: SellingType
    let hashTags: [String]
    let imgURL: String

    enum CodingKeys: String, CodingKey {
        case desc
        case isCheck = "is_check"
        case priceTitle = "price_title"
        case roomType = "room_type"
        case sellingType = "selling_type"
        case hashTags = "hash_tags"
        case imgURL = "img_url"
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        desc = try container.decode(String.self, forKey: .desc)
        isCheck = try container.decode(Bool.self, forKey: .isCheck)
        priceTitle = try container.decode(String.self, forKey: .priceTitle)
        
        var tmp = ""
        var tmpPrice = 0
        for ch in priceTitle {
            if ch.isNumber == true {
                tmp.append(ch)
            } else {
                if ch == "억" {
                    tmpPrice += Int(tmp)!*10000
                    tmp = ""
                } else if ch == "천" {
                    tmpPrice += Int(tmp)!*1000
                    continue
                } else if ch == "만" {
                    tmpPrice += Int(tmp)!
                    continue
                }
            }
        }
        price = tmpPrice
        
        roomType = try container.decode(Int.self, forKey: .roomType)
        sellingType = try container.decode(Int.self, forKey: .sellingType)
        
        roomTypeStr = RoomType(rawValue: roomType)!
        sellingTypeStr = SellingType(rawValue: sellingType)!
        
        hashTags = try container.decode([String].self, forKey: .hashTags)
        imgURL = try container.decode(String.self, forKey: .imgURL)
    }
    
}



