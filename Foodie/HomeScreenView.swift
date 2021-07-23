//
//  ContentView.swift
//  Foodie
//
//  Created by ashutosh on 04/07/21.
//

import SwiftUI

struct HomeScreenView: View {
  
    var dishes  = WishList(dishes: [
        Dish(dishName: "Tangeries Pancake", imageName: "tangeriesPancake", rating: 5, price: 10),
        Dish(dishName: "Pancake", imageName: "pancake", rating: 5, price: 15),
        Dish(dishName: "Spaghetti", imageName: "spaghetti", rating: 5, price: 15),
        Dish(dishName: "Zucchini Roll", imageName: "zucchini_roll", rating: 5, price: 20),
        Dish(dishName: "Chocolate Croissant", imageName: "chocolate_croissant", rating: 5, price: 18),
        Dish(dishName: "Butter Chicken", imageName: "butter-chicken", rating: 5, price: 18),
        Dish(dishName: "Lazania", imageName: "lazania", rating: 5, price: 19),
    ])
    var gridVIew = [GridItem(.fixed(Screen.maxWidth*0.45)),GridItem(.fixed(Screen.maxWidth*0.45)),]
   @State var searchText = ""
    var body: some View {
        ZStack{
            Color.background.ignoresSafeArea()
            VStack(alignment:.leading,spacing:Screen.maxHeight*0.02){
        Image("appName")
            .resizable()
            .frame(width: Screen.maxWidth*0.2, height: Screen.maxHeight*0.03, alignment: .center)
                ScrollView(.vertical, showsIndicators: false){
            VStack(alignment:.leading,spacing:Screen.maxHeight*0.02){
            Text("What you want to order today?").font(.custom("Verdana", size: 20)).foregroundColor(.white)
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
                            .frame(width: Screen.maxWidth*0.06, height: Screen.maxHeight*0.003, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
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
                Text("Popular").font(.custom("Verdana", fixedSize: 16)).foregroundColor(.white)
                LazyVGrid(columns: gridVIew) {
                    ForEach(self.dishes.dishes){dish in
                                DishCell(dish: dish)
                    }
                }
            }
            }.navigationBarHidden(true)
        }.padding(.leading).padding(.trailing)
    }
    }
}

struct DishCell : View{
    @ObservedObject var dish : Dish
    @EnvironmentObject var myCart : CartList
    @EnvironmentObject var wishList : WishList
    var body: some View{
        ZStack{
            NavigationLink(
                destination: DetailDishView(dish: dish),
                label: {
            Image(dish.imageName)
                .resizable()
                })
            GeometryReader{g in
            VStack(alignment : .leading){
                ZStack{
                    VisualEffectView(effect: UIBlurEffect(style: .systemUltraThinMaterialDark))
                    Image(systemName: self.dish.isLiked ? "heart.fill" : "heart").foregroundColor(.white)
                }.frame(width: Screen.maxWidth*0.1, height:  Screen.maxWidth*0.1, alignment: .center)
                .cornerRadius(10)
                .padding(.top,10).padding(.leading,10)
                .onTapGesture {
                    self.dish.isLiked.toggle()
                    if self.dish.isLiked{
                        self.wishList.dishes.append(dish)
                    }else{
                        self.wishList.dishes = self.wishList.dishes.filter({$0.dishName != dish.dishName})
                    }
                }
                Spacer()
                ZStack{
                    VisualEffectView(effect: UIBlurEffect(style: .systemUltraThinMaterialDark))
                    HStack{
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
                        Text("$\(self.dish.price)").font(.custom("Verdana", size: 18)).foregroundColor(.orange).padding(.trailing,9)
                    }
                  
                }.frame(width: Screen.maxWidth*0.45, height: Screen.maxHeight*0.07, alignment: .center)
                .cornerRadius(Screen.maxWidth*0.05)
            }
            }
        }.frame(height: Screen.maxHeight*0.25, alignment: .center)
        .cornerRadius(Screen.maxWidth*0.05)
        .shadow(radius: 10)
    }
}
class Dish : ObservableObject,Identifiable{
    let id = UUID()
    let dishName : String
    let imageName : String
    var rating : Float
    var price : Int
    @Published var count = 1
    @Published var isLiked = false
    @Published var isAddedToCart = false
    init(dishName : String,imageName:String,rating:Float,price:Int){
        self.dishName=dishName
        self.imageName=imageName
        self.rating=rating
        self.price = price
    }
}

class CartList : ObservableObject,Identifiable{
    let id = UUID()
    @Published var dishes : [Dish]=[]
    @Published var total : Int = 0
   
}
class WishList : ObservableObject,Identifiable{
    let id = UUID()
    @Published var dishes : [Dish]=[]
    init(dishes : [Dish]){
        self.dishes=dishes
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        HomeScreenView()
    }
}
