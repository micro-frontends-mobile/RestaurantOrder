//
//  OrderView.swift
//  RestaurantOrder
//
//  Created by Dongdong Zhang on 2022/5/18.
//

import SwiftUI
import Env

public struct OrderView: View {
  @StateObject private var viewModel: OrderViewModel = OrderViewModel()
  @State private var showingAlert: Bool = false
  var url: URL

  public init(url: URL) {
    self.url = url
    _ = Env.initialize()
  }

  public var body: some View {
    ZStack(alignment: .bottom) {
      ScrollView {
        if !viewModel.isLoading {
          restaurantInfo
          orderMenu
        } else {
          ProgressView()
        }

        Spacer(minLength: 100)
      }

      orderButton
        .background(Env.shared.configuration.backgroundColor)
    }
    .padding()
    .onAppear {
      viewModel.loadData(url: url)
    }
    .background(Env.shared.configuration.backgroundColor)
  }

  private var restaurantInfo: some View {
    VStack {
      HStack {
        Text("\(viewModel.name)")
          .font(.largeTitle)
        Spacer()
      }

      if let image = viewModel.image {
        AsyncImage(url: image) { image in
          image.resizable()
        } placeholder: {
          ProgressView()
        }
        .frame(height: 260)
      } else {
        ProgressView()
      }

      HStack {
        Text("\(viewModel.description)")
          .font(.title2)
        Spacer()
      }
    }
  }

  private var orderMenu: some View {
    VStack(alignment: .leading) {
      Text("Menu")
        .font(.title)
      Divider()
      ForEach(viewModel.orderItems.indices, id: \.self) { index in
        OrderItemView(orderItem: $viewModel.orderItems[index])
        Divider()
      }
    }
    .padding([.top, .bottom], 20)
  }

  private var orderButton: some View {
    HStack {
      Text("Total: $\(viewModel.total)")

      Spacer()

      Button {
        showingAlert = true
      } label: {
        Text("Order now")
          .padding(12)
          .tint(.primary)
          .background(Color(uiColor: UIColor(red: 231/255, green: 150/255, blue: 82/255, alpha: 1.0)))
      }
      .alert(isPresented: $showingAlert) {
        Alert(title: Text("Order details"), message: Text(viewModel.orderDetails), dismissButton: nil)
      }
    }
    .font(.largeTitle)
  }
}

struct OrderView_Previews: PreviewProvider {
  static var previews: some View {
    OrderView(url: URL(string: "https://content.demo.microfrontends.com/restaurants/1.json")!)
  }
}
