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
    
    //nil to begin with
    var styleData:Data?
    
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
    }
    func nextLesson(){
        //advance to next lesson index
        currentLessonIndex += 1
        //check that it is within range
        if (currentLessonIndex < currentModule!.content.lessons.count) {
            //set the curent lesson property
            currentLesson = currentModule!.content.lessons[currentLessonIndex]
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
}
