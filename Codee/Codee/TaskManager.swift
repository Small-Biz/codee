//
//  TaskManager.swift
//  Codee
//
//  Created by Ray Cheng on 7/9/2022.
//

import UIKit

class TaskManager: NSObject {

    static let shared = TaskManager()
    
    override
    private init() {
        print("Manager initialized")
    }
    
    func getFullTaskList() -> Array<Task> {
        
        var taskList = [Task]()
        
        taskList.append( Task(taskId: 0, level: 0, type: "counting", numFactor: 3, random: false, maxQuestionNum: 3, name: "Counting to 3" ) )
        taskList.append( Task(taskId: 1, level: 0, type: "counting", numFactor: 5, random: false, maxQuestionNum: 3, name: "Counting to 5" ) )
        taskList.append( Task(taskId: 2, level: 0, type: "counting", numFactor: 10, random: false, maxQuestionNum: 3, name: "Counting to 10" ) )
        taskList.append( Task(taskId: 3, level: 0, type: "counting", numFactor: 20, random: false, maxQuestionNum: 3, name: "Counting to 20" ) )
        taskList.append( Task(taskId: 4, level: 0, type: "plus", numFactor: 5, random: false, maxQuestionNum: 5, name: "Add to 5" ) )
        taskList.append( Task(taskId: 5, level: 0, type: "plus", numFactor: 10, random: false, maxQuestionNum: 5, name: "Add to 10" ) )
        
        
        taskList.append( Task(taskId: 6, level: 1, type: "plus", numFactor: 20, random: false, maxQuestionNum: 10, name: "Add to 20" ) )
        taskList.append( Task(taskId: 7, level: 1, type: "plus", numFactor: 50, random: false, maxQuestionNum: 10, name: "Add to 50" ) )
        taskList.append( Task(taskId: 8, level: 1, type: "minus", numFactor: 5, random: false, maxQuestionNum: 5, name: "Minus with 5" ) )
        taskList.append( Task(taskId: 9, level: 1, type: "minus", numFactor: 10, random: false, maxQuestionNum: 5, name: "Minus with 10" ) )
        taskList.append( Task(taskId: 10, level: 1, type: "minus", numFactor: 30, random: false, maxQuestionNum: 10, name: "Minus with 30" ) )
        taskList.append( Task(taskId: 11, level: 1, type: "minus", numFactor: 50, random: false, maxQuestionNum: 10, name: "Minus with 50" ) )
        
        
        taskList.append( Task(taskId: 12, level: 2, type: "multipy", numFactor: 2, random: false, maxQuestionNum: 7, name: "Multiply by 2" ) )
        taskList.append( Task(taskId: 13, level: 2, type: "multipy", numFactor: 3, random: false, maxQuestionNum: 7, name: "Multiply by 3" ) )
        taskList.append( Task(taskId: 14, level: 2, type: "multipy", numFactor: 4, random: false, maxQuestionNum: 7, name: "Multiply by 4" ) )
        taskList.append( Task(taskId: 15, level: 2, type: "multipy", numFactor: 5, random: false, maxQuestionNum: 7, name: "Multiply by 5" ) )
        taskList.append( Task(taskId: 16, level: 2, type: "multipy", numFactor: 5, random: true, maxQuestionNum: 20, name: "Multiplication facts up to 5" ) )
        taskList.append( Task(taskId: 17, level: 2, type: "multipy", numFactor: 6, random: false, maxQuestionNum: 7, name: "Multiply by 6" ) )
        taskList.append( Task(taskId: 18, level: 2, type: "multipy", numFactor: 7, random: false, maxQuestionNum: 7, name: "Multiply by 7" ) )
        taskList.append( Task(taskId: 19, level: 2, type: "multipy", numFactor: 8, random: false, maxQuestionNum: 7, name: "Multiply by 8" ) )
        taskList.append( Task(taskId: 20, level: 2, type: "multipy", numFactor: 9, random: false, maxQuestionNum: 7, name: "Multiply by 9" ) )
        taskList.append( Task(taskId: 21, level: 2, type: "multipy", numFactor: 9, random: true, maxQuestionNum: 20, name: "Multiplication facts up to 9" ) )
                
        return taskList;
    }
    
    func getTaskList(level: Int) -> Array<Task> {
        
        let taskList = TaskManager.shared.getFullTaskList()
        var resultTaskList = [Task]()
        
        
        for i in 0...taskList.count-1{
            if ( taskList[i].level==level){
                resultTaskList.append(taskList[i])
            }
        }
        
        return resultTaskList;
    }
        
}
