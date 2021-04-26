//
//  AverageModel.swift
//  dabangTest
//
//  Created by choidam on 2021/04/20.
//

import Foundation
import RxDataSources

struct AverageModel: Equatable, IdentifiableType {
    let identity = UUID()
    
    var monthPrice: String
    var name: String
    var yearPrice: String
    
    init(monthPrice: String, name: String, yearPrice: String) {
        self.monthPrice = monthPrice
        self.name = name
        self.yearPrice = yearPrice
    }
}
