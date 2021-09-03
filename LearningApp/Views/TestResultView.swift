//
//  TestResultView.swift
//  LearningApp
//
//  Created by stella on 2021-09-03.
//

import SwiftUI

struct TestResultView: View {
    
    @EnvironmentObject var model:ContentModel
    var numCorrect:Int
    var resultHeading:String{
        guard model.currentModule != nil else{
            return ""
        }
        let pct = Double(numCorrect)/Double(model.currentModule!.test.questions.count)
        if pct > 0.5{
            return "Awsome!"
        }
        else if pct > 0.2{
            return "Doing great!"
        }
        else{
            return "Keep learning."
        }
    }
    
    var body: some View {
        VStack{
            Spacer()
            Text(resultHeading).font(.title)
            Spacer()
            Text("You got \(numCorrect) out of \(model.currentModule?.test.questions.count ?? 0) questions")
            Spacer()
            Button{
                //Send user back to homeView
                model.currentTestSelected = nil
            }label:{
                ZStack{
                    RectangleCard(color: .green).frame(height:48)
                    Text("Complete").bold().foregroundColor(.white)
                }
            }.padding()
            Spacer()
        }
    }
}
