//
//  OrderViewModelTests.swift
//  RestaurantOrderTests
//
//  Created by Dongdong Zhang on 2022/5/18.
//

import XCTest
@testable import RestaurantOrder

class OrderViewModelTests: XCTestCase {
  var viewModel = OrderViewModel()

  override func setUpWithError() throws {
    let restaurant = Restaurant(
      id: "1",
      imageSrc: "/images/1-burger.jpg",
      name: "Becky's Burgers",
      priceRange: "$$",
      description: "Juicy burgers, crunchy fries, and creamy shakes",
      menu: [
        Menu(item: "Cheeseburger", price: 9),
        Menu(item: "Milkshake", price: 4),
        Menu(item: "Meal (burger, fries, and shake)", price: 15)
      ])
    viewModel.restaurant = restaurant

    viewModel.orderItems = restaurant.menu.map { OrderItem(price: $0.price, item: $0.item) }
  }

  func testName() {
    XCTAssertEqual("Becky's Burgers", viewModel.name)
  }

  func testDescription() {
    XCTAssertEqual("Juicy burgers, crunchy fries, and creamy shakes", viewModel.description)
  }

  func testImage() {
    XCTAssertEqual("/images/1-burger.jpg", viewModel.image?.path)
  }

  func testTotal() {
    viewModel.orderItems[0].quantities = 2
    viewModel.orderItems[1].quantities = 3
    viewModel.orderItems[2].quantities = 4
    XCTAssertEqual(90, viewModel.total)
  }

  func testOrderDetails() {
    XCTAssertEqual("""
    [{"price":9,"quantities":0,"item":"Cheeseburger"},{"price":4,"quantities":0,"item":"Milkshake"},{"price":15,"quantities":0,"item":"Meal (burger, fries, and shake)"}]
    """, viewModel.orderDetails)
  }
}
