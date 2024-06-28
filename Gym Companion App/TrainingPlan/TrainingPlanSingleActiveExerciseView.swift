//
//  TrainingPlanSingleActiveExerciseView.swift
//  Gym Companion App
//
//  Created by Geoffrey Karnbach on 27.06.24.
//

import SwiftUI
import SwiftData

struct TrainingPlanSingleActiveExerciseView: View {
    
    @Environment(\.dismiss) private var dismiss
    @Environment(\.modelContext) private var context

    var currentTrainingsPlan: TrainingPlanExecution
    var currentExerciseInTraining: ExerciseInTraining
    
    var currentExerciseExecution: ExerciseExecution = ExerciseExecution(executionScore: nil, exhaustScore: nil, exercise: nil, exerciseExecutionSets: [], exerciseInTraining: nil)
    
    @State var currentExerciseExecutionSets: [ExerciseSet] = []
    @State private var exhaustScore = 1
    @State private var executionScore = 1
        
    var body: some View {
        VStack {
            Text((currentExerciseInTraining.exercise?.fullName  ?? "Default Übung") + " - Aktive Übung")
            Text(currentExerciseInTraining.exercise?.category?.name ?? "Default Kategorie")
            Divider()
            Spacer()
            
            ForEach($currentExerciseExecutionSets, id: \.self) { $set in
                SingleExerciseExecutionSetView(currentSet: $set)
            }
            
            if currentExerciseExecutionSets.count < currentExerciseInTraining.setCount {
                Button("Neues Set"){
                    currentExerciseExecutionSets.append(ExerciseSet(set: ExerciseExecutionSet(reps: currentExerciseInTraining.repCount, weight: currentExerciseInTraining.weight, exerciseExecution: nil), isViewingMode: false, isCompleted: false))
                }
                Spacer()
            } else {
                Spacer()

                HStack {
                    Text("Ausführung:")
                        .padding(.leading, 10)
                    Picker("Ausführung:", selection: $executionScore) {
                        ForEach(1..<6) {
                            Text("\($0)").tag($0)
                        }
                    }
                    .pickerStyle(SegmentedPickerStyle())
                    .padding()
                }

                HStack {
                    Text("Erschöpfung:")
                        .padding(.leading, 10)
                    Picker("Erschöpfung:", selection: $exhaustScore) {
                        ForEach(1..<6) {
                            Text("\($0)").tag($0)
                        }
                    }
                    .pickerStyle(SegmentedPickerStyle())
                    .padding()
                }
                
                HStack {
                    Button("Übung Übersicht") {
                        currentExerciseExecution.exhaustScore = Int32(exhaustScore)
                        currentExerciseExecution.executionScore = Int32(executionScore)
                        
                        var executions : [ExerciseExecutionSet] = []
                        
                        for exec_ in currentExerciseExecutionSets {
                            var temp = exec_.set
                            executions.append(temp)
                        }
                        
                        currentExerciseExecution.exerciseExecutionSets = executions

                        currentExerciseExecution.trainingPlanExecution = currentTrainingsPlan

                        currentExerciseExecution.exercise = currentExerciseInTraining.exercise
                        
                        currentExerciseExecution.exerciseInTraining = currentExerciseInTraining
                        
                        context.insert(currentExerciseExecution)
                        
                        dismiss()
                    }
                    .padding()
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(8)
                    .padding(.top, 20)
                    .padding(.bottom, 10)
                    
                    /**
                    Button("Nächste Übung") {
                        
                    }
                    .padding()
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(8)
                    .padding(.top, 20)
                    .padding(.bottom, 10)
                     **/
                }

            }
            
        }
    }
}

struct SingleExerciseExecutionSetView: View {
    @Binding var currentSet : ExerciseSet
    
    var body: some View {
        Text("TEST")
    }
}

struct ExerciseSet: Hashable {
    var set: ExerciseExecutionSet
    var isViewingMode: Bool
    var isCompleted: Bool
    
    init(set: ExerciseExecutionSet, isViewingMode: Bool, isCompleted: Bool) {
        self.set = set
        self.isViewingMode = isViewingMode
        self.isCompleted = isCompleted
    }
}

#Preview {
    ZStack {
        var descriptor = FetchDescriptor<TrainingPlanExecution>(predicate: #Predicate { $0.endTimeStamp == -1})
        
        let tp1 = try! PreviewContainerGenerator.previewContainer.mainContext.fetch(
            descriptor
        ).first!
        
        var descriptor2 = FetchDescriptor<ExerciseInTraining>(predicate: #Predicate { $0.order == 1})
        
        let exInTraining = try! PreviewContainerGenerator.previewContainer.mainContext.fetch(
            descriptor2
        ).first!
        
        TrainingPlanSingleActiveExerciseView(
            currentTrainingsPlan: tp1 ,
            currentExerciseInTraining: exInTraining
        )
            .modelContainer(PreviewContainerGenerator.previewContainer)
    }

}

