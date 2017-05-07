//
//  Currency.swift
//  FashionShop
//
//  Created by Benoit PASQUIER on 07/05/2017.
//  Copyright © 2017 Benoit PASQUIER. All rights reserved.
//

import Foundation

enum Currency : String {
    case EUR
    case GBP
}

struct CurrencyRate {
    
    let currency : Currency
    let rate : Double
}
