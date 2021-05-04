//
//  RoomType.swift
//  dabangTest
//
//  Created by choidam on 2021/05/03.
//

import Foundation

enum RoomType: Int, Codable, RawValueIterable {
    case oneRoom = 0
    case twoRoom = 1
    case officehotel = 2
    case apartment = 3
}

extension RoomType {
    var roomTypeName: String {
        switch self {
        case .oneRoom: return "원룸"
        case .twoRoom: return "투쓰리룸"
        case .officehotel: return "오피스텔"
        case .apartment: return "아파트"
        }
    }
}


protocol RawValueIterable: RawRepresentable, CaseIterable {
    static var allValues: [RawValue] { get }
    var value: RawValue { get }
}
               
extension RawValueIterable {
    static var allValues: [RawValue] {
        return allCases.map{ $0.rawValue }
    }
    
    var value: RawValue {
        return self.rawValue
    }
}
