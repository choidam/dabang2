//
//  BaseViewController.swift
//  dabangTest
//
//  Created by 최담 on 2021/04/15.
//

import UIKit
import RxSwift
import RxCocoa
import ReactorKit

class BaseViewController: UIViewController {
    
    var disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
    }
    
}
