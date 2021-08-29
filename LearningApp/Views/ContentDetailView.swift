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
            //description
            CodeTextView()
            //next lesson button
            //show next lesson only if there is a next lesson
            if model.hasNextLesson(){
                Button(action: {
                    //advance the lesson
                    model.nextLesson()
                }, label: {
                    ZStack{
                        RectangleCard(color: .green).frame(height:48)
                        Text("Next Lesson: \(model.currentModule!.content.lessons[model.currentLessonIndex+1].title)").bold().foregroundColor(Color.white)
                    }.padding().navigationBarTitle(lesson?.title ?? "")
                    
                })
            }
            else{
                //show complete button instead
                Button(action: {
                    //take user back to homeView
                    model.currentContentSelected=nil
                }, label: {
                    ZStack{
                        RectangleCard(color: .green).frame(height:48)
                        Text("Complete").bold().foregroundColor(Color.white)
                    }.padding().navigationBarTitle(lesson?.title ?? "")
                    
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
