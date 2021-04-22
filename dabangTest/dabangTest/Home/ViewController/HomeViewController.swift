//
//  ViewController.swift
//  dabangTest
//
//  Created by 최담 on 2021/04/15.
//

import UIKit
import RxSwift
import RxCocoa
import RxDataSources
import ReactorKit
import SnapKit
import Then

class HomeViewController: BaseViewController, View {
    
    // MARK: - UI
    let roomKindLabel = UILabel().then {
        $0.text = "방 종류"
        $0.font = UIFont.systemFont(ofSize: 14, weight: .bold)
        $0.textColor = .black
    }
    
    let oneRoomButton = UIButton().then {
        $0.setTitle("원룸", for: .normal)
        $0.tag = 0
        $0.isSelected = true
    }
    
    let twoRoomButton = UIButton().then {
        $0.setTitle("투쓰리룸", for: .normal)
        $0.tag = 1
        $0.isSelected = true
    }
    
    let officehotelButton = UIButton().then {
        $0.setTitle("오피스텔", for: .normal)
        $0.tag = 2
        $0.isSelected = true
    }
    
    let apartmentButton = UIButton().then {
        $0.setTitle("아파트", for: .normal)
        $0.tag = 3
        $0.isSelected = true
    }
    
    let saleKindLabel = UILabel().then {
        $0.text = "매물 종류"
        $0.font = UIFont.systemFont(ofSize: 14, weight: .bold)
        $0.textColor = .black
    }
    
    let monthlyRentButton = UIButton().then {
        $0.setTitle("월세", for: .normal)
        $0.tag = 0
        $0.isSelected = true
    }
    
    let leaseRentButton = UIButton().then {
        $0.setTitle("전세", for: .normal)
        $0.tag = 1
        $0.isSelected = true
    }
    
    let saleButton = UIButton().then {
        $0.setTitle("매매", for: .normal)
        $0.tag = 2
        $0.isSelected = true
    }
    
    let divideView = UIView().then {
        $0.backgroundColor = .verylightGray
    }
    
    let priceLabel = UILabel().then {
        $0.text = "가격"
        $0.font = UIFont.systemFont(ofSize: 14, weight: .bold)
        $0.textColor = .black
    }
    
    let sortPriceButton = UIButton().then {
        $0.isSelected = true
        $0.setTitle("오름차순", for: .normal)
    }
    
    let listTableView = UITableView().then {
        $0.allowsSelection = false
        $0.separatorStyle = .none
        $0.register(RoomCell.self, forCellReuseIdentifier: RoomCell.identifier)
        $0.register(AverageCell.self, forCellReuseIdentifier: AverageCell.identifier)
    }
    
    private static func dataSourceFactory() -> RxTableViewSectionedReloadDataSource<RoomSection> {
        return .init(configureCell: { dataSource, tableView, indexPath, sectionItem in
            switch sectionItem {
            case .average(let reactor):
                let cell = tableView.dequeueReusableCell(withIdentifier: AverageCell.identifier, for: indexPath) as! AverageCell
                cell.reactor = reactor
                return cell
            case .room(let reactor):
                let cell = tableView.dequeueReusableCell(withIdentifier: RoomCell.identifier, for: indexPath) as! RoomCell
                cell.reactor = reactor
                return cell
            }
        })
    }
    
    fileprivate var dataSource = HomeViewController.dataSourceFactory()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addView()
        initLayout()
    }
    
    func bind(reactor: HomeViewReactor) {
        bindState(reactor: reactor)
        bindAction(reactor: reactor)
    }
    
}

extension HomeViewController {
    
    private func addView(){
        view.addSubview(roomKindLabel)
        view.addSubview(oneRoomButton)
        view.addSubview(twoRoomButton)
        view.addSubview(officehotelButton)
        view.addSubview(apartmentButton)
        view.addSubview(saleKindLabel)
        view.addSubview(monthlyRentButton)
        view.addSubview(leaseRentButton)
        view.addSubview(saleButton)
        view.addSubview(divideView)
        view.addSubview(priceLabel)
        view.addSubview(sortPriceButton)
        view.addSubview(listTableView)
    }
    
    private func initLayout(){
        roomKindLabel.snp.makeConstraints {
            $0.leading.equalTo(16)
            $0.top.equalTo(view.safeAreaLayoutGuide.snp.topMargin).offset(10)
        }
        
        oneRoomButton.makeSelect()
        oneRoomButton.snp.makeConstraints{
            $0.leading.equalTo(15)
            $0.top.equalTo(roomKindLabel.snp.bottom).offset(10)
        }
        
        twoRoomButton.makeSelect()
        twoRoomButton.snp.makeConstraints{
            $0.centerY.equalTo(oneRoomButton.snp.centerY)
            $0.leading.equalTo(oneRoomButton.snp.trailing).offset(8)
        }
        
        officehotelButton.makeSelect()
        officehotelButton.snp.makeConstraints{
            $0.centerY.equalTo(oneRoomButton.snp.centerY)
            $0.leading.equalTo(twoRoomButton.snp.trailing).offset(8)
        }
        
        apartmentButton.makeSelect()
        apartmentButton.snp.makeConstraints{
            $0.centerY.equalTo(oneRoomButton.snp.centerY)
            $0.leading.equalTo(officehotelButton.snp.trailing).offset(8)
        }
        
        saleKindLabel.snp.makeConstraints{
            $0.leading.equalTo(16)
            $0.top.equalTo(oneRoomButton.snp.bottom).offset(14)
        }
        
        monthlyRentButton.makeSelect()
        monthlyRentButton.snp.makeConstraints{
            $0.leading.equalTo(16)
            $0.top.equalTo(saleKindLabel.snp.bottom).offset(10)
        }
        
        leaseRentButton.makeSelect()
        leaseRentButton.snp.makeConstraints{
            $0.centerY.equalTo(monthlyRentButton.snp.centerY)
            $0.leading.equalTo(monthlyRentButton.snp.trailing).offset(8)
        }
        
        saleButton.makeSelect()
        saleButton.snp.makeConstraints{
            $0.centerY.equalTo(monthlyRentButton.snp.centerY)
            $0.leading.equalTo(leaseRentButton.snp.trailing).offset(8)
        }
        
        priceLabel.snp.makeConstraints{
            $0.leading.equalTo(201)
            $0.centerY.equalTo(saleKindLabel.snp.centerY)
        }
        
        sortPriceButton.makeSelect()
        sortPriceButton.snp.makeConstraints{
            $0.leading.equalTo(201)
            $0.centerY.equalTo(monthlyRentButton.snp.centerY)
        }
        
        divideView.snp.makeConstraints{
            $0.leading.trailing.equalTo(0)
            $0.top.equalTo(monthlyRentButton.snp.bottom).offset(20)
            $0.height.equalTo(8)
        }
        
        listTableView.snp.makeConstraints{
            $0.leading.trailing.bottom.equalTo(0)
            $0.top.equalTo(divideView.snp.bottom)
        }
        
    }
    
    private func bindAction(reactor: HomeViewReactor){
        
        sortPriceButton.rx.tap
            .map { Reactor.Action.sort(isIncrease: !self.sortPriceButton.isSelected) }
            .do(onNext: { [weak self] _ in
                guard let self = self else { return }
                
                if self.sortPriceButton.isSelected {
                    self.sortPriceButton.isSelected = false
                    self.sortPriceButton.setTitle("내림차순", for: .normal)
                    self.sortPriceButton.makeSelect()
                } else {
                    self.sortPriceButton.isSelected = true
                    self.sortPriceButton.setTitle("오름차순", for: .normal)
                    self.sortPriceButton.makeSelect()
                }
                
                self.listTableView.scrollToRow(at: IndexPath(row: 0, section: 0), at: .top, animated: true)
            })
            .bind(to: reactor.action)
            .disposed(by: disposeBag)
        
        oneRoomButton.rx.tap
            .filter { !self.oneRoomButton.isSelected || reactor.currentState.roomTypeCount > 1 } // TODO: ㄲㄹ끔하게
            .map { Reactor.Action.selectRoom(selectIndex: self.oneRoomButton.tag, isSelect: !self.oneRoomButton.isSelected, isIncrease: self.sortPriceButton.isSelected)}
            .do(onNext: { [weak self] _ in
                guard let self = self else { return }
                
                self.oneRoomButton.isSelected = !self.oneRoomButton.isSelected
                self.oneRoomButton.makeSelect()
                
                self.listTableView.scrollToRow(at: IndexPath(row: 0, section: 0), at: .top, animated: true) // TODO:
            })
            .bind(to: reactor.action)
            .disposed(by: disposeBag)
        
        twoRoomButton.rx.tap
            .filter { !self.twoRoomButton.isSelected || reactor.currentState.roomTypeCount > 1 }
            .map { Reactor.Action.selectRoom(selectIndex: self.twoRoomButton.tag, isSelect: !self.twoRoomButton.isSelected, isIncrease: self.sortPriceButton.isSelected) }
            .do(onNext: { [weak self] _ in
                guard let self = self else { return }
                
                self.twoRoomButton.isSelected = !self.twoRoomButton.isSelected
                self.twoRoomButton.makeSelect()
                
                self.listTableView.scrollToRow(at: IndexPath(row: 0, section: 0), at: .top, animated: true)
            })
            .bind(to: reactor.action)
            .disposed(by: disposeBag)
        
        officehotelButton.rx.tap
            .filter { !self.officehotelButton.isSelected || reactor.currentState.roomTypeCount > 1 }
            .map { Reactor.Action.selectRoom(selectIndex: self.officehotelButton.tag, isSelect: !self.officehotelButton.isSelected, isIncrease: self.sortPriceButton.isSelected) }
            .do(onNext: { [weak self] _ in
                guard let self = self else { return }
                
                self.officehotelButton.isSelected = !self.officehotelButton.isSelected
                self.officehotelButton.makeSelect()
                
                self.listTableView.scrollToRow(at: IndexPath(row: 0, section: 0), at: .top, animated: true)
            })
            .bind(to: reactor.action)
            .disposed(by: disposeBag)
        
        apartmentButton.rx.tap
            .filter { !self.apartmentButton.isSelected || reactor.currentState.roomTypeCount > 1 }
            .map { Reactor.Action.selectRoom(selectIndex: self.apartmentButton.tag, isSelect: !self.apartmentButton.isSelected, isIncrease: self.sortPriceButton.isSelected) }
            .do(onNext: { [weak self] _ in
                guard let self = self else { return }
                
                self.apartmentButton.isSelected = !self.apartmentButton.isSelected
                self.apartmentButton.makeSelect()
                
                self.listTableView.scrollToRow(at: IndexPath(row: 0, section: 0), at: .top, animated: true)
            })
            .bind(to: reactor.action)
            .disposed(by: disposeBag)
        
        
        monthlyRentButton.rx.tap
            .filter { !self.monthlyRentButton.isSelected || reactor.currentState.saleTypeCount > 1 }
            .map { Reactor.Action.selectSale(selectIndex: self.monthlyRentButton.tag, isSelect: !self.monthlyRentButton.isSelected, isIncrease: self.sortPriceButton.isSelected) }
            .do(onNext: { [weak self] _ in
                guard let self = self else { return }
                
                self.monthlyRentButton.isSelected = !self.monthlyRentButton.isSelected
                self.monthlyRentButton.makeSelect()
                
                self.listTableView.scrollToRow(at: IndexPath(row: 0, section: 0), at: .top, animated: true)
            })
            .bind(to: reactor.action)
            .disposed(by: disposeBag)
        
        leaseRentButton.rx.tap
            .filter { !self.leaseRentButton.isSelected || reactor.currentState.saleTypeCount > 1 }
            .map { Reactor.Action.selectSale(selectIndex: self.leaseRentButton.tag, isSelect: !self.leaseRentButton.isSelected, isIncrease: self.sortPriceButton.isSelected) }
            .do(onNext: { [weak self] _ in
                guard let self = self else { return }
                
                self.leaseRentButton.isSelected = !self.leaseRentButton.isSelected
                self.leaseRentButton.makeSelect()
                
                self.listTableView.scrollToRow(at: IndexPath(row: 0, section: 0), at: .top, animated: true)
            })
            .bind(to: reactor.action)
            .disposed(by: disposeBag)
        
        saleButton.rx.tap
            .filter { !self.saleButton.isSelected || reactor.currentState.saleTypeCount > 1 }
            .map { Reactor.Action.selectSale(selectIndex: self.saleButton.tag, isSelect: !self.saleButton.isSelected, isIncrease: self.sortPriceButton.isSelected) }
            .do(onNext: { [weak self] _ in
                guard let self = self else { return }
                
                self.saleButton.isSelected = !self.saleButton.isSelected
                self.saleButton.makeSelect()
                
                self.listTableView.scrollToRow(at: IndexPath(row: 0, section: 0), at: .top, animated: true)
            })
            .bind(to: reactor.action)
            .disposed(by: disposeBag)
        
        listTableView.rx.isReachedBottom
            .observe(on: MainScheduler.asyncInstance)
            .map { Reactor.Action.loadMore }
            .bind(to: reactor.action)
            .disposed(by: disposeBag)
                
    }
    
    private func bindState(reactor: HomeViewReactor){
        
        reactor.state
            .map{ $0.sections }
            .bind(to: listTableView.rx.items(dataSource: dataSource))
            .disposed(by: disposeBag)
        
        reactor.state
            .filter { $0.state == .errorMsg }
            .map { $0.errorMsg }
            .subscribe(onNext: { _ in
                print("error~~~")
            })
            .disposed(by: disposeBag)
        
    }
}


