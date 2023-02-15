//
//  TaskCell.swift
//  TaskProject
//
//  Created by Abdoulaye Aliou SALL on 13/02/2023.
//

import SwiftUI

struct TaskCell: View {
    let task:Tasks
    var body: some View {
        HStack{
            Text(task.name)
                .font(.title2)
            Spacer()
            Image(systemName: task.isDone ? "checkmark":"circle")
                .font(.title)
        }.padding()
    }
}

struct TaskCell_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            TaskCell(task: Tasks(name: "Changer le monde"))
            TaskCell(task: Tasks(name: "Changer le monde", isDone: true))
        }
        .previewLayout(.fixed(width: 500.0, height: 100.0))
    }
}
