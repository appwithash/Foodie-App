//
//  SearchView.swift
//  Foodie
//
//  Created by ashutosh on 05/07/21.
//

import SwiftUI

struct SearchView: View {
    var frequentlySearchList : [SearchDish]=[
        SearchDish(dishName: "Pizzas", imageName: "Buffalo_chicken_pizza", rating: 5, items: [
            Dish(dishName: "Buffalo chicken pizza", imageName: "Buffalo_chicken_pizza", rating: 5, price: 1),
            Dish(dishName: "Cheeze pizza", imageName: "cheeze_pizza", rating: 5, price: 1),
            Dish(dishName: "french_bread_pizza", imageName: "french_bread_pizza", rating: 5, price: 2),
            Dish(dishName: "Neapolitan pizza", imageName: "neapolitan-pizza", rating: 5, price: 1),
            Dish(dishName: "Rotisserie pizza", imageName: "RotisseriePizza", rating: 5, price: 2),
            Dish(dishName: "Spicy chicken pizza", imageName: "spicy_chicken_pizza", rating: 5, price: 1),
            Dish(dishName: "Lazania", imageName: "lazania", rating: 5, price: 2),
        ]),
        SearchDish(dishName: "Pancakes", imageName: "pancake", rating: 5, items: []),
        SearchDish(dishName: "Spaghettis", imageName: "spaghetti", rating: 5, items: []),
        SearchDish(dishName: "Zucchini Rolls", imageName: "zucchini_roll", rating: 5, items: []),
        SearchDish(dishName: "Chocolate Croissant", imageName: "chocolate_croissant", rating: 5, items: []),
        SearchDish(dishName: "Cakes", imageName: "chocolateCake", rating: 5, items: []),
        SearchDish(dishName: "Lazanias", imageName: "lazania", rating: 5, items: []),
    ]
    var gridVIew = [GridItem(.fixed(Screen.maxWidth*0.45)),GridItem(.fixed(Screen.maxWidth*0.45)),]
    @State var searchText = ""
    @State var dish =  SearchDish(dishName: "Lazanias", imageName: "lazania", rating: 5, items: [])
    @State var showDetails = false
    var body: some View {
        ZStack{
            Color.background.ignoresSafeArea()
            VStack{
            Text("")
            ScrollView(.vertical, showsIndicators: false){
            VStack(alignment:.leading,spacing: Screen.maxHeight*0.02){
            HStack{
                ZStack{
                    RoundedRectangle(cornerRadius: 15).foregroundColor(.searchBar)
                        .frame(width: Screen.maxWidth*0.6, height: Screen.maxHeight*0.065, alignment: .center)
                    if searchText.isEmpty {
                        Text("Search").foregroundColor(.gray)
                            .offset(x: -Screen.maxWidth*0.2)
                    }
                    TextField( "", text: $searchText).foregroundColor(.blue)
                        .frame(width: Screen.maxWidth*0.54, height: Screen.maxHeight*0.065, alignment: .center)
                        .foregroundColor(.gray)
                        .accentColor(.gray)
                       
                }
                ZStack{
                    RoundedRectangle(cornerRadius: 15)
                        .stroke(Color.bottomBar)
                        .frame(width: Screen.maxHeight*0.065, height: Screen.maxHeight*0.065, alignment: .center)
                    HStack{
                    VStack(spacing:0){
                        Capsule()
                            .frame(width: Screen.maxWidth*0.005, height: Screen.maxHeight*0.007, alignment: .center)
                            .foregroundColor(Color.white)
                        Circle()
                            .stroke(Color.white,lineWidth: 2)
                            .frame(width: 7, height:7, alignment: .center)
                        Capsule()
                            .frame(width: Screen.maxWidth*0.005, height: Screen.maxHeight*0.01, alignment: .center)
                            .foregroundColor(Color.white)
                    }
                        VStack(spacing:0){
                            Capsule()
                                .frame(width: Screen.maxWidth*0.005, height: Screen.maxHeight*0.01, alignment: .center)
                                .foregroundColor(Color.white)
                            
                            Circle()
                                .stroke(Color.white,lineWidth: 2)
                                .frame(width: 7, height:7, alignment: .center)
                            Capsule()
                                .frame(width: Screen.maxWidth*0.005, height: Screen.maxHeight*0.007, alignment: .center)
                                .foregroundColor(Color.white)
                           
                        }
                    }
                }
                ZStack{
                    RoundedRectangle(cornerRadius: 15)
                        .stroke(Color.bottomBar)
                        .frame(width: Screen.maxHeight*0.065, height: Screen.maxHeight*0.065, alignment: .center)
                    VStack(spacing:4){
                        Capsule()
                            .frame(width: Screen.maxWidth*0.06, height: Screen.maxHeight*0.003, alignment: .center)
                            .foregroundColor(Color.white)
                        Capsule()
                            .frame(width: Screen.maxWidth*0.04, height: Screen.maxHeight*0.003, alignment: .center)
                            .foregroundColor(Color.white)
                        Capsule()
                            .frame(width: Screen.maxWidth*0.02, height: Screen.maxHeight*0.003, alignment: .center)
                            .foregroundColor(Color.white)
                    }
                }
        }
                Text("Frequently search").font(.custom("Verdana", size: 15)).foregroundColor(.white)
                LazyVGrid(columns: gridVIew) {
                    ForEach(self.frequentlySearchList){dish in
                        NavigationLink(
                            destination:  SearchedItemDetailListView(dish: dish),
                            label: {
                              SearchDishCell(dish: dish)
                            })
                    }
                }
                if showDetails{
                   // print(dish.dishName)
              
                }
        Spacer()
            }
            }
            }.padding(.leading).padding(.trailing)
        }.navigationBarHidden(true)
    }
}
struct SearchDishCell : View{
    var dish : SearchDish
    var body: some View{
        ZStack{
            Image(dish.imageName)
                .resizable()
         
            VStack(alignment : .leading){

                Spacer()
                ZStack{
                    VisualEffectView(effect: UIBlurEffect(style: .systemUltraThinMaterialDark))
                    VStack(alignment:.leading){
                    HStack(spacing:1){
                        ForEach(0..<5){i in
                            Image(systemName: "star.fill")
                                .font(.system(size: 13))
                                .foregroundColor(.orange)
                        }
                        Text(String(format: "(%.1f)", dish.rating)).font(.custom("Verdana", fixedSize: 14)).foregroundColor(.white)
                          Spacer()
                    }
                        Text(dish.dishName).font(.custom("Verdana", fixedSize: 14)).foregroundColor(.white)
                    }.padding(.leading,10)
                }.frame(width: Screen.maxWidth*0.45, height: Screen.maxHeight*0.07, alignment: .center)
                .cornerRadius(Screen.maxWidth*0.05)
            }
         
        }.frame(height: Screen.maxHeight*0.25, alignment: .center)
        .cornerRadius(Screen.maxWidth*0.05)
        .shadow(radius: 10)
    }
}

struct SearchDish : Identifiable{
    let id = UUID()
    let dishName : String
    let imageName : String
    var rating : Float
    var items : [Dish]
}

struct SearchView_Previews: PreviewProvider {
    static var previews: some View {
        SearchView()
    }
}
