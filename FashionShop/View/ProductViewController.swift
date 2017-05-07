//
//  ProductViewController.swift
//  FashionShop
//
//  Created by Benoit PASQUIER on 06/05/2017.
//  Copyright © 2017 Benoit PASQUIER. All rights reserved.
//

import UIKit

class ProductViewController: UIViewController {
    
    let controller = ProductController()
    var products : [Product] = [] {
        didSet {
            self.collectionView.reloadData()
        }
    }
    
    // ui 
    let refreshControl = UIRefreshControl()
    @IBOutlet weak var collectionView : UICollectionView!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "Shop"

        refreshControl.addTarget(self, action: #selector(ProductViewController.fetchProducts), for: .valueChanged)
        refreshControl.tintColor = UIColor.purple
        
        collectionView.addSubview(refreshControl)
        collectionView.delegate = self
        collectionView.dataSource = self
        
        let barButton = UIBarButtonItem(title: "Currency", style: .plain, target: self, action: #selector(ProductViewController.displayCurrency))
        self.navigationItem.rightBarButtonItem = barButton
        
        
        // Do any additional setup after loading the view.
        controller.delegate = self
        self.fetchProducts()
        
        CurrencyService.shared
    }
    
    func fetchProducts() {
        controller.fetchProducts()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}

extension ProductViewController : UICollectionViewDelegate, UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return products.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let collectionCell = collectionView.dequeueReusableCell(withReuseIdentifier: ProductCollectionViewCell.identifier, for: indexPath) as! ProductCollectionViewCell
        
        collectionCell.product = products[indexPath.row]
        
        return collectionCell
    }
}

extension ProductViewController : ProductControllerDelegate {
    
    func didFetchData(products: [Product]) {
        refreshControl.endRefreshing()
        self.products = products
    }
    
    func didFailFetchData(error: ErrorResult) {
        refreshControl.endRefreshing()
    }
}

extension ProductViewController {
    
    func displayCurrency() {
        
        let alertController = UIAlertController(title: "Choose currency", message: "Select currency you would like to display", preferredStyle: .actionSheet)
        
        alertController.addAction(UIAlertAction(title: Currency.GBP.rawValue, style: .default, handler: { [weak self]action in
            CurrencyService.shared.currency = .GBP
            self?.collectionView.reloadData()
            alertController.dismiss(animated: true, completion: nil)
        }))
        alertController.addAction(UIAlertAction(title: Currency.EUR.rawValue, style: .default, handler: { [weak self] action in
            CurrencyService.shared.currency = .EUR
            self?.collectionView.reloadData()
            alertController.dismiss(animated: true, completion: nil)
        }))
        
        self.navigationController?.present(alertController, animated: true, completion: nil)
    }
}
