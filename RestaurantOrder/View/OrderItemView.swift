//
//  OrderItemView.swift
//  RestaurantOrder
//
//  Created by Dongdong Zhang on 2022/5/18.
//

import SwiftUI

struct OrderItemView: View {
  @Binding var orderItem: OrderItem

  var body: some View {
    HStack {
      Text("\(orderItem.item)")

      Spacer()

      HStack {
        Text("$\(orderItem.price)")
        Image(systemName: "minus.circle")
          .onTapGesture {
            if orderItem.quantities != 0 {
              orderItem.quantities -= 1
            }
          }
          .foregroundColor(orderItem.quantities == 0 ? .gray : .primary)

        Text("X\(orderItem.quantities)")
        Image(systemName: "plus.circle")
          .onTapGesture {
            orderItem.quantities += 1
          }
      }
    }
    .font(.title3)
  }
}

struct OrderItemView_Previews: PreviewProvider {
    static var previews: some View {
      OrderItemPreview()
    }

  struct OrderItemPreview: View {
    @State private var orderItem = OrderItem(price: 15, item: "Meal (burger, fries, and shake)")
    var body: some View {
      OrderItemView(orderItem: $orderItem)
    }
  }
}
