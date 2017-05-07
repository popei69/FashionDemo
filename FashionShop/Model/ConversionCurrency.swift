//
//  ConversionCurrency.swift
//  FashionShop
//
//  Created by Benoit PASQUIER on 07/05/2017.
//  Copyright © 2017 Benoit PASQUIER. All rights reserved.
//

import Foundation

struct Converter {
    
    let base : Currency
    let date : String
    
    let rates : [CurrencyRate]
}

extension Converter : Parceable {
    
    static func parseObject(dictionary: [String : AnyObject]) -> Result<Converter, ErrorResult> {
        if let base = dictionary["base"] as? String,
            let currency = Currency(rawValue: base),
            let date = dictionary["date"] as? String,
            let rates = dictionary["rates"] as? [String: Double] {
            
            var finalRates : [CurrencyRate] = []
            for (currencyIso, value) in rates {
                if let currency = Currency(rawValue: currencyIso) {
                    finalRates.append(CurrencyRate(currency: currency, rate: value))
                }
            }
            
            let conversion = Converter(base: currency, date: date, rates: finalRates)
            
            return Result.success(conversion)
        } else {
            return Result.failure(ErrorResult.parser(string: "Unable to parse conversion rate"))
        }
    }
}
