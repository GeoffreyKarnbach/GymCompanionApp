//
//  TrainingPlanActiveView.swift
//  Gym Companion App
//
//  Created by Geoffrey Karnbach on 26.06.24.
//

import SwiftUI
import SwiftData

struct TrainingPlanActiveView: View {
    @State var currentTrainingPlanExecution: TrainingPlanExecution? = nil
    @Environment(\.modelContext) private var context
    @AppStorage("activeTrainingID") private var activeTrainingID: String = ""
    @State var exercisesDoneInCurrentTP : [String] = []
    @State private var shouldShowRecapScreen = false

    
    var body: some View {
        NavigationStack {
            VStack {
                Text(currentTrainingPlanExecution?.trainingsPlan?.name ?? "NAME")
                Text(currentTrainingPlanExecution?.trainingsPlan?.days ?? "TAGE")
                
                if let exercises = currentTrainingPlanExecution?.trainingsPlan?.exerciseInTraining {
                    List {
                        ForEach(exercises.sorted(by: {
                            $0.order < $1.order
                        }), id: \.self) { exercise in
                            let isCompleted = exercisesDoneInCurrentTP.contains(exercise.exercise?.eID ?? "")

                            
                            if isCompleted {
                                TrainingsPlanSingleExerciseView(exercise: exercise, isActiveTrainingView: true, exerciseCompleted: true)
                                    .padding(.horizontal)
                            } else {
                                NavigationLink(destination: TrainingPlanSingleActiveExerciseView(
                                    currentTrainingsPlan: currentTrainingPlanExecution!, currentExerciseInTraining: exercise
                                )) {
                                    TrainingsPlanSingleExerciseView(exercise: exercise, isActiveTrainingView: true, exerciseCompleted: false)
                                        .padding(.horizontal)
                                }
                            }
                        }
                    }
                    .onAppear {
                        computeDoneExercises()
                    }
                }
                
                let formattedTime = {
                    let timestamp = currentTrainingPlanExecution?.startTimeStamp ?? 0
                    let date = Date(timeIntervalSince1970: TimeInterval(timestamp))
                    let temp = DateFormatter()
                    temp.dateFormat = "HH:mm"
                    return temp.string(from: date)
                }
                
                Text("Startuhrzeit: " + formattedTime())
                
                let timeDifference = {
                    let timestamp = currentTrainingPlanExecution?.startTimeStamp ?? 0
                    
                    let difference = Date().timeIntervalSince(Date(timeIntervalSince1970: TimeInterval(timestamp)))
                    
                    let hours = Int(difference / 3600)
                    let minutes = Int((difference / 60).truncatingRemainder(dividingBy: 60))
                    
                    // Format the time difference as "hh:mm"
                    let formattedTime = String(format: "%02d:%02d", hours, minutes)
                    
                    return formattedTime
                    
                }
                Text("Dauer: " + timeDifference())
                
                HStack {
                    Button("Training abschließen") {
                        currentTrainingPlanExecution?.endTimeStamp = Int32(Date().timeIntervalSince1970)
                        shouldShowRecapScreen = true
                    }
                    .padding()
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(8)
                    .padding(.top, 20)
                    .padding(.bottom, 10)
                    .navigationDestination(isPresented: $shouldShowRecapScreen) {
                        TrainingPlanExecutionRecapView(tpExecution: currentTrainingPlanExecution!)
                    }

                    Button("Training abbrechen") {
                        
                        
                        if let curr = currentTrainingPlanExecution {
                            for execution in (curr.exerciseExecution ?? []) {
                                context.delete(execution)
                            }
                            context.delete(curr)

                        }

                        activeTrainingID = ""
                    }
                    .padding()
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(8)
                    .padding(.top, 20)
                    .padding(.bottom, 10)
                }
            }
        }
        .navigationBarBackButtonHidden(true) // Hides the back button
    }
    
    private func computeDoneExercises() {
        
        if currentTrainingPlanExecution?.endTimeStamp != -1 {
            activeTrainingID = ""
        }
        
        let descriptor = FetchDescriptor<ExerciseExecution>(predicate: nil)
        
        let exerciseExec = try! context.fetch(
            descriptor
        )
        
        let filteredResults = exerciseExec.filter {$0.exerciseInTraining?.trainingPlan?.tpID ==  currentTrainingPlanExecution?.trainingsPlan?.tpID &&
            currentTrainingPlanExecution?.tID ==
            $0.trainingPlanExecution?.tID
        }
        
        exercisesDoneInCurrentTP = filteredResults.compactMap { $0.exerciseInTraining?.exercise?.eID }
    }
}

#Preview {
    ZStack {
        var descriptor = FetchDescriptor<TrainingPlanExecution>(predicate: #Predicate { $0.endTimeStamp == -1})
        
        let tp1 = try! PreviewContainerGenerator.previewContainer.mainContext.fetch(
            descriptor
        )
        
        TrainingPlanActiveView(currentTrainingPlanExecution: tp1.first!)
            .modelContainer(PreviewContainerGenerator.previewContainer)
    }

}
