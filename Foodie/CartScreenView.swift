//
//  CartScreenView.swift
//  Foodie
//
//  Created by ashutosh on 05/07/21.
//

import SwiftUI

struct CartScreenView: View {
    @EnvironmentObject var myCart : CartList
    @State var itemCount = 0
    @State var showWishList = false
    var body: some View {
        ZStack{
            Color.background.ignoresSafeArea()
            VStack{
                HStack{
                    Text("My Cart").foregroundColor(.white).font(.custom("Verdana", size: 25)).padding(.leading)
                    Spacer()
                    ZStack{
                        VisualEffectView(effect: UIBlurEffect(style: .light))
                        Button(action: {
                            self.showWishList.toggle()
                        }, label: {
                            Image(systemName: "heart.fill").foregroundColor(.gray)
                        })
                        .sheet(isPresented: $showWishList, content: {
                            WishListView()
                        })
                       
                    }.frame(width: Screen.maxWidth*0.1, height: Screen.maxWidth*0.1, alignment: .center)
                    .cornerRadius(Screen.maxWidth*0.02)
                    .shadow(radius: 10)
                    .padding(.trailing)
            
                }
                if self.myCart.dishes.isEmpty{
                    Spacer()
                    Image(systemName: "cart.badge.plus")
                        .resizable()
                        .foregroundColor(.gray)
                        .frame(width: Screen.maxWidth*0.2, height: Screen.maxWidth*0.2, alignment: .center)
                        .opacity(0.3)
                    Spacer()
                    
                }else{
                ScrollView(.vertical, showsIndicators: false){
                    ForEach(myCart.dishes){dish in
                        CartCell(dish :  dish, itemCount:$itemCount)
                }
                }
                Spacer()
                ZStack{
                VStack(alignment:.leading){
                    
                    HStack{
                        VStack(alignment:.leading){
                            HStack{
                        Text("Total").foregroundColor(.white).font(.custom("Verdana", size: 20)).padding(.leading)
                                Spacer()
                                Text("Price : \(Text("$\(self.myCart.total)").foregroundColor(Color("orange")))").foregroundColor(.white).font(.custom("Verdana", size: 18)).padding(.trailing)
                                
                            }
                            Text("Number of items : \(itemCount)").foregroundColor(.white).font(.custom("Verdana", size: 14)).padding(.leading)
                            
                        }
                    }
                HStack{
                    Spacer()
                    Button(action: {
                      
                    }, label: {
                        ZStack{
                            RoundedRectangle(cornerRadius: 15)
                                .foregroundColor(Color("orange"))
                                
                                .frame(width: Screen.maxWidth*0.4, height: Screen.maxHeight*0.06, alignment: .center)
                                Text("Order").font(.custom("Verdana", size: 18)).foregroundColor(.white)
                            
                        }
                    })
                }
                    
                } .padding(.leading).padding(.trailing)
             
                }.frame(width:Screen.maxWidth*0.95,height: Screen.maxHeight*0.15)
                .background(Color.searchBar)
                .cornerRadius(Screen.maxWidth*0.05)
                .padding(.bottom,Screen.maxWidth*0.15)
                }
            }
        }.onAppear{
            self.myCart.total=0
            for i in 0..<myCart.dishes.count{
                self.itemCount += myCart.dishes[i].count
                self.myCart.total += myCart.dishes[i].count*self.myCart.dishes[i].price
            
            }
        }.navigationBarHidden(true)
    }
}

struct CartCell : View{
    @EnvironmentObject var myCart : CartList
    @ObservedObject var dish : Dish
    @Binding var itemCount : Int
    var body: some View{
        ZStack{
            RoundedRectangle(cornerRadius: Screen.maxWidth*0.03)
            HStack{
            Image(dish.imageName)
                .resizable()
                .frame(width: Screen.maxWidth*0.25, height: Screen.maxWidth*0.2, alignment: .leading)
                .cornerRadius(Screen.maxWidth*0.03)
                VStack(alignment:.leading){
                    Text(dish.dishName).foregroundColor(.white).font(.custom("Verdana", size: 18))
                    HStack{
                        ZStack{
                            VisualEffectView(effect: UIBlurEffect(style: .light))
                                .cornerRadius(Screen.maxWidth*0.02)
                            Image(systemName: "minus")
                                .font(.system(size: 13)).foregroundColor(.white)
                               
                        }
                        .frame(width: Screen.maxWidth*0.06, height:  Screen.maxWidth*0.06, alignment: .center)
                        .onTapGesture {
                            if self.dish.count>=1{
                               
                            self.itemCount=0
                                myCart.total=0
                            self.dish.count-=1
                                if dish.count==0{
                                    myCart.dishes = myCart.dishes.filter({$0.dishName != dish.dishName})
                                }
                                for i in 0..<myCart.dishes.count{
                                    self.itemCount += myCart.dishes[i].count
                                    myCart.total += myCart.dishes[i].count*self.myCart.dishes[i].price
                                   
                                }
                            }
                            
                        }
                        Text("\(dish.count)").foregroundColor(Color("orange")).font(.custom("Verdana", size: 18))
                        ZStack{
                            VisualEffectView(effect: UIBlurEffect(style: .light))
                                .cornerRadius(Screen.maxWidth*0.02)
                            Image(systemName: "plus").font(.system(size: 13)).foregroundColor(.white)
                        }
                        .frame(width: Screen.maxWidth*0.06, height:  Screen.maxWidth*0.06, alignment: .center)
                        .onTapGesture {
                            self.itemCount=0
                            myCart.total=0
                            self.dish.count+=1
                            for i in 0..<myCart.dishes.count{
                                self.itemCount += myCart.dishes[i].count
                                myCart.total += myCart.dishes[i].count*self.myCart.dishes[i].price
                             
                                
                            }
                        }
                        Spacer()
                        Text("$\(dish.count*dish.price)").foregroundColor(Color("orange")).font(.custom("Verdana", size: 20))
                    }
                }.padding(.leading,4)
            }  .padding(.leading).padding(.trailing)
        }.frame(width: Screen.maxWidth*0.95, height: Screen.maxHeight*0.11, alignment: .center)
        .foregroundColor(.searchBar)
        .navigationBarHidden(true)
       
    }
}

struct CartScreenView_Previews: PreviewProvider {
    static var previews: some View {
        CartScreenView().environmentObject(CartList())
    }
}
