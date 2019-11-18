//
//  ProductResponse.swift
//  Tokopedia
//
//  Created by Mochamad Fariz Al Hazmi on 13/11/19.
//  Copyright © 2019 Mochamad Fariz Al Hazmi. All rights reserved.
//

import Foundation

// MARK: - ProductResponse
struct ProductResponse: Codable {
    let status: Status
//    let header: Header
    let data: [Product]
//    let category: Category
}

// MARK: - Status
struct Status: Codable {
    let errorCode: Int
    let message: String

    enum CodingKeys: String, CodingKey {
        case errorCode = "error_code"
        case message
    }
}

// MARK: - Header
//struct Header: Codable {
//    let totalData, totalDataNoCategory: Int
//    let additionalParams: String
//    let processTime: Double
//    let suggestionInstead: String
//
//    enum CodingKeys: String, CodingKey {
//        case totalData = "total_data"
//        case totalDataNoCategory = "total_data_no_category"
//        case additionalParams = "additional_params"
//        case processTime = "process_time"
//        case suggestionInstead = "suggestion_instead"
//    }
//
//    init(from decoder: Decoder) throws {
//        let container = try decoder.container(keyedBy: CodingKeys.self)
//            totalData = (try container.decodeIfPresent(Int.self, forKey: .totalData)) ?? 0
//            totalDataNoCategory = (try container.decodeIfPresent(Int.self, forKey: .totalDataNoCategory)) ?? 0
//            additionalParams = (try container.decodeIfPresent(String.self, forKey: .additionalParams)) ?? ""
//            processTime = (try container.decodeIfPresent(Double.self, forKey: .processTime)) ?? 0.0
//            suggestionInstead = (try container.decodeIfPresent(String.self, forKey: .suggestionInstead)) ?? ""
//    }
//}

// MARK: - Category
//struct Category: Codable {
//    let data: [String: CategoryValue]
//    let selectedID: String
//
//    enum CodingKeys: String, CodingKey {
//        case data
//        case selectedID = "selected_id"
//    }
//}

// MARK: - Product
struct Product: Codable {
    let id: Int
    let name: String
    let uri: String
    let imageURI, imageURI700: String
    let price, priceRange, categoryBreadcrumb: String
//    let shop: Shop
//    let wholesalePrice: [WholesalePrice]
    let condition, preorder, departmentID, rating: Int
    let isFeatured, countReview, countTalk, countSold: Int
//    let labels: [Label]
//    let labelGroups, topLabel, bottomLabel: [String]
//    let badges: [Badge]
    let originalPrice, discountExpired, discountStart: String
    let discountPercentage, stock: Int

    enum CodingKeys: String, CodingKey {
        case id, name, uri
        case imageURI = "image_uri"
        case imageURI700 = "image_uri_700"
        case price
        case priceRange = "price_range"
        case categoryBreadcrumb = "category_breadcrumb"
//        case shop
//        case wholesalePrice = "wholesale_price"
        case condition, preorder
        case departmentID = "department_id"
        case rating
        case isFeatured = "is_featured"
        case countReview = "count_review"
        case countTalk = "count_talk"
        case countSold = "count_sold"
//        case labels
//        case labelGroups = "label_groups"
//        case topLabel = "top_label"
//        case bottomLabel = "bottom_label"
//        case badges
        case originalPrice = "original_price"
        case discountExpired = "discount_expired"
        case discountStart = "discount_start"
        case discountPercentage = "discount_percentage"
        case stock
    }
}

// MARK: - Shop
//struct Shop: Codable {
//    let id: Int
//    let name: String
//    let uri: String
//    let isGold: Int
//    let rating: Int
//    let location: City
//    let reputationImageURI, shopLucky: String
//    let city: City
//    let isPowerBadge: Bool
//
//    enum CodingKeys: String, CodingKey {
//        case id, name, uri
//        case isGold = "is_gold"
//        case rating, location
//        case reputationImageURI = "reputation_image_uri"
//        case shopLucky = "shop_lucky"
//        case city
//        case isPowerBadge = "is_power_badge"
//    }
//
//    init(from decoder: Decoder) throws {
//        let container = try decoder.container(keyedBy: CodingKeys.self)
//            id = (try container.decodeIfPresent(Int.self, forKey: .id)) ?? 0
//            name = (try container.decodeIfPresent(String.self, forKey: .name)) ?? ""
//            uri = (try container.decodeIfPresent(String.self, forKey: .uri)) ?? ""
//            isGold = (try container.decodeIfPresent(Int.self, forKey: .isGold)) ?? 0
//            rating = (try container.decodeIfPresent(Int.self, forKey: .rating)) ?? 0
//            location = (try container.decodeIfPresent(City.self, forKey: .location)) ?? City(rawValue: "")!
//            reputationImageURI = (try container.decodeIfPresent(String.self, forKey: .reputationImageURI)) ?? ""
//            shopLucky = (try container.decodeIfPresent(String.self, forKey: .shopLucky)) ?? ""
//            city = (try container.decodeIfPresent(City.self, forKey: .city)) ?? City(rawValue: "")!
//            isPowerBadge = (try container.decodeIfPresent(Bool.self, forKey: .isPowerBadge)) ?? false
//    }
//}

//enum City: String, Codable {
//    case bekasi = "Bekasi"
//    case jakarta = "Jakarta"
//}

// MARK: - WholesalePrice
//struct WholesalePrice: Codable {
//    let countMin, countMax: Int
//    let price: String
//
//    enum CodingKeys: String, CodingKey {
//        case countMin = "count_min"
//        case countMax = "count_max"
//        case price
//    }
//}

// MARK: - Label
//struct Label: Codable {
//    let title: LabelTitle
//    let color: Color
//}

//enum Color: String, Codable {
//    case ffffff = "#ffffff"
//    case the42B549 = "#42b549"
//}

//enum LabelTitle: String, Codable {
//    case cashback = "Cashback"
//    case grosir = "Grosir"
//}

// MARK: - Badge
//struct Badge: Codable {
//    let title: BadgeTitle
//    let imageURL: String
//    let show: Bool
//
//    enum CodingKeys: String, CodingKey {
//        case title
//        case imageURL = "image_url"
//        case show
//    }
//}

//enum BadgeTitle: String, Codable {
//    case officialStore = "Official Store"
//    case powerBadge = "Power Badge"
//}


// MARK: - Category Value
//struct CategoryValue: Codable {
//    let id: Int
//    let name, totalData: String
//    let parentID: Int
//    let childID: [Int]?
//    let level: Int
//
//    enum CodingKeys: String, CodingKey {
//        case id, name
//        case totalData = "total_data"
//        case parentID = "parent_id"
//        case childID = "child_id"
//        case level
//    }
//
//    init(from decoder: Decoder) throws {
//        let container = try decoder.container(keyedBy: CodingKeys.self)
//            id = (try container.decodeIfPresent(Int.self, forKey: .id)) ?? 0
//            name = (try container.decodeIfPresent(String.self, forKey: .name)) ?? ""
//            totalData = (try container.decodeIfPresent(String.self, forKey: .totalData)) ?? ""
//            parentID = (try container.decodeIfPresent(Int.self, forKey: .parentID)) ?? 0
//            childID = (try container.decodeIfPresent([Int].self, forKey: .childID)) ?? [Int]()
//            level = (try container.decodeIfPresent(Int.self, forKey: .level)) ?? 0
//    }
//}
