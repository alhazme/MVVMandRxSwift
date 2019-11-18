//
//  ProductCollectionViewCell.swift
//  Tokopedia
//
//  Created by Mochamad Fariz Al Hazmi on 13/11/19.
//  Copyright © 2019 Mochamad Fariz Al Hazmi. All rights reserved.
//

import UIKit
import SDWebImage

struct ProductListCellData {
    let imageURL: String
    let name: String
    let price: String
}

class ProductCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var productImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    
    
    static let reuseIdentifier = "ProductCollectionViewCell"
    
    func configureCell(with data: ProductListCellData) {
        productImageView.sd_setImage(with: URL(string: data.imageURL), placeholderImage: UIImage(named: "placeholder.png"))
        nameLabel.text = data.name
        priceLabel.text = data.price
    }
    
}
