//
//  TestView.swift
//  LearningApp
//
//  Created by stella on 2021/8/29.
//

import SwiftUI

struct TestView: View {
    
    @EnvironmentObject var model: ContentModel
    
    var body: some View {
        if model.currentQuestion != nil {
            VStack{
                //Question number
                Text("Question \(model.currentQuestionIndex + 1) of \(model.currentModule?.test.questions.count ?? 0 )")
                //Question
                CodeTextView()
                //Answers
                
                //button to complete quiz or submit answer
            }.navigationBarTitle("\(model.currentModule?.category ?? "") Test")
        }
        else{
            //test hasn't loaded yet
            ProgressView()
        }
    }
}

struct TestView_Previews: PreviewProvider {
    static var previews: some View {
        TestView()
    }
}
