//
//  RandomOrderView.swift
//  
//
//  Created by Dongdong Zhang on 2022/5/21.
//

import SwiftUI

public struct RandomOrderView: View {
  @StateObject var viewModel = RandomOrderViewModel()

  public init() {}

  public var body: some View {
    Group {
      if viewModel.url != nil {
        OrderView(url: viewModel.url!)
      } else {
        ProgressView()
      }
    }
    .onAppear {
      viewModel.loadData()
    }
  }
}

struct RandomOrderView_Previews: PreviewProvider {
    static var previews: some View {
        RandomOrderView()
    }
}
