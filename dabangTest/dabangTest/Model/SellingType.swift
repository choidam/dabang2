//
//  SellingType.swift
//  dabangTest
//
//  Created by choidam on 2021/05/03.
//

import Foundation

enum SellingType: Int, Codable, RawValueIterable {
    case monthlyRent = 0
    case leaseRent = 1
    case sale = 2
}

extension SellingType {
    
    var sellingTypeName: String {
        switch self {
        case .monthlyRent: return "월세"
        case .leaseRent: return "전세"
        case .sale: return "매매"
        }
    }
    
}
