//
//  MainView.swift
//  Foodie
//
//  Created by ashutosh on 04/07/21.
//

import SwiftUI

struct MainView: View {
    @State var seletedTab = 1
    var body: some View {
        NavigationView{
        ZStack{
            Color.background.ignoresSafeArea(.all)
            switch seletedTab{
            case 1 :   HomeScreenView()
            case 2 :   SearchView()
            case 3 :   CartScreenView()
            case 4 :   ProfileScreenView()
                
            default: EmptyView()
            }
            VStack{
            Spacer()
                BottomTabBar(selectedTab: $seletedTab)
                    .foregroundColor(.searchBar)
                    .offset(y:Screen.maxHeight*0.039)
            }
        }
        }.navigationBarHidden(true)
    }
}

struct BottomTabBar : View{
    @Binding var selectedTab : Int
    var body : some View{
        HStack{
            Spacer()
            ZStack{
                Capsule()
                    .frame(width:selectedTab==1 ? Screen.maxWidth*0.3 : Screen.maxHeight*0.05, height: Screen.maxHeight*0.05, alignment: .center)
                    .foregroundColor(self.selectedTab==1 ? .background : .searchBar)
                    .animation(Animation.easeIn.speed(2))
                HStack{
                    Image(systemName: "house")
                .font(.system(size: 18))
                        .foregroundColor(self.selectedTab==1 ? .white : .gray)
                    if(self.selectedTab==1){
                    Text("Home")
                        .font(.custom("Verdana", size: 14)).foregroundColor(.white)
                    }
                }  .animation(Animation.easeIn.speed(2))
            }.onTapGesture {
                self.selectedTab=1
            }
            Spacer()
            ZStack{
                Capsule()
                    .frame(width:selectedTab==2 ? Screen.maxWidth*0.3 : Screen.maxHeight*0.05, height: Screen.maxHeight*0.05, alignment: .center)
                    .foregroundColor(self.selectedTab==2 ? .background : .searchBar)
                    .animation(Animation.easeIn.speed(2))
                HStack{
                    Image(systemName: "magnifyingglass")
                .font(.system(size: 18))
                        .foregroundColor(self.selectedTab==2 ? .white : .gray)
                    if(self.selectedTab==2){
                    Text("Search")
                        .font(.custom("Verdana", size: 14)).foregroundColor(.white)
                    }
                }  .animation(Animation.easeIn.speed(2))
            }.onTapGesture {
                self.selectedTab=2
            }
            Spacer()
            ZStack{
                Capsule()
                    .frame(width:selectedTab==3 ? Screen.maxWidth*0.3 : Screen.maxHeight*0.05, height: Screen.maxHeight*0.05, alignment: .center)
                    .foregroundColor(self.selectedTab==3 ? .background : .searchBar)
                    .animation(Animation.easeIn.speed(2))
                HStack{
                    Image(systemName: "cart")
                .font(.system(size: 18))
                        .foregroundColor(self.selectedTab==3 ? .white : .gray)
                    if(self.selectedTab==3){
                    Text("Cart")
                        .font(.custom("Verdana", size: 14)).foregroundColor(.white)
                    }
                }  .animation(Animation.easeIn.speed(2))
            }.onTapGesture {
                self.selectedTab=3
            }
            Spacer()
            ZStack{
                Capsule()
                    .frame(width:selectedTab==4 ? Screen.maxWidth*0.3 : Screen.maxHeight*0.05, height: Screen.maxHeight*0.05, alignment: .center)
                    .foregroundColor(self.selectedTab==4 ? .background : .searchBar)
                    .animation(Animation.easeIn.speed(2))
                HStack{
                    Image(systemName: "person")
                .font(.system(size: 18))
                        .foregroundColor(self.selectedTab==4 ? .white : .gray)
                    if(self.selectedTab==4){
                    Text("Profile")
                        .font(.custom("Verdana", size: 14)).foregroundColor(.white)
                    }
                }  .animation(Animation.easeIn.speed(2))
            }.onTapGesture {
                self.selectedTab=4
            }
            Spacer()
        }
        .frame(height: Screen.maxHeight*0.09)
        .background(Color.searchBar)
        .cornerRadius(Screen.maxHeight*0.04)
      
      
    }
}




struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}
