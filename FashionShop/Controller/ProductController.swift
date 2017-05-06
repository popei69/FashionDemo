//
//  ProductController.swift
//  FashionShop
//
//  Created by Benoit PASQUIER on 06/05/2017.
//  Copyright © 2017 Benoit PASQUIER. All rights reserved.
//

import Foundation

protocol ProductControllerDelegate {
    func didFetchData(posts: [Product])
    func didFailFetchData(error: ErrorResult)
}

final class ProductController : RequestHandler {
    
    let endpoint = "http://www.matchesfashion.com/womens/shop?format=json"
    var delegate : ProductControllerDelegate?
    
    func fetchProducts() {
        RequestService().loadData(urlString: endpoint, completion: self.networkResult(completion: self.parser))
    }
    
    var parser : ((Result<Shop, ErrorResult>) -> Void) {
        return { postsResult in 
            
            DispatchQueue.main.async {
                switch postsResult {
                case .success(let shop) :
                    // reload data
                    print("Parser success \(shop.products)")
                    self.delegate?.didFetchData(posts: shop.products)
                    break
                case .failure(let error) :
                    print("Parser error \(error)")
                    self.delegate?.didFailFetchData(error: error)
                    break
                }
            }
            
        }
    }
}
