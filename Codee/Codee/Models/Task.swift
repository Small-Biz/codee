//
//  Task.swift
//  Codee
//
//  Created by Ray Cheng on 2/9/2022.
//

import Foundation

class Task{
    
    var taskId: Int!
    var level:Int!
    var type: String!
    var numFactor: Int!
    var random: Bool!
    var name: String!
    var description: String!
    var maxQuestionNum: Int!
    
    required init?(){}
    
    required init(taskId: Int, level: Int, type: String, numFactor: Int, random: Bool, maxQuestionNum: Int, name: String){
        self.taskId=taskId;
        self.level=level;
        self.type=type;
        self.numFactor=numFactor;
        self.random=random;
        self.name=name;
        self.maxQuestionNum=maxQuestionNum;
        self.description="";
    }
    
    required init(taskId: Int, level: Int, type: String, numFactor: Int, random: Bool, name: String, description: String ){
        self.taskId=taskId;
        self.level=level;
        self.type=type;
        self.numFactor=numFactor;
        self.random=random;
        self.name=name;
        self.description=description;
    }
    
}
