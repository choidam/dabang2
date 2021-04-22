//
//  UIButton+Extensions.swift
//  dabangTest
//
//  Created by 최담 on 2021/04/15.
//

import UIKit

extension UIButton {
    
    func makeSelect(){
        if self.isSelected {
            self.backgroundColor = .dustyBlue
            self.setTitleColor(.white, for: .normal)
            self.titleLabel?.font = UIFont.systemFont(ofSize: 14)
            self.contentEdgeInsets = UIEdgeInsets(top: 11, left: 9, bottom: 11, right: 9)
            self.layer.cornerRadius = 4
        } else {
            self.backgroundColor = .white
            self.titleLabel?.font = UIFont.systemFont(ofSize: 14)
            self.setTitleColor(.verydarkGray, for: .normal)
            self.layer.borderWidth = 1
            self.layer.borderColor = UIColor.lightGray.cgColor
            self.layer.cornerRadius = 4
            self.contentEdgeInsets = UIEdgeInsets(top: 11, left: 9, bottom: 11, right: 9)
        }
    }
    
    func makeSelectButton(){
        self.backgroundColor = .dustyBlue
        self.setTitleColor(.white, for: .normal)
        self.titleLabel?.font = UIFont.systemFont(ofSize: 14)
        self.contentEdgeInsets = UIEdgeInsets(top: 11, left: 9, bottom: 11, right: 9)
        self.layer.cornerRadius = 4
    }
    
    func makeDeselectButton() {
        self.backgroundColor = .white
        self.titleLabel?.font = UIFont.systemFont(ofSize: 14)
        self.setTitleColor(.verydarkGray, for: .normal)
        self.layer.borderWidth = 1
        self.layer.borderColor = UIColor.lightGray.cgColor
        self.layer.cornerRadius = 4
        self.contentEdgeInsets = UIEdgeInsets(top: 11, left: 9, bottom: 11, right: 9)
    }
    
    func makeHashTag() {
        self.backgroundColor = .verylightGray
        self.setTitleColor(.darkGray, for: .normal)
        self.titleLabel?.font = UIFont.systemFont(ofSize: 11)
        self.layer.cornerRadius = 2
        self.isUserInteractionEnabled = false
        self.contentEdgeInsets = UIEdgeInsets(top: 5, left: 5, bottom: 5, right: 5)
    }
    
}
