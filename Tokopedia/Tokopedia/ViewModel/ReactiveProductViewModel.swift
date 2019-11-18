//
//  ReactiveProductViewModel.swift
//  Tokopedia
//
//  Created by Mochamad Fariz Al Hazmi on 18/11/19.
//  Copyright © 2019 Mochamad Fariz Al Hazmi. All rights reserved.
//

import Foundation
import RxCocoa
import RxSwift

class ReactiveProductViewModel: ViewModelType {
    
    private let service: ProductServiceProtocol
    let disposeBag = DisposeBag()
    
    var minimumPrice: Int = 100
    var maximumPrice: Int = 10000000
    var wholeSale: Bool = false
    var shopTypes: [String] = []
    var official: Bool? = nil
    var fshop: Int? = nil
    var start: Int = 0
    var row = 10
    var products: [Product] = [Product]()
    
    init (service: ProductServiceProtocol = ProductService()) {
        self.service = service
    }
    
    struct Input {
        let didLoadTrigger: Driver<Void>
    }
    
    struct Output {
        let productListCellData: Driver<[ProductListCellData]>
    }
    
    func transform(input: Input) -> Output {
        
        let fetchData = input.didLoadTrigger
            .do(onNext: { _ in
                
            })
            .flatMapLatest { [service] _ -> Driver<[Product]> in
                service
                    .reactiveFetchProducts(
                        self.minimumPrice,
                        maxPrice: self.maximumPrice,
                        wholeSale: self.wholeSale,
                        official: self.official,
                        fshop: self.fshop,
                        start: self.start,
                        rows: self.row
                    )
                    .asDriver { _ -> Driver<[Product]> in
                        Driver.empty()
                    }
            }
        
        let productListCellData = fetchData.map { products -> [ProductListCellData] in
            products.map { product -> ProductListCellData in
                ProductListCellData(imageURL: product.imageURI, name: product.name, price: product.price)
            }
        }
        
        return Output(productListCellData: productListCellData)
        
    }
}
