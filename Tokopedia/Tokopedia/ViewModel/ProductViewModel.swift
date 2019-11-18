//
//  ProductViewModel.swift
//  Tokopedia
//
//  Created by Mochamad Fariz Al Hazmi on 13/11/19.
//  Copyright © 2019 Mochamad Fariz Al Hazmi. All rights reserved.
//

import Foundation
import UIKit

class ProductViewModel: NSObject {
    
    private let service: ProductServiceProtocol
    private var products: [Product] = []
    
    var onDataProductRefreshed: (([Product]) -> Void)?
    var onDataProductEmpty: (([Product]) -> Void)?
    var onError: ((Error) -> Void)?
    
    init(productService: ProductServiceProtocol = ProductService()) {
        service = productService
        super.init()
    }
    
    func fetchProducts(_ minPrice: Int?, maxPrice: Int?, wholeSale: Bool?, official: Bool?, fshop: Int?, start: Int?, rows: Int?) {
        service.fetchProducts(minPrice, maxPrice: maxPrice, wholeSale: wholeSale, official: official, fshop: fshop, start: start, rows: rows) { [weak self] (result) in
            switch result {
                case .success(let response):
                    self?.products = response.data
                    if (response.data.count > 0) {
                        self?.onDataProductRefreshed?(response.data)
                    }
                    else {
                        self?.onDataProductEmpty?(response.data)
                    }
                case let .failure(error):
                    self?.onError?(error)
            }
        }
    }
    
}
