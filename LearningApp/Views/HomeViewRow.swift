//
//  HomeViewRow.swift
//  LearningApp
//
//  Created by stella on 2021/8/26.
//

import SwiftUI

struct HomeViewRow: View {
    
    var image:String
    var title:String
    var description:String
    var count:String
    var time:String
    
    var body: some View {
        ZStack{
            Rectangle().foregroundColor(.white).cornerRadius(10).shadow(radius: 5).aspectRatio(CGSize(width: 335, height: 175),contentMode: .fit)
            HStack{
                //image
                Image(image).resizable().frame(width: 160, height: 160).clipShape(/*@START_MENU_TOKEN@*/Circle()/*@END_MENU_TOKEN@*/)
                
                Spacer()
                
                //text
                VStack(alignment:.leading,spacing:10){
                    //headline
                    Text(title).bold()
                    //description
                    Text(description).font(.caption).padding(.bottom, 20)
                    //icons
                    HStack{
                        //number of lessons/questions
                        Image(systemName: "text.book.closed")
                            .resizable().frame(width: 15, height: 15)
                        Text(count).font(Font.system(size:10))
                        Image(systemName: "clock").resizable().frame(width: 15, height: 15)
                        Text(time).font(Font.system(size:10))
                    }
                }
            }.padding(.horizontal,20)
        }
    }
}

struct HomeViewRow_Previews: PreviewProvider {
    static var previews: some View {
        HomeViewRow(image: "swift", title: "Learn swift", description: "some description", count: "10 lessons", time: "2 hours")
    }
}
