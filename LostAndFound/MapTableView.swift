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
    @IBOutlet weak var tableView: UITableView!
    
    override func awakeFromNib()
    {
        tableView.isScrollEnabled = false
        tableView.dataSource = self
        tableView.delegate = self
        
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
            
            rec.setTranslation(CGPoint.zero, in: self)
        }
        
        if rec.state == .ended
        {
            
            if self.frame.origin.y > self.frame.height / 2
            {
                print("должно ехать вниз")
            }
            
            if self.frame.origin.y < self.frame.height / 2
            {
                print("должно ехать вверх")
                print("\(self.frame.origin.y)")
            }
            
            if self.frame.origin.y == 0 || self.frame.origin.y <= 5
            {
                print("верх")
                tableView.isScrollEnabled = true
            }
            //анализ координат таблицы
            //тут включаем скролл таблицы 
            //понять где выключать скролл и включать пан, выключать баунсы
            //scroll view did scroll слушать 
        }
    }
    
    
}

extension MapTableView: UITableViewDelegate, UITableViewDataSource
{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        return UITableViewCell()
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView)
    {
        let currentOffset = scrollView.contentOffset.y
        print("offset \(currentOffset)")
        if currentOffset <= -35
        {
            print("меньше нуля")
            tableView.isScrollEnabled = false
        }
        
    }
}
