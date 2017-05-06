//
//  Designer.swift
//  FashionShop
//
//  Created by Benoit PASQUIER on 06/05/2017.
//  Copyright © 2017 Benoit PASQUIER. All rights reserved.
//

import Foundation

struct Designer {
    let name : String
}

extension Designer : Parceable {
    
    static func parseObject(dictionary: [String : AnyObject]) -> Result<Designer, ErrorResult> {
        if let name = dictionary["name"] as? String {
            let newDesigner = Designer(name: name)
            
            return Result.success(newDesigner)
        } else {
            return Result.failure(ErrorResult.parser(string: "Error while parsing object, check for missing field or data format"))
        }
    }
}
