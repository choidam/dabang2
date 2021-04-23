//
//  AverageCell.swift
//  dabangTest
//
//  Created by choidam on 2021/04/16.
//

import UIKit
import ReactorKit
import SnapKit
import Then

class AverageCell: BaseTableViewCell<AverageCellReactor> {
    static let identifier = "averageCell"
    
    // MARK: - UI
    let averageSaleLabel = UILabel().then {
        $0.text = "평균 매물가"
        $0.textColor = .black
        $0.font = UIFont.systemFont(ofSize: 12, weight: .bold)
    }
    
    let addressLabel = UILabel().then {
        $0.textColor = .lightGray
        $0.font = UIFont.systemFont(ofSize: 12, weight: .bold)
    }
    
    let averageMonthLabel = UILabel().then {
        $0.text = "평균 월세"
        $0.textColor = .black
        $0.font = UIFont.systemFont(ofSize: 11)
    }
    
    let averageMonthPriceLabel = UILabel().then {
        $0.textColor = .dustyBlue
        $0.font = UIFont.systemFont(ofSize: 16, weight: .bold)
    }
    
    let divideView = UIView().then {
        $0.backgroundColor = .lightGray
    }
    
    let averageLeaseRentLabel = UILabel().then {
        $0.text = "평균 전세"
        $0.textColor = .black
        $0.font = UIFont.systemFont(ofSize: 11)
    }
    
    let averageLeaseRentPriceLabel = UILabel().then {
        $0.textColor = .dustyOrange
        $0.font = UIFont.systemFont(ofSize: 16, weight: .bold)
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        addView()
        initLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func bind(reactor: AverageCellReactor) {
        bindState(reactor: reactor)
        bindAction(reactor: reactor)
    }
}

extension AverageCell {
    private func addView(){
        contentView.backgroundColor = .verylightBlue
        
        contentView.addSubview(averageSaleLabel)
        contentView.addSubview(addressLabel)
        contentView.addSubview(averageMonthLabel)
        contentView.addSubview(averageMonthPriceLabel)
        contentView.addSubview(divideView)
        contentView.addSubview(averageLeaseRentLabel)
        contentView.addSubview(averageLeaseRentPriceLabel)
    }
    
    private func initLayout(){
        averageSaleLabel.snp.makeConstraints{
            $0.leading.equalTo(15)
            $0.top.equalTo(10)
            $0.bottom.equalTo(-53)
        }
        
        addressLabel.snp.makeConstraints{
            $0.centerY.equalTo(averageSaleLabel.snp.centerY)
            $0.leading.equalTo(averageSaleLabel.snp.trailing).offset(13)
        }
        
        averageMonthLabel.snp.makeConstraints{
            $0.leading.equalTo(17)
            $0.top.equalTo(averageSaleLabel.snp.bottom).offset(9)
        }
        
        averageMonthPriceLabel.snp.makeConstraints{
            $0.leading.equalTo(15)
            $0.top.equalTo(averageMonthLabel.snp.bottom)
        }
        
        divideView.snp.makeConstraints{
            $0.top.equalTo(34)
            $0.bottom.equalTo(-16)
            $0.width.equalTo(1)
            $0.leading.equalTo(100)
        }
        
        averageLeaseRentLabel.snp.makeConstraints{
            $0.centerY.equalTo(averageMonthLabel.snp.centerY)
            $0.leading.equalTo(divideView.snp.trailing).offset(13)
        }
        
        averageLeaseRentPriceLabel.snp.makeConstraints{
            $0.centerY.equalTo(averageMonthPriceLabel.snp.centerY)
            $0.leading.equalTo(divideView.snp.trailing).offset(13)
        }
        
    }
    
    private func bindState(reactor: AverageCellReactor){
        
        reactor.state
            .map { $0.average }
            .subscribe(onNext: { [weak self] average in
                guard let self = self else { return }
                
                self.addressLabel.text = average.name
                self.averageMonthPriceLabel.text = average.monthPrice
                self.averageLeaseRentPriceLabel.text = average.yearPrice
            })
            .disposed(by: disposeBag)
        
    }
    
    private func bindAction(reactor: AverageCellReactor){
        
    }
    
}
