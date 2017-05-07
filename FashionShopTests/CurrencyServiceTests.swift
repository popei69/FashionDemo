//
//  CurrencyServiceTests.swift
//  FashionShop
//
//  Created by Benoit PASQUIER on 07/05/2017.
//  Copyright © 2017 Benoit PASQUIER. All rights reserved.
//

import XCTest

class CurrencyServiceTests: XCTestCase {
    
    var converter : Converter?
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testConversionPrice() {
        
        // uk price
        let price = Price(value: 2, currencyIso: Currency.GBP.rawValue, formattedValue: "£2.00")
        
        // conversion rate
        let rate = CurrencyRate(currency: .EUR, rate: 2.0)
        converter = Converter(base: .GBP, date: "00-00-00", rates: [rate])
        
        // update currency
        CurrencyService.shared.currency = .EUR
        CurrencyService.shared.converter = converter
        
        let newPrice = CurrencyService.shared.convert(price: price)
        
        XCTAssertEqual(newPrice.currencyIso, Currency.EUR.rawValue)
        XCTAssertEqual(newPrice.value, 4.0)
        
        // need to escape EUR as unicode, otherwise fail 
        XCTAssertEqual(newPrice.formattedValue, "4,00\u{00a0}€")
    }
}
