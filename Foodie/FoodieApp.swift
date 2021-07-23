//
//  FoodieApp.swift
//  Foodie
//
//  Created by ashutosh on 04/07/21.
//

import SwiftUI

@main
struct FoodieApp: App {
    @ObservedObject var myCart = CartList()
    @ObservedObject var myWishList = WishList(dishes: [])
    var body: some Scene {
        WindowGroup {
            MainView()
                .environmentObject(myCart)
                .environmentObject(myWishList)
        }
    }
}
