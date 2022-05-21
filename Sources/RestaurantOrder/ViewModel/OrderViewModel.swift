//
//  OrderViewModel.swift
//  RestaurantOrder
//
//  Created by Dongdong Zhang on 2022/5/18.
//

import Foundation
import Combine

class OrderViewModel: ObservableObject {
  @Published var restaurant: Restaurant?
  @Published var orderItems: [OrderItem] = []
  @Published var isLoading: Bool = true
  private var cancellable = Set<AnyCancellable>()

  func loadData(url: URL) {
    URLSession.shared.dataTaskPublisher(for: url)
      .map { (data: Data, response: URLResponse) in
        return data
      }
      .decode(type: Restaurant.self, decoder: JSONDecoder())
      .receive(on: DispatchQueue.main)
      .sink { _ in
      } receiveValue: { restaurant in
        self.restaurant = restaurant
        self.orderItems = restaurant.menu.map { OrderItem(price: $0.price, item: $0.item) }
        self.isLoading = false
      }
      .store(in: &cancellable)
  }

  var orderDetails: String {
    let encoder: JSONEncoder = JSONEncoder()
    let data = try? encoder.encode(orderItems)
    return String(data: data!, encoding: .utf8) ?? ""
  }

  var total: Int {
    orderItems.reduce(0) { partialResult, orderItem in
      partialResult + orderItem.price * orderItem.quantities
    }
  }

  var name: String {
    restaurant?.name ?? ""
  }

  var image: URL? {
    restaurant?.image
  }

  var description: String {
    restaurant?.description ?? ""
  }
}
