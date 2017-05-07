//
//  Price.swift
//  FashionShop
//
//  Created by Benoit PASQUIER on 06/05/2017.
//  Copyright © 2017 Benoit PASQUIER. All rights reserved.
//

import Foundation

struct Price {
    let value : Double
    let currencyIso : String
    let formattedValue : String
}

extension Price : Parceable {
    static func parseObject(dictionary: [String : AnyObject]) -> Result<Price, ErrorResult> {
        
        if let value = dictionary["value"] as? Double,
            let currencyIso = dictionary["currencyIso"] as? String,
            let formattedValue = dictionary["formattedValue"] as? String {
            
            let newPrice = Price(value: value, currencyIso: currencyIso, formattedValue: formattedValue)
            
            return Result.success(newPrice) 
        } else {
            return Result.failure(ErrorResult.parser(string: "Error while parsing object, check for missing field or data format"))
        }
    }
}
