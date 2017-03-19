//
//  FoodListViewController.swift
//  ApplicationCoordinatorSample
//
//  Created by Hiasa, Takahiro on 2017/03/19.
//  Copyright © 2017年 takahia. All rights reserved.
//

import UIKit

protocol FoodListTransition: Presentable {
    var onCellTap:((_ url: URL) -> Void)? { get set }
}

class FoodListViewController: UIViewController, FoodListTransition {
    
    //MARK: Transition
    var onCellTap:((_ url: URL) -> Void)?
    
    //MARK: Property
    @IBOutlet private weak var tableView: UITableView!
    
    private(set) var foodList = [FoodDto]()
    
    //MARK: Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()

        self.title = "お店リスト"
        
        self.tableView.dataSource = self
        self.tableView.delegate = self
        self.tableView.backgroundColor = UIColor.lightGray
        self.tableView.estimatedRowHeight = 100
        self.tableView.rowHeight = UITableViewAutomaticDimension
        
        let rect = CGRect(x: 0, y: 0, width: self.view.frame.width, height: 0.1)
        self.tableView.tableFooterView = UIView(frame: rect)
        
        self.setFoodData()
        self.setAutolayout()
    }
    
    //MARK: private method
    private func setAutolayout() {
        var constraints = [NSLayoutConstraint]()
        let attributes:[NSLayoutAttribute] = [.top, .left, .bottom, .right]
        for attribute in attributes {
            let constraint = NSLayoutConstraint(item: self.view,
                                                attribute: attribute,
                                                relatedBy: .equal,
                                                toItem: self.tableView,
                                                attribute: attribute,
                                                multiplier: 1,
                                                constant: 0)
            constraints.append(constraint)
        }
        self.view.addConstraints(constraints)
        
        let nibName = String(describing: FoodListTableViewCell.self)
        let cellNib = UINib(nibName: nibName, bundle: nil)
        self.tableView.register(cellNib, forCellReuseIdentifier: nibName)
    }
    
    private func setFoodData() {
        
        self.foodList.append(FoodDto(imageName: "food1",
                                     name: "麺屋Hulu-lu",
                                     descriptionText: "ハワイアンカフェのような新しいラーメン屋さん★",
                                     url: URL(string: "https://dining.rakuten.co.jp/store/2000008148/")!))

        self.foodList.append(FoodDto(imageName: "food2",
                                     name: "ラーメン味噌屋燦",
                                     descriptionText: "本格的味噌ラーメン店が堀切菖蒲園駅前にOPEN！",
                                     url: URL(string: "https://dining.rakuten.co.jp/store/2000028261/")!))
    }
    
}

//MARK: UITableViewDataSource
extension FoodListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int)
        -> Int {
            return self.foodList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath)
        -> UITableViewCell {
            
            let foodDto = self.foodList[indexPath.row]
            let nibName = String(describing: FoodListTableViewCell.self)
            let cell = tableView.dequeueReusableCell(withIdentifier: nibName, for: indexPath) as! FoodListTableViewCell
            cell.foodImageView.image = UIImage(named: foodDto.imageName)
            cell.nameLabel.text = foodDto.name
            cell.descriptionLabel.text = foodDto.descriptionText
            return cell
    }
}

//MARK: UITableViewDelegate
extension FoodListViewController: UITableViewDelegate {

    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath)
        -> CGFloat {
        return UITableViewAutomaticDimension
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let foodDto = self.foodList[indexPath.row]
        self.onCellTap?(foodDto.url)
    }
}
