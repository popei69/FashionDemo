//
//  ConversionCurrency.swift
//  FashionShop
//
//  Created by Benoit PASQUIER on 07/05/2017.
//  Copyright © 2017 Benoit PASQUIER. All rights reserved.
//

import Foundation

struct ConversionCurrency {
    
    let base : Currency
    let date : String
    
    let rates : [CurrencyRate]
}

extension ConversionCurrency : Parceable {
    
    static func parseObject(dictionary: [String : AnyObject]) -> Result<ConversionCurrency, ErrorResult> {
        if let base = dictionary["base"] as? String,
            let currency = Currency(rawValue: base),
            let date = dictionary["date"] as? String,
            let rates = dictionary["rates"] as? [String: Double] {
            
            var finalRates : [CurrencyRate] = []
            if let value = rates[Currency.GBP.rawValue] {
                finalRates.append(CurrencyRate(currency: .GBP, rate: value))
            }
            
            let conversion = ConversionCurrency(base: currency, date: date, rates: finalRates)
            
            return Result.success(conversion)
        } else {
            return Result.failure(ErrorResult.parser(string: "Unable to parse conversion rate"))
        }
    }
}
