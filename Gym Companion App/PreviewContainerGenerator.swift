//
//  PreviewContainerGenerator.swift
//  Gym Companion App
//
//  Created by Geoffrey Karnbach on 24.06.24.
//

import Foundation
import SwiftData

@MainActor
class PreviewContainerGenerator {
    static let previewContainer: ModelContainer = {
        do {
            let schema = Schema([
                ExerciseInTraining.self,
                ExerciseCategory.self,
                ExerciseExecution.self,
                TrainingPlan.self,
                ExerciseExecutionSet.self,
                Exercise.self
                
            ])
            
            
            let config = ModelConfiguration(isStoredInMemoryOnly: true)
            let container = try ModelContainer(for: schema , configurations: config)

            let defaultCategory1 = ExerciseCategory(name: "Arme", exercises: [])
            container.mainContext.insert(defaultCategory1)
            
            let defaultCategory2 = ExerciseCategory(name: "Beine", exercises: [])
            container.mainContext.insert(defaultCategory2)
            
            let exercise1 = Exercise(isDefault: true, explanation: "", fullName: "Full Name 1", iconName: "dumbbell", maxWeight: 200, minWeight: 5, name: "Name 1", weightStep: 2.5, category: defaultCategory1, executions: [], inTrainings: [])
            let exercise2 = Exercise(isDefault: true, explanation: "", fullName: "Full Name 2", iconName: "dumbbell", maxWeight: 200, minWeight: 5, name: "Name 2", weightStep: 2.5, category: defaultCategory1, executions: [], inTrainings: [])
            let exercise3 = Exercise(isDefault: true, explanation: "", fullName: "Full Name 3", iconName: "dumbbell", maxWeight: 200, minWeight: 5, name: "Name 3", weightStep: 2.5, category: defaultCategory2, executions: [], inTrainings: [])
            
            container.mainContext.insert(exercise1)
            container.mainContext.insert(exercise2)
            container.mainContext.insert(exercise3)
            


            let trainingsplan1 = TrainingPlan(days: "Tag 1, 5", name: "Trainingsplan 1", exerciseInTraining: [])
            let trainingsplan2 = TrainingPlan(days: "Tag 2, 4", name: "Trainingsplan 2", exerciseInTraining: [])
            
            container.mainContext.insert(trainingsplan1)
            container.mainContext.insert(trainingsplan2)
            
            let exerciseInTraining1 = ExerciseInTraining(order: 1, repCount: 12, setCount: 3, weight: 25, exercise: exercise1, exerciseExecution: [], trainingPlan: trainingsplan1)
            
            container.mainContext.insert(exerciseInTraining1)

            return container
        } catch {
            fatalError("Failed to create model container for previewing: \(error.localizedDescription)")
        }
    }()
}
