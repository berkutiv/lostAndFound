//
//  MapTableView.swift
//  LostAndFound
//
//  Created by Иван on 19.04.17.
//  Copyright © 2017 Иван. All rights reserved.
//

import UIKit
import AVFoundation

class MapTableView: UIView, UIGestureRecognizerDelegate
{
    var dataSource = NSMutableArray()
    var blockWithCoordinates: ((String, String) -> Void)!
    var blockWithAlpha: ((CGFloat) -> Void)!
    var headerView: UIView?
    
    @IBOutlet weak var tableView: UITableView!
    
    let kItemTableNIB = UINib(nibName: "ItemTableViewCell", bundle: nil)
    let kItemTableViewCellReuseIdentifier = "kItemTableViewCellReuseIdentifier"
    
    override func awakeFromNib()
    {
        tableView.isScrollEnabled = false
        tableView.dataSource = self
        tableView.delegate = self
        tableView.estimatedRowHeight = 50
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedSectionHeaderHeight = 50
        tableView.sectionHeaderHeight = UITableViewAutomaticDimension
        tableView.register(kItemTableNIB, forCellReuseIdentifier: kItemTableViewCellReuseIdentifier)
        
        dataSource = ModelsFactory.generateModels() as! NSMutableArray
        
        let panRec = UIPanGestureRecognizer(target: self, action: #selector(MapTableView.handlePan(rec:)))
        panRec.delegate = self
        self.addGestureRecognizer(panRec)
        super.awakeFromNib()
    }
    
    func handlePan ( rec : UIPanGestureRecognizer )
    {
        if rec.state == .began
        {
            
        }
        if rec.state == .changed
        {
            let translation = rec.translation(in: self)
            self.frame.origin.y += translation.y
            print("translation \(translation)")
            
            rec.setTranslation(CGPoint.zero, in: self)
            blockWithAlpha(self.frame.origin.y)
        }
        
        if rec.state == .ended
        {
            if self.frame.origin.y > self.frame.height / 2
            {
                //вниз
                hideTable()
            }
            
            if self.frame.origin.y < self.frame.height / 2
            {
                //вверх
                showTable()
            }
            
            if self.frame.origin.y == 0 || self.frame.origin.y <= 5
            {
                tableView.isScrollEnabled = true
            }
        }
    }
    
    
}

extension MapTableView: UITableViewDelegate, UITableViewDataSource
{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return dataSource.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let model = dataSource[indexPath.row] as! Item
        let cell = tableView.dequeueReusableCell(withIdentifier: kItemTableViewCellReuseIdentifier, for: indexPath) as! ItemTableViewCell
        cell.configureSelf(model: model)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath)
    {
        let model = dataSource[indexPath.row] as! Item
        blockWithCoordinates(model.longitude, model.latitude)
        hideTable()
        tableView.isScrollEnabled = false
        var indexPath = IndexPath(item: 0, section: 0)
        tableView.scrollToRow(at: indexPath, at: .bottom, animated: false)
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView?
    {
        if self.headerView != nil
        {
            return self.headerView
        }
        
        let headerView = Bundle.main.loadNibNamed("tableViewHeader", owner: nil, options: nil)?[0] as! tableViewHeader
        self.headerView = headerView
        
        return headerView
    }
    
}


//MARK: - анимация таблицы
extension MapTableView
{
    func scrollViewDidScroll(_ scrollView: UIScrollView)
    {
        let currentOffset = scrollView.contentOffset.y
        //print("offset \(currentOffset)")
        if currentOffset == 0
        {
            tableView.isScrollEnabled = false
        }
    
    }
    
    func hideTable()
    {
        UIView.animate(withDuration: 0.5)
        {
            self.frame = CGRect(x: CGFloat(0), y: self.frame.size.height - 144, width: self.frame.size.width, height: self.frame.size.height)
        }
    }
    
    func showTable()
    {
        UIView.animate(withDuration: 0.5)
        {
            self.frame = CGRect(x: CGFloat(0), y: CGFloat(0), width: self.frame.size.width, height: self.frame.size.height)
        }
    }
}

extension MapTableView
{
    func getDataSource() -> NSArray
    {
        return dataSource
    }
}
