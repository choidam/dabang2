//
//  ApartmentCell.swift
//  dabangTest
//
//  Created by choidam on 2021/04/23.
//

import UIKit
import RxSwift
import RxCocoa
import RxDataSources
import SnapKit
import Then

class ApartmentCell: BaseTableViewCell<ApartmentCellReactor> {
    static let identifier = "apartmentCell"
    
    // MARK:- UI
    let leftView = UIView()
    
    let rightView = UIView()
    
    let roomImageView = UIImageView().then {
        $0.backgroundColor = .gray
        $0.layer.cornerRadius = 5
    }
    
    let selectImageView = UIImageView().then {
        $0.image = UIImage(named: "star2")
    }
    
    let titleLabel = UILabel().then {
        $0.textColor = .black
        $0.font = UIFont.systemFont(ofSize: 18, weight: .bold)
    }
    
    let roomTypeLabel = UILabel().then {
        $0.textColor = .black
        $0.font = UIFont.systemFont(ofSize: 13)
    }
    
    let descriptionLabel = UILabel().then {
        $0.textColor = .lightGray
        $0.font = UIFont.systemFont(ofSize: 13)
    }
    
    let tagStackView = UIStackView().then {
        $0.axis = .horizontal
        $0.alignment = .leading
        $0.distribution = .fillProportionally
        $0.spacing = 4
    }
    
    let divideView = UIView().then {
        $0.backgroundColor = .verylightGray
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        addView()
        initLayout()
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func bind(reactor: ApartmentCellReactor) {
        bindState(reactor: reactor)
        bindAction(reactor: reactor)
    }
    
}

extension ApartmentCell {
    private func addView(){
        contentView.addSubview(leftView)
        leftView.addSubview(roomImageView)
        leftView.addSubview(selectImageView)
        
        contentView.addSubview(rightView)
        rightView.addSubview(titleLabel)
        rightView.addSubview(roomTypeLabel)
        rightView.addSubview(descriptionLabel)
        
        rightView.addSubview(tagStackView)
        
        contentView.addSubview(divideView)
    }
    
    private func initLayout(){
        leftView.snp.makeConstraints{
            $0.leading.top.bottom.equalToSuperview()
            $0.width.equalTo(173)
            $0.height.equalTo(113)
        }
        
        roomImageView.snp.makeConstraints{
            $0.leading.equalTo(leftView.snp.leading).offset(13)
            $0.top.equalTo(leftView.snp.top).offset(14)
            $0.width.equalTo(126)
            $0.height.equalTo(84)
        }
        
        selectImageView.snp.makeConstraints{
            $0.width.height.equalTo(18)
            $0.top.equalTo(roomImageView.snp.top).offset(4)
            $0.leading.equalTo(roomImageView.snp.leading).offset(4)
        }
        
        rightView.snp.makeConstraints{
            $0.leading.equalTo(leftView.snp.trailing)
            $0.top.bottom.trailing.equalToSuperview()
        }
        
        titleLabel.snp.makeConstraints{
            $0.leading.equalTo(rightView.snp.leading)
            $0.top.equalTo(rightView.snp.top).offset(18)
        }
        
        roomTypeLabel.snp.makeConstraints{
            $0.leading.equalTo(rightView.snp.leading)
            $0.top.equalTo(titleLabel.snp.bottom).offset(4)
        }
        
        descriptionLabel.snp.makeConstraints{
            $0.leading.equalTo(rightView.snp.leading)
            $0.top.equalTo(roomTypeLabel.snp.bottom)
            $0.trailing.equalTo(rightView.snp.trailing).offset(-10)
        }
        
        tagStackView.snp.makeConstraints {
            $0.top.equalTo(descriptionLabel.snp.bottom).offset(4)
            $0.leading.equalTo(rightView.snp.leading)
            $0.trailing.lessThanOrEqualTo(rightView.snp.trailing).offset(-24)
            $0.height.equalTo(24)
        }
        
        divideView.snp.makeConstraints{
            $0.leading.trailing.bottom.equalTo(0)
            $0.height.equalTo(1)
        }
    }
        
    private func bindState(reactor: ApartmentCellReactor){
        
        reactor.state
            .map { ($0.sellingType.sellingTypeName, $0.priceTitle) }
            .subscribe(onNext: { [weak self] (selling, price) in
                guard let self = self else { return }
                
                self.titleLabel.text = "\(selling) \(price)"
            })
            .disposed(by: disposeBag)
        
        reactor.state
            .map { $0.roomType.roomTypeName }
            .bind(to: roomTypeLabel.rx.text)
            .disposed(by: disposeBag)
        
        reactor.state
            .map { $0.desc }
            .bind(to: descriptionLabel.rx.text)
            .disposed(by: disposeBag)
        
        reactor.state
            .map { $0.isCheck }
            .filter{ $0 == true }
            .subscribe(onNext: { [weak self] _ in
                self?.selectImageView.image = UIImage(named: "star1")
            })
            .disposed(by: disposeBag)
            
        reactor.state
            .map { $0.hashTags }
            .subscribe(onNext: { [weak self] tags in
                guard let self = self else { return }
                
                self.tagStackView.removeAllArrangedSubviews()
                
                var maxCount = 0
                for tag in tags {
                    maxCount += 1
                    let tagButton = UIButton().then {
                        $0.setTitle(tag, for: .normal)
                        $0.makeHashTag()
                    }
                    self.tagStackView.addArrangedSubview(tagButton)
                    
                    if maxCount == 4 { break }
                }
            })
            .disposed(by: disposeBag)

    }
    
    private func bindAction(reactor: ApartmentCellReactor){
        
    }
}

