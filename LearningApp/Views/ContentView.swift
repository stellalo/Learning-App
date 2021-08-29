//
//  ContentView.swift
//  LearningApp
//
//  Created by stella on 2021/8/26.
//

import SwiftUI

struct ContentView: View {
    
    @EnvironmentObject var model:ContentModel
    
    var body: some View {
        ScrollView{
            LazyVStack{
                //confirm that current module is set
                if model.currentModule != nil{
                    ForEach (0..<model.currentModule!.content.lessons.count) {index in
                        NavigationLink(
                            destination: ContentDetailView().onAppear(perform: {
                                model.beginLesson(lessonIndex: index)
                            }),
                            label: {
                                contentViewRow(index:index)
                            })
                        
                    }
                }
               
            }.accentColor(.black).padding().navigationBarTitle("Learn \(model.currentModule?.category ?? "")")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
