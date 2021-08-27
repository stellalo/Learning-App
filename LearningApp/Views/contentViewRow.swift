//
//  contentViewRow.swift
//  LearningApp
//
//  Created by stella on 2021/8/27.
//

import SwiftUI

struct contentViewRow: View {
    
    @EnvironmentObject var model:ContentModel
    var index:Int
    
    var body: some View {
        let lesson = model.currentModule!.content.lessons[index]
        //lesson card
        ZStack(alignment:.leading){
            Rectangle().foregroundColor(.white).cornerRadius(10).frame(height: 66).shadow(radius: 5)
            HStack(spacing:30){
                Text(String(index+1)).bold()
                VStack(alignment:.leading){
                    Text(lesson.title).bold()
                    Text(lesson.duration)
                }
            }.padding()
        }.padding(.bottom,5)
    }
}
