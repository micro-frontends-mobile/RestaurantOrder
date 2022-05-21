//
//  OrderItem.swift
//  RestaurantOrder
//
//  Created by Dongdong Zhang on 2022/5/18.
//

import Foundation

struct OrderItem: Hashable, Encodable {
  var price: Int
  var item: String
  var quantities: Int = 0
}
