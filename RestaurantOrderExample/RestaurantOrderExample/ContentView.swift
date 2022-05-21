//
//  ContentView.swift
//  RestaurantOrderExample
//
//  Created by Dongdong Zhang on 2022/5/21.
//

import SwiftUI
import RestaurantOrder

struct ContentView: View {
    var body: some View {
        OrderView(url: URL(string: "https://content.demo.microfrontends.com/restaurants/1.json")!)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
