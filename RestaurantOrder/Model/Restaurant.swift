//
//  Restaurant.swift
//  RestaurantOrder
//
//  Created by Dongdong Zhang on 2022/5/18.
//

import Foundation

struct Restaurant: Identifiable, Decodable {
  let id: String
  let imageSrc: String
  let name: String
  let priceRange: String
  let description: String

  let menu: [Menu]

  var image: URL {
    URL(string: "https://content.demo.microfrontends.com\(imageSrc)")!
  }
}

struct Menu: Decodable, Hashable {
  let item: String
  let price: Int
}
