//
//  TaskListView.swift
//  TaskProject
//
//  Created by Abdoulaye Aliou SALL on 13/02/2023.
//

import SwiftUI

struct TaskListView: View {
    @State var newTaskName:String = ""
    @State var taskManager = TaskManager()
//    @State var taskList = [
//        Tasks(name: "Terminer cours SwiftUi"),
//        Tasks(name: "preparer prochain defi Purple Giraffe"),
//        Tasks(name: "Commencer le cours secret")
//    ]
    var body: some View {
        VStack{
            HStack{
                TextField("nouvelle tache", text: $newTaskName)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                Button(action: createNewTask, label: {
                    Image(systemName: "plus")
                }).disabled(newTaskName.count == 0)
            }.padding()
            
            VStack(alignment: HorizontalAlignment.leading){
                ForEach(taskManager.taskList) { task in
                    TaskCell(task: task)
                        .onTapGesture {
                            userTappedTask(task)
                        }
                }
            }
            Spacer()
        }.padding()
    }
    
    func createNewTask(){
        if newTaskName.count > 0{
            print(newTaskName.count)
            taskManager.addTask(withName: newTaskName)
            newTaskName = ""
        }
    }
    
    
    func userTappedTask(_ task:Tasks){
        taskManager.toggleTaskStatus(withId: task.id)
    }
}

struct TaskListView_Previews: PreviewProvider {
    static var previews: some View {
        TaskListView()
    }
}
