//
//  TestView.swift
//  LearningApp
//
//  Created by stella on 2021/8/29.
//

import SwiftUI

struct TestView: View {
    
    @EnvironmentObject var model: ContentModel
    @State var selectedAnswerIndex:Int?
    @State var numCorrect = 0
    @State var submitted = false
    
    var body: some View {
        if model.currentQuestion != nil {
            VStack(alignment: .leading){
                //Question number
                Text("Question \(model.currentQuestionIndex + 1) of \(model.currentModule?.test.questions.count ?? 0 )").padding(.leading, 20)
                //Question
                CodeTextView().padding(.leading, 20)
                //Answers
                ScrollView{
                    VStack{
                        ForEach(0..<model.currentQuestion!.answers.count, id: \.self){ index in
                            
                            Button {
                                //Track selected index
                                selectedAnswerIndex = index
                            } label: {
                                ZStack{
                                    if submitted == false{
                                        RectangleCard(color: index == selectedAnswerIndex ? .gray: .white).foregroundColor(.white).frame(height:48)
                                    }
                                    else{
                                        //answer submitted
                                        if index == selectedAnswerIndex && index == model.currentQuestion!.correctIndex{
                                            RectangleCard(color: .green).frame(height:48)
                                        }
                                        else if (index == selectedAnswerIndex && index != model.currentQuestion!.correctIndex){
                                            //user selected wrong answer
                                            RectangleCard(color: .red).frame(height:48)
                                        }
                                        else if (index == model.currentQuestion!.correctIndex){
                                            //this button is correct answer
                                            RectangleCard(color: .green).frame(height:48)
                                        }
                                        else{
                                            RectangleCard(color: .white).frame(height:48)
                                        }
                                    }
                                    Text(model.currentQuestion!.answers[index])
                                }
                            }.disabled(submitted)
                        }
                    }.accentColor(.black).padding()
                }
                //button to complete quiz or submit answer
                Button{
                    //check if answer has been submitted
                    if submitted == true {
                        //answer has already been submitted, move to next question
                        model.nextQuestion()
                        //Reset properties
                        submitted = false
                        selectedAnswerIndex = nil
                    }
                    else{
                        //Submit the answer
                        //change submitted state to true
                        submitted = true
                        //check answer and increment counter if correct
                        if selectedAnswerIndex == model.currentQuestion!.correctIndex{
                            numCorrect+=1
                        }
                    }
                }label: {
                    ZStack{
                        
                        RectangleCard(color: .green).frame(height: 48)
                        Text(buttonText).bold().foregroundColor(.white)
                    }.padding()
                }.disabled(selectedAnswerIndex == nil)
            }.navigationBarTitle("\(model.currentModule?.category ?? "") Test")
        }
        else{
            //test hasn't loaded yet
            ProgressView()
        }
    }
    var buttonText: String{
        //check if answer has been submitted
        if submitted == true{
            if (model.currentQuestionIndex+1 == model.currentModule!.test.questions.count){
                //this is the last question
                return "Finish"
            }
            else{
                return "Next"
            }
        }
        else{
            return "Submit"
        }
    }
}

struct TestView_Previews: PreviewProvider {
    static var previews: some View {
        TestView()
    }
}
