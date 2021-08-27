//
//  ContentDetailView.swift
//  LearningApp
//
//  Created by stella on 2021/8/27.
//

import SwiftUI
import AVKit

struct ContentDetailView: View {
    
    @EnvironmentObject var model:ContentModel
    
    var body: some View {
        
        let lesson = model.currentLesson
        let url = URL(string: constants.videoHostUrl + (lesson?.video ?? ""))  //optional chaining
        VStack{
            //only show video if we get a valid url
            if url != nil{
                VideoPlayer(player: AVPlayer(url: url!)).cornerRadius(10)
            }
            //TO DO: description
            
            //next lesson button
            //show next lesson only if there is a next lesson
            if model.hasNextLesson(){
                Button(action: {
                    //advance the lesson
                    model.nextLesson()
                }, label: {
                    ZStack{
                        Rectangle().foregroundColor(Color.green).cornerRadius(10).shadow(radius: 5).frame(height:48)
                        Text("Next Lesson: \(model.currentModule!.content.lessons[model.currentLessonIndex+1].title)").bold().foregroundColor(Color.white)
                    }.padding()
                    
                })
            }
            
        }
        
        
    }
}

struct ContentDetailView_Previews: PreviewProvider {
    static var previews: some View {
        ContentDetailView()
    }
}
