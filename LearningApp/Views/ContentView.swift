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
                        contentViewRow(index:index)
                    }
                }
               
            }.padding().navigationTitle("Learn \(model.currentModule?.category ?? "")")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
