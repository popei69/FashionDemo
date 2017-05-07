//
//  Product.swift
//  FashionShop
//
//  Created by Benoit PASQUIER on 06/05/2017.
//  Copyright © 2017 Benoit PASQUIER. All rights reserved.
//

import Foundation

struct Product {
    let name : String
    
    var image : ProductImage?
    var price : Price?
    var designer : Designer?
    
    init(name: String) {
        self.name = name
    }
}

extension Product : Parceable {
    
    static func parseObject(dictionary: [String : AnyObject]) -> Result<Product, ErrorResult> {
        if let name = dictionary["name"] as? String,
            let price = dictionary["price"] as? [String : AnyObject], 
            let designer = dictionary["designer"] as? [String : AnyObject],
            let imageMap = dictionary["primaryImageMap"] as? [String : AnyObject] {
            
            var newProduct = Product(name: name)
            
            // parce price
            switch Price.parseObject(dictionary: price) {
            case .success(let newPrice):
                newProduct.price = newPrice
                break
            default:
                newProduct.price = nil
            }
            
            // parce designer
            switch Designer.parseObject(dictionary: designer) {
            case .success(let newDesigner):
                newProduct.designer = newDesigner
                break
            default:
                newProduct.designer = nil
            }
            
            // parse image
            switch ProductImage.parseObject(dictionary: imageMap) {
            case .success(let newImage):
                newProduct.image = newImage
                break
            default:
                newProduct.image = nil
            }
            
            return Result.success(newProduct)
            
        } else {
            return Result.failure(ErrorResult.parser(string: "Error while parsing object, check for missing field or data format"))
        }
    }
}
