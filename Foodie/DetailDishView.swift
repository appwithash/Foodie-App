//
//  DetailDishView.swift
//  Foodie
//
//  Created by ashutosh on 06/07/21.
//

import SwiftUI

struct DetailDishView: View {
    @EnvironmentObject var myCart : CartList
    @ObservedObject var  dish : Dish
    @State var cartSize : CGFloat = 20
    
    @Environment(\.presentationMode) var presentable
    var body: some View {
        ZStack{
            Color.background.ignoresSafeArea()
            
            VStack{
                ZStack{
                Image(dish.imageName).resizable()
                    .scaledToFill()
                .frame(width: Screen.maxWidth, height: Screen.maxHeight*0.5, alignment: .center)
                    .cornerRadius(Screen.maxWidth*0.07)
                    .ignoresSafeArea()
                    .overlay(
                        VStack{
                        HStack{
                            ZStack{
                                RoundedRectangle(cornerRadius: 15)
                                    .stroke(Color.gray)
                                    .frame(width: Screen.maxWidth*0.12, height: Screen.maxWidth*0.12, alignment: .center)
                                Image(systemName:"arrow.left")
                                    .font(.system(size: 25))
                                    .foregroundColor(.white)
                            }.padding(.leading)
                            .onTapGesture{
                              self.presentable.wrappedValue.dismiss()
                            }
                            Spacer()
                            ZStack{
                                RoundedRectangle(cornerRadius: 15)
                                    .stroke(Color.gray)
                                    .frame(width: Screen.maxWidth*0.12, height: Screen.maxWidth*0.12, alignment: .center)
                                Image(systemName:"bookmark")
                                    .font(.system(size: 20))
                                    .foregroundColor(.white)
                            }.padding(.trailing)
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
                                    Text(dish.dishName).font(.custom("Verdana", fixedSize: 18)).foregroundColor(.white)
                                }.padding(.leading,Screen.maxWidth*0.05)
                                    Text("$\(self.dish.price)").font(.custom("Verdana", size: 20)).foregroundColor(.orange).padding(.trailing,Screen.maxWidth*0.05)
                                }
                              
                            }.frame(width: Screen.maxWidth, height: Screen.maxHeight*0.1, alignment: .center)
                            .cornerRadius(Screen.maxWidth*0.07)
                            .padding(.bottom,Screen.maxHeight*0.02)
                           
                          
                        }
                        
                    )
                  
                }
                VStack(alignment : .leading,spacing:10){
              HStack{
                Text("Restuarant Name : Cook Spot")
                    .foregroundColor(.white).font(.custom("Verdana",size:18))
                    .padding(.leading)
                Spacer()
                }
                HStack{
                      Text("Distance : 2 KM")
                          .foregroundColor(.white).font(.custom("Verdana",size:18))
                          .padding(.leading)
                      Spacer()
                }
                    HStack{
                          Text("Delivery in : 20 min")
                              .foregroundColor(.white).font(.custom("Verdana",size:18))
                              .padding(.leading)
                          Spacer()
                    }
                }.padding(.top)
                Spacer()
                HStack{
                    Button(action: {
                        withAnimation{
                      
                            self.dish.isAddedToCart.toggle()
                            self.myCart.dishes.append(dish)
                        
                        }
                    }, label: {
                        ZStack{
                            RoundedRectangle(cornerRadius: 15)
                                .stroke(Color.gray)
                                .frame(width: Screen.maxWidth*0.4, height: Screen.maxHeight*0.06, alignment: .center)
                            HStack{
                                Text( self.dish.isAddedToCart ? "Added to" : "Add to ")
                                    .font(.custom("Verdana", size: 18)).foregroundColor(.white)
                             
                                Image(systemName:self.dish.isAddedToCart ? "cart.fill" : "cart")
                                    .font(.system(size: 20)).foregroundColor(.white)
                                    .rotationEffect(.degrees(self.dish.isAddedToCart ? 10 : 0))
                                    .animation(Animation.easeOut.delay(0.2))
                                    .rotationEffect(.degrees(self.dish.isAddedToCart ? -10 : 0))
                                    .animation(Animation.easeOut.delay(0.5))
                           
                            }
                           
                        }
                    }).padding(.leading)
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
                  .padding(.trailing)
                
                }
               
            }  .overlay(
                Image(dish.imageName).resizable()
                    .scaledToFill()
                    .scaleEffect(self.dish.isAddedToCart ? 0.06 : 1, anchor: .center)
                    .animation(Animation.easeIn)
                .frame(width: Screen.maxWidth, height: Screen.maxHeight*0.5, alignment: .center)
                    .cornerRadius(Screen.maxWidth*0.07)
                    .ignoresSafeArea()
                    .offset(y:-Screen.maxHeight*0.25)
                    .opacity(self.dish.isAddedToCart ? 1 : 0)
                    .offset(x:self.dish.isAddedToCart ? -Screen.maxWidth*0.17 : 0,y:self.dish.isAddedToCart ? Screen.maxHeight*0.66 : 0)
                    .animation(Animation.easeIn)
                    .opacity(self.dish.isAddedToCart ? 0 : 1)
                    .animation(Animation.easeIn.delay(0.3))
            )
            
          
        }.navigationBarHidden(true)
    }
}

struct DetailDishView_Previews: PreviewProvider {
    static var previews: some View {
        DetailDishView(dish:    Dish(dishName: "Tangeries Pancake", imageName: "tangeriesPancake", rating: 5, price: 15))
    }
}
