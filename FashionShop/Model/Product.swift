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
    
    var imageString : String?
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
            let designer = dictionary["designer"] as? [String : AnyObject] {
            
            var newProduct = Product(name: name)
            
            // parce price
            switch Price.parseObject(dictionary: price) {
            case .success(let newPrice):
                newProduct.price = newPrice
            default:
                newProduct.price = nil
            }
            
            // parce designer
            switch Designer.parseObject(dictionary: designer) {
            case .success(let newDesigner):
                newProduct.designer = newDesigner
            default:
                newProduct.designer = nil
            }
            
            return Result.success(newProduct)
            
        } else {
            return Result.failure(ErrorResult.parser(string: "Error while parsing object, check for missing field or data format"))
        }
    }
}
