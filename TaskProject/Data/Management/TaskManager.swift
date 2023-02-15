//
//  TaskManager.swift
//  TaskProject
//
//  Created by Abdoulaye Aliou SALL on 13/02/2023.
//

import Foundation

struct TaskManager{
    var taskList:[Tasks]
    let storage : CoreDataStorage = CoreDataStorage()
    
    init() {
        taskList = storage.fetchTaskList()
    }
    
    @discardableResult
    mutating func addTask(withName taskName:String) -> Tasks{
        let newTask = Tasks(name: taskName)
        taskList.append(newTask)
        storage.addNewTask(task: newTask)
        print(newTask)
        return newTask
    }
    
    mutating func toggleTaskStatus(withId taskId:UUID){
        if let taskIndex = taskList.firstIndex(where: {(t)->Bool in t.id == taskId}) {
            taskList[taskIndex].isDone.toggle()
            storage.updateTask(task: taskList[taskIndex])
        }
    }
}
