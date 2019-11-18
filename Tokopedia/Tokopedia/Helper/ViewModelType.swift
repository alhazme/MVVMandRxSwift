//
//  ViewModelType.swift
//  Tokopedia
//
//  Created by Mochamad Fariz Al Hazmi on 18/11/19.
//  Copyright © 2019 Mochamad Fariz Al Hazmi. All rights reserved.
//

import Foundation

protocol ViewModelType {
    associatedtype Input
    associatedtype Output
    
    func transform(input: Input) -> Output
}
