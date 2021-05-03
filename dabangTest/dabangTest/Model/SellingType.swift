//
//  SellingType.swift
//  dabangTest
//
//  Created by choidam on 2021/05/03.
//

import Foundation

enum SellingType: Int, Codable, CaseIterable {
    case monthlyRent
    case leaseRent
    case sale
    
    var sellingType: String {
        switch self {
        case .monthlyRent: return "월세"
        case .leaseRent: return "전세"
        case .sale: return "매매"
        }
    }
    
    init?(value: Int?) {
        guard value != nil else { return nil }
        
        switch value! {
        case 0: self = .monthlyRent
        case 1: self = .leaseRent
        case 2: self = .sale
        default: return nil
        }
    }
    
    static var sellingTypes: [SellingType] {
        return [.monthlyRent, .leaseRent, .sale]
    }
    
}
