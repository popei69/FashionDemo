//
//  UIImageViewAdditions.swift
//  FashionShop
//
//  Created by Benoit PASQUIER on 07/05/2017.
//  Copyright © 2017 Benoit PASQUIER. All rights reserved.
//

import UIKit

extension UIImageView {
    public func imageFromServerURL(urlString: String) {
        
        let _ = RequestService().loadData(urlString: urlString, completion: { result in 
            
            switch result {
            case .success(let data): 
                DispatchQueue.main.async {
                    self.image = UIImage(data: data)
                }
                break
            case .failure(_):
                print("Unable to load image at path " + urlString)
                break
            }
        })
    }}
