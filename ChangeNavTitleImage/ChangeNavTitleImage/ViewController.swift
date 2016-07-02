//
//  ViewController.swift
//  ChangeNavTitleImage
//
//  Created by Mr.Guo on 16/7/2.
//  Copyright © 2016年 XianZhuangGuo. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    let ID : String = "cell"
    
    var imageV : UIImageView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(tableView)
        
        navigationController?.navigationBar.barTintColor = UIColor.redColor()
        
        let titleV : UIView = UIView()
        navigationItem.titleView = titleV
        
        imageV = UIImageView(frame: CGRectMake(0, 0, 70, 70))
        imageV?.image = UIImage(named: "100.jpg")
        imageV?.layer.cornerRadius = 35
        imageV?.layer.masksToBounds = true
        imageV?.center = CGPointMake(titleV.center.x, 0)
        titleV.addSubview(imageV!)
        
        tableView.registerClass(UITableViewCell.self, forCellReuseIdentifier: ID)
        
    }
    
    
    
    // MARK: - Getter
    private lazy var tableView: UITableView = {
        let tableView = UITableView(frame: self.view.bounds)
        tableView.dataSource = self
        tableView.delegate   = self
        return tableView
    }()
    
}


extension ViewController : UITableViewDataSource,UITableViewDelegate {
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return 30
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell
    {
        let cell = tableView.dequeueReusableCellWithIdentifier(ID, forIndexPath: indexPath)
        cell.textLabel?.text = "骚客--\(indexPath.row):http://coderperson.com"
        return cell
    }
    
    func scrollViewDidScroll(scrollView: UIScrollView) {
        
        // 偏移量，相对于contentView，你也可以不加scrollView.contentInset.top，即相对scrollView，然后适当调整即可
        let offsetY = scrollView.contentOffset.y + scrollView.contentInset.top
        var scale:CGFloat = 1.0
        if offsetY < 0  // 下拉
        {
            scale = min(1.5, 1.0 - offsetY / 300.0) // 300值可以自己调整
        } else if offsetY > 0
        {
            // 为了防止缩小过度，给一个最小值为0.45，其中0.45 = 31.5 / 70.0，表示
            // 头像最小是31.5像素
            scale = max(0.45, 1 - offsetY / 300);
        }
        // 保证缩放后y的坐标不会改变
        imageV?.transform = CGAffineTransformMakeScale(scale, scale)
        var frame = imageV?.frame
        frame?.origin.y = -(imageV?.layer.cornerRadius)! / 2.0
        imageV?.frame = frame!
        
        // 导航栏颜色渐变
        changeNavColor(offsetY)
        
    }
    
    // change Color
    private func changeNavColor(offsetY:CGFloat) {
        
        if offsetY >= 0
        {
            self.navigationController?.navigationBar.alpha = 1.0
        }
        else if offsetY < 0
        {
            self.navigationController?.navigationBar.alpha = 1.0 - -offsetY / 300.0
        }
        
    }
    
}