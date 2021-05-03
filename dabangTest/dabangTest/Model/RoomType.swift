//
//  RoomType.swift
//  dabangTest
//
//  Created by choidam on 2021/05/03.
//

import Foundation

enum RoomType: Int, Codable, CaseIterable {
    case oneRoom
    case twoRoom
    case officehotel
    case apartment
    
    var roomType: String {
        switch self {
        case .oneRoom: return "원룸"
        case .twoRoom: return "투쓰리룸"
        case .officehotel: return "오피스텔"
        case .apartment: return "아파트"
        }
    }
    
    init?(value: Int?) {
        guard value != nil else { return nil }
        
        switch value! {
        case 0: self = .oneRoom
        case 1: self = .twoRoom
        case 2: self = .officehotel
        case 3: self = .apartment
        default: return nil
        }
    }
    
    static var roomTypes: [RoomType] {
        return [.oneRoom, .twoRoom, .officehotel, .apartment]
    }
}
