//
//  ItemPhotoCollectionTableViewCell.swift
//  LostAndFound
//
//  Created by Орлов Максим on 11.05.17.
//  Copyright © 2017 Иван. All rights reserved.
//

import UIKit
import SDWebImage

class ItemPhotoCollectionTableViewCell: UITableViewCell
{
    
    @IBOutlet weak var ItemPhotoCollection: UICollectionView!
    
    let kItemPhotoCellNib = UINib(nibName: "ItemPhotoCollectionViewCell", bundle: nil)
    let kItemPhotoCellReuseIdentifier = "kitemPhotoCellReuseIdentifier"
    
    var dataSource = NSArray()
    
    override func awakeFromNib()
    {
        ItemPhotoCollection.delegate = self
        ItemPhotoCollection.dataSource = self
        ItemPhotoCollection.register(kItemPhotoCellNib, forCellWithReuseIdentifier: kItemPhotoCellReuseIdentifier)
        
        super.awakeFromNib()
    }
    
    func configureSelf (withDataModel model : ItemPhotoCollectionModel)
    {
        dataSource = model.photosUrls
        ItemPhotoCollection.reloadData()
    }
}

//MARK: Протоколы delegate и datasource для коллекции
extension ItemPhotoCollectionTableViewCell : UICollectionViewDelegateFlowLayout, UICollectionViewDataSource
{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int
    {
        return dataSource.count
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize
    {
        let side = (collectionView.frame.size.width)
        return CGSize(width: side, height: side)
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell
    {
        let url = dataSource[indexPath.item] as! UIImage
        
        let cell = ItemPhotoCollection.dequeueReusableCell(withReuseIdentifier: kItemPhotoCellReuseIdentifier, for: indexPath)
        
        let imageView = cell.contentView.viewWithTag(1111) as! UIImageView
        
        imageView.image = url
        
        return cell
    }
}
