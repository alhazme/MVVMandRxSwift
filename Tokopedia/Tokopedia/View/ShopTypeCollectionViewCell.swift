//
//  ShopTypeCollectionViewCell.swift
//  Tokopedia
//
//  Created by Mochamad Fariz Al Hazmi on 13/11/19.
//  Copyright © 2019 Mochamad Fariz Al Hazmi. All rights reserved.
//

import UIKit

protocol ShopTypeCollectionViewCellDelegate {
    func closeShopType(_ shopType: String)
}

class ShopTypeCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet var lbTitle: UILabel!
    @IBOutlet var btnClose: UIButton!
    
    var shopType: String = ""
    var delegate: ShopTypeCollectionViewCellDelegate?
    
    @IBAction func onTapClose(_ sender: Any) {
        delegate?.closeShopType(self.shopType)
    }
    
}
