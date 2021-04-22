//
//  BaseTableViewCell.swift
//  dabangTest
//
//  Created by choidam on 2021/04/19.
//

import UIKit
import RxSwift
import RxCocoa
import ReactorKit

class BaseTableViewCell<R: Reactor>: UITableViewCell, ReactorKit.View {
    
    typealias Reactor = R
    
    var disposeBag = DisposeBag()
    
    override class func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func bind(reactor: R) { }
}
