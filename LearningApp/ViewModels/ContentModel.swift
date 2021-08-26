//
//  ContentModel.swift
//  LearningApp
//
//  Created by stella on 2021/8/26.
//

import Foundation

class ContentModel:ObservableObject{
    
    @Published var modules = [Module]()
    //nil to begin with
    var styleData:Data?
    
    init(){
        getLocalData()
    }
    
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
    
}
