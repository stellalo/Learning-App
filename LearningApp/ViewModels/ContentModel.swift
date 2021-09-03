//
//  ContentModel.swift
//  LearningApp
//
//  Created by stella on 2021/8/26.
//

import Foundation

class ContentModel:ObservableObject{
    
    //list of modules
    @Published var modules = [Module]()
    
    //Current module
    @Published var currentModule:Module? //optional
    var currentModuleIndex=0
    
    //current lesson
    @Published var currentLesson:Lesson? //optional
    var currentLessonIndex=0
    
    //current question
    @Published var currentQuestion:Question?
    var currentQuestionIndex = 0
    
    //current lesson explanation
    @Published var codeText = NSAttributedString()
    //nil to begin with
    var styleData:Data?
    
    //Current selected content and test
    @Published var currentContentSelected:Int?
    @Published var currentTestSelected:Int?
    
    init(){
        getLocalData()
    }
    
    //MARK: data methods
    
   
    
    func getLocalData(){
        //get a url to the json file
        let jsonUrl = Bundle.main.url(forResource: "data", withExtension: "json")
        //read file into data object
        do{
            let jsonData = try Data(contentsOf: jsonUrl!)
            //decode json into an array of modules
            let jsonDecoder = JSONDecoder()
            let modules = try jsonDecoder.decode([Module].self, from: jsonData)
            //assign parsed modules to module properties
            self.modules = modules
        }
        catch{
            print("Couldn't parse local data")
            print(error)
        }
        //parse style data
        let styleUrl = Bundle.main.url(forResource: "style", withExtension: "html")
        do{
            //read data into file objects
            let styleData = try Data(contentsOf: styleUrl!)
            self.styleData=styleData
        }
        catch{
            print("Couldn't parse style data")
        }
    }
    
    //MARK: module navigation methods
    func beginModule(moduleId: Int){
        //find index for this module id
        for index in 0..<modules.count{
            if modules[index].id == moduleId{
                currentModuleIndex=index
                break
            }
        }
        //set the current module
        currentModule=modules[currentModuleIndex]
    }
    
    func beginLesson(lessonIndex:Int){
        //check lesson index is withon range of module lessons
        if (lessonIndex < currentModule!.content.lessons.count) {
            currentLessonIndex = lessonIndex
        }
        else{
            currentLessonIndex=0
        }
        //set the current lesson
        currentLesson = currentModule!.content.lessons[currentLessonIndex]
        codeText = addStyling(htmlString: currentLesson!.explanation)
    }
    func nextLesson(){
        //advance to next lesson index
        currentLessonIndex += 1
        //check that it is within range
        if (currentLessonIndex < currentModule!.content.lessons.count) {
            //set the curent lesson property
            currentLesson = currentModule!.content.lessons[currentLessonIndex]
            codeText = addStyling(htmlString: currentLesson!.explanation)
        }
        else{
            //reset the lesson state
            currentLessonIndex = 0
            currentLesson = nil
        }
    }
    
    func hasNextLesson()->Bool{
        return (currentLessonIndex + 1 < currentModule!.content.lessons.count)
    }
    
    func beginTest(moduleId: Int){
        //set the current module
        beginModule(moduleId: moduleId)
        //set the current question
        currentQuestionIndex = 0
        //if there are questions, set the current question to the first one
        if currentModule?.test.questions.count ?? 0 > 0{
            currentQuestion = currentModule!.test.questions[currentQuestionIndex]
            //set the content question
            codeText = addStyling(htmlString: currentQuestion!.content)
        }
    }
    
    func nextQuestion(){
        //Advance the question index
        currentQuestionIndex += 1
        //Check that it is within the range o questions
        if (currentQuestionIndex < currentModule!.test.questions.count) {
            //set the current question
            currentQuestion = currentModule!.test.questions[currentQuestionIndex]
            codeText = addStyling(htmlString: currentQuestion!.content)
        }
        else{
            //if not then reset the properties
            currentQuestion = nil
            currentQuestionIndex = 0
        }
    }
    
    //MARK: code styling
    private func addStyling(htmlString: String) -> NSAttributedString{
        var resultString = NSAttributedString()
        var data = Data()
        //add styling data
        if styleData != nil{
            data.append(self.styleData!)
        }
        //add html data
        data.append(Data(htmlString.utf8))
        //convert to attributed string
        if let attributedString = try? NSAttributedString(data: data, options: [.documentType: NSAttributedString.DocumentType.html], documentAttributes: nil){
            resultString = attributedString
        }
       
        return resultString
    }
}
