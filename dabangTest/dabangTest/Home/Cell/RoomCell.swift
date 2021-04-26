//
//  RoomCell.swift
//  dabangTest
//
//  Created by 최담 on 2021/04/15.
//

import UIKit
import RxSwift
import RxCocoa
import RxDataSources
import SnapKit
import Then

class RoomCell: BaseTableViewCell<RoomCellReactor> {
    static let identifier = "roomCell"
    
    // MARK:- UI
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
    
    let roomImageView = UIImageView().then {
        $0.backgroundColor = .gray
        $0.layer.cornerRadius = 5
    }
    
    let divideView = UIView().then {
        $0.backgroundColor = .verylightGray
    }
    
    let tag1 = UIButton().then {
        $0.setTitle("tag1", for: .normal)
    }
    
    let tag2 = UIButton().then {
        $0.setTitle("tag2", for: .normal)
    }
    
    let tag3 = UIButton().then {
        $0.setTitle("tag3", for: .normal)
    }
    
    let tag4 = UIButton().then {
        $0.setTitle("tag4", for: .normal)
    }
    
    let selectImageView = UIImageView().then {
        $0.image = UIImage(named: "star2")
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        addView()
        initLayout()
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func bind(reactor: RoomCellReactor) {
        bindState(reactor: reactor)
        bindAction(reactor: reactor)
    }
    
}

extension RoomCell {
    private func addView(){
        contentView.addSubview(titleLabel)
        contentView.addSubview(roomTypeLabel)
        contentView.addSubview(descriptionLabel)
        contentView.addSubview(roomImageView)
        contentView.addSubview(tag1)
        contentView.addSubview(tag2)
        contentView.addSubview(tag3)
        contentView.addSubview(tag4)
        contentView.addSubview(divideView)
        contentView.addSubview(selectImageView)
    }
    
    private func initLayout(){
        titleLabel.snp.makeConstraints{
            $0.leading.equalTo(15)
            $0.top.equalTo(22)
            $0.bottom.equalTo(-77)
        }
        
        roomTypeLabel.snp.makeConstraints{
            $0.leading.equalTo(16)
            $0.top.equalTo(titleLabel.snp.bottom).offset(3)
        }
        
        roomImageView.snp.makeConstraints{
            $0.trailing.equalTo(-16)
            $0.top.equalTo(16)
            $0.width.equalTo(126)
            $0.height.equalTo(84)
        }
        
        descriptionLabel.snp.makeConstraints{
            $0.leading.equalTo(16)
            $0.top.equalTo(roomTypeLabel.snp.bottom)
            $0.trailing.equalTo(roomImageView.snp.leading).offset(-10)
        }
        
        tag1.makeHashTag()
        tag1.snp.makeConstraints{
            $0.leading.equalTo(15)
            $0.top.equalTo(descriptionLabel.snp.bottom).offset(5)
        }
        
        tag2.makeHashTag()
        tag2.snp.makeConstraints{
            $0.centerY.equalTo(tag1.snp.centerY)
            $0.leading.equalTo(tag1.snp.trailing).offset(4)
        }
        
        tag3.makeHashTag()
        tag3.snp.makeConstraints{
            $0.centerY.equalTo(tag1.snp.centerY)
            $0.leading.equalTo(tag2.snp.trailing).offset(4)
        }
        
        tag4.makeHashTag()
        tag4.snp.makeConstraints{
            $0.centerY.equalTo(tag1.snp.centerY)
            $0.leading.equalTo(tag3.snp.trailing).offset(4)
        }
        
        divideView.snp.makeConstraints{
            $0.leading.trailing.bottom.equalTo(0)
            $0.height.equalTo(1)
        }
        
        selectImageView.snp.makeConstraints{
            $0.width.height.equalTo(18)
            $0.top.equalTo(22)
            $0.trailing.equalTo(-21)
        }
        
    }
        
    private func bindState(reactor: RoomCellReactor){
        
        reactor.state
            .map { $0.room }
            .subscribe(onNext: { [weak self] room in
                guard let self = self else { return }
                
                switch room.roomType {
                case 0:
                    self.roomTypeLabel.text = "원룸"
                case 1:
                    self.roomTypeLabel.text = "투쓰리룸"
                case 2:
                    self.roomTypeLabel.text = "오피스텔"
                case 3:
                    self.roomTypeLabel.text = "아파트"
                default:
                    break
                }

                self.titleLabel.text = room.priceTitle
                
                self.descriptionLabel.text = room.desc
                
                // TODO: 태그 수정
                switch room.hashTags.count {
                case 0:
                    self.tag1.isHidden = true
                    self.tag2.isHidden = true
                    self.tag3.isHidden = true
                    self.tag4.isHidden = true
                case 1:
                    self.tag1.setTitle(room.hashTags[0], for: .normal)
                    self.tag2.isHidden = true
                    self.tag3.isHidden = true
                    self.tag4.isHidden = true
                case 2:
                    self.tag1.setTitle(room.hashTags[0], for: .normal)
                    self.tag2.setTitle(room.hashTags[1], for: .normal)
                    self.tag3.isHidden = true
                    self.tag4.isHidden = true
                case 3:
                    self.tag1.setTitle(room.hashTags[0], for: .normal)
                    self.tag2.setTitle(room.hashTags[1], for: .normal)
                    self.tag3.setTitle(room.hashTags[2], for: .normal)
                    self.tag4.isHidden = true
                default:
                    self.tag1.setTitle(room.hashTags[0], for: .normal)
                    self.tag2.setTitle(room.hashTags[1], for: .normal)
                    self.tag3.setTitle(room.hashTags[2], for: .normal)
                    self.tag4.setTitle(room.hashTags[3], for: .normal)
                }
                
                if room.isCheck {
                    self.selectImageView.image = UIImage(named: "star1")
                }
                
            })
            .disposed(by: disposeBag)
    }
    
    private func bindAction(reactor: RoomCellReactor){
        
    }
}
