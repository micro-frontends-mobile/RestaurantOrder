//
//  RandomOrderViewModel.swift
//  RestaurantOrder
//
//
//  Created by Dongdong Zhang on 2022/5/21.
//

import Foundation
import Combine

class RandomOrderViewModel: ObservableObject {
  @Published var url: URL?
  private var cancellable = Set<AnyCancellable>()

  func loadData() {
    URLSession.shared.dataTaskPublisher(for: restaurantListUrl)
      .map { (data: Data, response: URLResponse) in
        return data
      }
      .decode(type: RestaurantList.self, decoder: JSONDecoder())
      .tryMap({ $0[Int.random(in: 0..<$0.count)] })
      .map({ [self] in restaurantURL(id: $0.id) })
      .receive(on: DispatchQueue.main)
      .sink { _ in
      } receiveValue: { url in
        self.url = url
      }
      .store(in: &cancellable)
  }

  private let host = "https://content.demo.microfrontends.com"
  private var restaurantListUrl: URL {
    URL(string: "\(host)/restaurants.json")!
  }

  private func restaurantURL(id: String) -> URL {
    URL(string: "\(host)/restaurants/\(id).json")!
  }
}
