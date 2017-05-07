//
//  ProductController.swift
//  FashionShop
//
//  Created by Benoit PASQUIER on 06/05/2017.
//  Copyright © 2017 Benoit PASQUIER. All rights reserved.
//

import Foundation

protocol ProductControllerDelegate : class {
    func didFetchData(products: [Product])
    func didFailFetchData(error: ErrorResult)
}

final class ProductController : RequestHandler {
    
    let endpoint = "http://www.matchesfashion.com/womens/shop?format=json"
    weak var delegate : ProductControllerDelegate?
    var task : URLSessionTask?
    
    func fetchProducts() {
        // cancel previous request if already in progress
        cancelFetchProducts()
        
        task = RequestService().loadData(urlString: endpoint, completion: self.networkResult(completion: self.parser))
    }
    
    func cancelFetchProducts() {
        
        if let task = task {
            task.cancel()
        }
        task = nil
    }
    
    var parser : ((Result<Shop, ErrorResult>) -> Void) {
        return { postsResult in 
            
            DispatchQueue.main.async {
                switch postsResult {
                case .success(let shop) :
                    // reload data
//                    print("Parser success \(shop.products)")
                    self.delegate?.didFetchData(products: shop.products)
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
