//
//  SearchedItemDetailListView.swift
//  Foodie
//
//  Created by ashutosh on 05/07/21.
//

import SwiftUI

struct SearchedItemDetailListView: View {
    @Environment(\.presentationMode) var presentation
    @EnvironmentObject var myCart : CartList
    var dish : SearchDish
    var gridVIew = [GridItem(.fixed(Screen.maxWidth*0.45)),GridItem(.fixed(Screen.maxWidth*0.45)),]
    var body: some View {
        ZStack{
            Color.background.ignoresSafeArea()
            VStack{
                HStack{
                    Image(systemName: "chevron.left").foregroundColor(.white).padding(.leading)
                        .onTapGesture {
                            self.presentation.wrappedValue.dismiss()
                        }
                    Spacer()
                    Text(dish.dishName).font(.custom("Verdana", fixedSize: 18)).foregroundColor(.white).bold().padding(.trailing,Screen.maxWidth*0.06)
                    Spacer()
                }
                Divider()
                ScrollView(.vertical, showsIndicators: false) {
                    LazyVGrid(columns: gridVIew) {
                        ForEach(dish.items){dish in
                            DishCell(dish: dish)
                        }
                    }
                   
                }
                Spacer()
                
            }
        }.navigationBarHidden(true)
    }
}

struct SearchedItemDetailListView_Previews: PreviewProvider {
    static var previews: some View {
        SearchedItemDetailListView(dish: SearchDish(dishName: "pizza", imageName: "cheeze_pizza", rating: 5, items: [
            Dish(dishName: "Buffalo chicken pizza", imageName: "Buffalo_chicken_pizza", rating: 5, price: 17),
            Dish(dishName: "Cheeze pizza", imageName: "cheeze_pizza", rating: 5, price: 18),
            Dish(dishName: "french_bread_pizza", imageName: "french_bread_pizza", rating: 5, price: 25),
            Dish(dishName: "Neapolitan pizza", imageName: "neapolitan-pizza", rating: 5, price: 18),
            Dish(dishName: "Rotisserie pizza", imageName: "RotisseriePizza", rating: 5, price: 19),
            Dish(dishName: "Spicy chicken pizza", imageName: "spicy_chicken_pizza", rating: 5, price: 22),
            Dish(dishName: "Lazania", imageName: "lazania", rating: 5, price: 17),
        ]))
    }
}
