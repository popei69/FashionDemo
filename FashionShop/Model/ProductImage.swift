//
//  ProductImage.swift
//  FashionShop
//
//  Created by Benoit PASQUIER on 07/05/2017.
//  Copyright © 2017 Benoit PASQUIER. All rights reserved.
//

import Foundation

struct ProductImage {
    var format : String
    var urlString : String
}

extension ProductImage : Parceable {
    
    static func parseObject(dictionary: [String : AnyObject]) -> Result<ProductImage, ErrorResult> {
        if let mediumDic = dictionary["medium"] as? [String : AnyObject],
            let format = mediumDic["format"] as? String,
            let urlString = mediumDic["url"] as? String {
            
            let finalImage = (!urlString.contains("http:")) ? "http:" + urlString : urlString
            
            let newImage = ProductImage(format: format, urlString: finalImage)
            return Result.success(newImage)
        } else {
            return Result.failure(ErrorResult.parser(string: "Error while parsing object, check for missing field or data format"))
        }
    }
}
