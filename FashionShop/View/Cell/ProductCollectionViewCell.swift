//
//  ProductCollectionViewCell.swift
//  FashionShop
//
//  Created by Benoit PASQUIER on 07/05/2017.
//  Copyright © 2017 Benoit PASQUIER. All rights reserved.
//

import UIKit

class ProductCollectionViewCell: UICollectionViewCell {
    
    static let identifier = "ProductCollectionViewCell"
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var designerLabel : UILabel!
    @IBOutlet weak var imageView: UIImageView!
    
    var product : Product? {
        didSet {
            
            guard let product = product else { return }
            
            nameLabel.text = product.name
            
            if let price = product.price {
                priceLabel.text = price.formattedValue
            }
            
            if let designer = product.designer {
                designerLabel.text = "By " + designer.name
            }
            
            if let image = product.image {
                imageView.imageFromServerURL(urlString: image.urlString)
            }
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
}
