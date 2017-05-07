//
//  IntArrayTests.swift
//  FashionShop
//
//  Created by Benoit PASQUIER on 07/05/2017.
//  Copyright © 2017 Benoit PASQUIER. All rights reserved.
//

import XCTest

class IntArrayTests: XCTestCase {
    
    func isIntersect(array1: [Int], array2: [Int]) -> Bool {
        
        // get min intersect from max of each first values
        let minValue = max(array1.first!, array2.first!)
        
        // get max interesct from min of each last values
        let maxValue = min(array1.last!, array2.last!)
        
        return minValue <= maxValue
    }
    
    func isIncluded(array1:[Int], array2:[Int]) -> [Int] {
        
        return array1.filter({ value in
            // check foreach value contained in array1 if there is at least one element existing in array2
            array2.filter({ $0 == value }).first != nil
        })
    }
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testIsIntersect() {
        
        XCTAssertTrue(isIntersect(array1: [1,2,3,4,5], array2: [3,4,5,6,7,8]))
        
        XCTAssertFalse(isIntersect(array1: [1,2], array2: [4,5]))
    }
    
    func testIsIncluded() {
        
        let array1 = [1,2,3,4,5]
        let array2 = [2,5,7,8,9]
        
        let result = isIncluded(array1: array1, array2: array2)
        
        // waiting [2,5]
        XCTAssertEqual(result[0], 2)
        XCTAssertEqual(result[1], 5)
    }
    
}
