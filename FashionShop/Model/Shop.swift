//
//  Shop.swift
//  FashionShop
//
//  Created by Benoit PASQUIER on 06/05/2017.
//  Copyright © 2017 Benoit PASQUIER. All rights reserved.
//

import Foundation

struct Shop {
    let products: [Product]
}

extension Shop : Parceable {
    
    static func parseObject(dictionary: [String : AnyObject]) -> Result<Shop, ErrorResult> {
        if let results = dictionary["results"] as? [[String : AnyObject]] {
            
            var products : [Product] = []
            for tmpProduct in results {
                switch Product.parseObject(dictionary: tmpProduct) {
                case .success(let product):
                    products.append(product)
                    break
                case .failure(_):
                    continue
                }
            }
            
            let shop = Shop(products: products)
            
            return Result.success(shop)
            
        } else {
            return Result.failure(ErrorResult.parser(string: "Error while parsing object, check for missing field or data format"))
        }
    }
}
