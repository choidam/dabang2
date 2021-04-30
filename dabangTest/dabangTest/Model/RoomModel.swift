//
//  RoomModel.swift
//  dabangTest
//
//  Created by choidam on 2021/04/20.
//

import Foundation

// MARK: - RoomModel
struct RoomModel {
    let identity = UUID().uuidString
    
    var desc: String
    var isCheck: Bool
    var priceTitle: String
    var price: Int
    
    var roomTypeInt: Int
    var roomType: RoomType {
        switch self.roomTypeInt {
        case 0:
            return .oneRoom
        case 1:
            return .twoRoom
        case 2:
            return .officehotel
        default:
            return .apartment
        }
    }
    var roomTypeStr: String {
        switch self.roomType {
        case .oneRoom:
            return "원룸"
        case .twoRoom:
            return "투쓰리룸"
        case .officehotel:
            return "오피스텔"
        case .apartment:
            return "아파트"
        }
    }
    
    var sellingTypeInt: Int
    var sellingType: SellingType {
        switch sellingTypeInt {
        case 0:
            return .monthlyRent
        case 1:
            return .leaseRent
        default:
            return .sale
        }
    }
    
    var sellingTypeStr: String {
        switch self.sellingType {
        case .monthlyRent:
            return "월세"
        case .leaseRent:
            return "전세"
        default:
            return "매매"
        }
    }
    
    var hashTags: [String]
    var imgURL: String
    
    init(desc: String, isCheck: Bool, priceTitle: String, price: Int, roomTypeInt: Int, sellingTypeInt: Int, hashTags: [String], imgURL: String) {
        self.desc = desc
        self.isCheck = isCheck
        self.priceTitle = priceTitle
        self.price = price
        self.roomTypeInt = roomTypeInt
        self.sellingTypeInt = sellingTypeInt
        self.hashTags = hashTags
        self.imgURL = imgURL
    }
}

enum RoomType {
    case oneRoom
    case twoRoom
    case officehotel
    case apartment
}

enum SellingType {
    case monthlyRent
    case leaseRent
    case sale
}
