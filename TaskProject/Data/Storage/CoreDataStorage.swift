//
//  CoreDataStorage.swift
//  TaskProject
//
//  Created by Abdoulaye Aliou SALL on 13/02/2023.
//

import Foundation
import CoreData

class CoreDataStorage  {
     
    lazy var persistentContainer: NSPersistentContainer = {
           let container = NSPersistentContainer(name: "Tasks")
           container.loadPersistentStores { description, error in
               if let error = error {
                   fatalError("Unable to load persistent stores: \(error)")
               }
           }
           return container
       }()
    
    
    var context: NSManagedObjectContext{
        return persistentContainer.viewContext;
    }
    func fetchTaskList() -> [Tasks] {
        let taskList:[Tasks]
        let fetchRequest: NSFetchRequest<CDTask> = CDTask.fetchRequest()
        if let rawTaskList = try? context.fetch(fetchRequest){
            taskList = rawTaskList.compactMap( {(rawTask: CDTask)->Tasks? in
                print("rawTaskList :\(rawTaskList)")
                return Tasks(fromCoreDataObject: rawTask)
            })
        }else{
            taskList = []
        }
        return taskList
    }
    
    func addNewTask(task : Tasks){
        let newTask = CDTask(context: context)
        newTask.id = task.id
        newTask.name = task.name
        newTask.isDone = task.isDone
        print("saveData() : \(saveData())")
        saveData()
    }
    
    func updateTask(task:Tasks){
        if let existingTask = fetchCDTask(withId: task.id){
            existingTask.name = task.name
            existingTask.isDone = task.isDone
            saveData()
        }
    }
    
    private func fetchCDTask(withId taskId: UUID) -> CDTask?{
        let fetchRequest: NSFetchRequest<CDTask> = CDTask.fetchRequest();
        fetchRequest.predicate = NSPredicate(format: "id == %@", taskId as CVarArg)
        fetchRequest.fetchLimit = 1
        let fetchResult:[CDTask]? = try? context.fetch(fetchRequest)
        print(fetchResult?.first)
        return fetchResult?.first
    }
    
    private func saveData(){
        if context.hasChanges{
            do{
                print("context.hasChanges \(context.hasChanges)")
                try context.save()
            }catch{
                print("error : \(error.localizedDescription) pendant la sauvegardes des fichiers" )
            }
            
        }
    }
}

extension Tasks{
    init?(fromCoreDataObject coreDataObject: CDTask){
        guard let id = coreDataObject.id,
        let name = coreDataObject.name else {
            return nil }
        self.id = id
        self.name = name
        self.isDone = coreDataObject.isDone
        
    }
}
