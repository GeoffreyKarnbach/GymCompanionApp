//
//  ExerciseExecutionRecapView.swift
//  Gym Companion App
//
//  Created by Geoffrey Karnbach on 04.07.24.
//

import SwiftUI
import SwiftData

struct ExerciseExecutionRecapView: View {
    
    var exerciseExec : ExerciseExecution
    
    var body: some View {
        VStack(alignment: .leading) {
            Spacer()
            VStack(alignment: .leading) {
                Label {
                    Text(exerciseExec.exercise?.fullName ?? "Übung Name")
                        .font(.headline)
                } icon: {
                    Image(systemName: exerciseExec.exercise?.iconName ?? "dumbbell")
                        .foregroundColor(.primary)
                }
                Divider()
                ForEach(exerciseExec.exerciseExecutionSets ?? [], id: \.self) { executionSet in
                    let repPluralText = executionSet.reps == 1 ? "Wiederholung" : "Wiederholungen"
                    Text("\(executionSet.reps) \(repPluralText) zu \(executionSet.weight, specifier: "%.1f") kg")
                    Divider()
                }
                Text("Ausführung: " + (exerciseExec.executionScore?.description ?? "DEFAULT"))
                Text("Erschöpfung: " + (exerciseExec.exhaustScore?.description ?? "DEFAULT"))
            }
            .padding() // Add padding inside the VStack
            .background(Color.gray.opacity(0.2)) // Set a greyish background
            .cornerRadius(10) // Optional: add corner radius for rounded corners
            .padding(.trailing, 15)

            Spacer()
        }
        .padding(.leading, 15)
        .padding(.top, 15)
    }
}

#Preview {
    ZStack {
        var descriptor = FetchDescriptor<ExerciseExecution>(predicate: #Predicate { $0.exhaustScore == 1})
        
        let exExec = try! PreviewContainerGenerator.previewContainer.mainContext.fetch(
            descriptor
        )
        
        ExerciseExecutionRecapView(exerciseExec: exExec.first!)
            .modelContainer(PreviewContainerGenerator.previewContainer)
    }
}
