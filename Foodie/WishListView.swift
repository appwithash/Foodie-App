//
//  WishListView.swift
//  Foodie
//
//  Created by ashutosh on 08/07/21.
//

import SwiftUI

struct WishListView: View {
    @EnvironmentObject var myWishList : WishList
    var body: some View {
        NavigationView{
        ZStack{
            
            Color.background.ignoresSafeArea()
            VStack(alignment:.leading){
                Text("Wishlist").foregroundColor(.white).font(.custom("Verdana", size: 25))
                  .padding(.leading)
                    .padding(.top)
                    .padding(.top)
                ScrollView(.vertical, showsIndicators: false, content: {
                LazyVGrid(columns: [GridItem(.fixed(Screen.maxWidth*0.45)),GridItem(.fixed(Screen.maxWidth*0.45))], content: {
                    ForEach(myWishList.dishes){dish in
                        
                       DishCell(dish: dish)
                    }
                })
                })
            
            }.navigationBarHidden(true)
        }
        }
    }
    
}

struct WishListView_Previews: PreviewProvider {
    static var previews: some View {
        WishListView().environmentObject(WishList(dishes: []))
    }
}
