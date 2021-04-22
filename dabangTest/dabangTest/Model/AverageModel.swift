//
//  AverageModel.swift
//  dabangTest
//
//  Created by choidam on 2021/04/20.
//

import Foundation
import RxDataSources

struct AverageModel: Equatable, IdentifiableType {
    var identity: String
    
    var monthPrice: String
    var name: String
    var yearPrice: String
    
    init(monthPrice: String, name: String, yearPrice: String) {
        self.identity = ""
        self.monthPrice = monthPrice
        self.name = name
        self.yearPrice = yearPrice
    }
}
