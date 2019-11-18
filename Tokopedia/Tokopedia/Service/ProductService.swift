//
//  ProductService.swift
//  Tokopedia
//
//  Created by Mochamad Fariz Al Hazmi on 13/11/19.
//  Copyright © 2019 Mochamad Fariz Al Hazmi. All rights reserved.
//

import Foundation
import Alamofire
import RxSwift

enum ProductServiceError: Error {
    case missingData
}

protocol ProductServiceProtocol {
    func fetchProducts(_ minPrice: Int?, maxPrice: Int?, wholeSale: Bool?, official: Bool?, fshop: Int?, start: Int?, rows: Int?, completion: @escaping ((Result<ProductResponse, Error>) -> Void))
    func reactiveFetchProducts(_ minPrice: Int, maxPrice: Int, wholeSale: Bool, official: Bool?, fshop: Int?, start: Int?, rows: Int?) -> Observable<[Product]>
}

class ProductService: ProductServiceProtocol {
    
    private let jsonDecoder: JSONDecoder = {
        let decoder = JSONDecoder()
        // decoder.keyDecodingStrategy = .convertFromSnakeCase
        return decoder
    }()
    let disposeBag = DisposeBag()
    
    func fetchProducts(_ minPrice: Int?, maxPrice: Int?, wholeSale: Bool?, official: Bool?, fshop: Int?, start: Int?, rows: Int?, completion: @escaping ((Result<ProductResponse, Error>) -> Void)) {
        
        var parameter: [String: Any] = [
            "q": "samsung"
        ]
        
        if let minPrice = minPrice, let maxPrice = maxPrice {
            parameter["pmin"] = minPrice
            parameter["pmax"] = maxPrice
        }
        
        if let wholeSale = wholeSale {
            parameter["wholesale"] = wholeSale
        }
        
        if let official = official {
            parameter["official"] = official
        }
        
        if let fshop = fshop {
            parameter["fshop"] = fshop
        }
        
        if let start = start {
            parameter["start"] = start
        }
        
        if let rows = rows {
            parameter["rows"] = rows
        }
        
        AF.request(
            Constants.BASE_API_URL + "product",
            method: .get,
            parameters: parameter
        )
        .responseJSON(completionHandler: { json in
            print(json)
        })
        .responseData { (response) in
            guard let data = response.data else {
                print("missingData")
                completion(.failure(ProductServiceError.missingData))
                return
            }
            do {
                print("success")
                let productResponse = try self.jsonDecoder.decode(ProductResponse.self, from: data)
                completion(.success(productResponse))
            } catch (let decodeError) {
                print("decodeError: " + decodeError.localizedDescription)
                completion(.failure(decodeError))
            }
        }
    }
    
    func reactiveFetchProducts(_ minPrice: Int, maxPrice: Int, wholeSale: Bool, official: Bool?, fshop: Int?, start: Int?, rows: Int?) -> Observable<[Product]> {
        
        return Observable.create { observer -> Disposable in
            
            var parameter: [String: Any] = [
                "q": "samsung",
                "pmin": minPrice,
                "pmax": maxPrice,
                "wholesale": wholeSale
            ]
            
            if let official = official {
                parameter["official"] = official
            }
            
            if let fshop = fshop {
                parameter["fshop"] = fshop
            }
            
            if let start = start {
                parameter["start"] = start
            }
            
            if let rows = rows {
                parameter["rows"] = rows
            }
            
            AF.request(
                Constants.BASE_API_URL + "product",
                method: .get,
                parameters: parameter
            )
            .responseJSON(completionHandler: { json in
                print(json)
            })
            .responseData { (response) in
                guard let data = response.data else {
                    print("missingData")
                    observer.onError(response.error ?? ProductServiceError.missingData)
                    return
                }
                do {
                    print("success")
                    let productResponse = try self.jsonDecoder.decode(ProductResponse.self, from: data)
                    observer.onNext(productResponse.data)
                } catch (let decodeError) {
                    print("decodeError: " + decodeError.localizedDescription)
                    observer.onError(decodeError)
                }
            }
            
            return Disposables.create()
        }
        
//        var url = Constants.BASE_API_URL + "product?"
//        url += "q=samsung"
//        url += "&pmin=\(minPrice)"
//        url += "&pmax=\(maxPrice)"
//        url += "&wholesale=\(wholeSale)"
//
//        if let official = official {
//            url += "&official=\(official)"
//        }
//
//        if let fshop = fshop {
//            url += "&fshop=\(fshop)"
//        }
//
//        if let start = start {
//            url += "&start=\(start)"
//        }
//
//        if let rows = rows {
//            url += "&rows=\(rows)"
//        }
//
//        let urlRequest = URLRequest(url: URL(string: url)!)
//        let response = URLSession.shared.rx.data(request: urlRequest).flatMapLatest { data -> Observable<ProductResponse> in
//                let decoder = JSONDecoder()
//                decoder.keyDecodingStrategy = .convertFromSnakeCase
//                do {
//                    let resultData = try decoder.decode(ProductResponse.self, from: data)
//                    return Observable.just(resultData)
//                } catch (let decodeError) {
//                    return Observable.error(decodeError)
//                }
//        }
//
//        let products = response.map { $0.data }
//
//        return products
    }
    
}
