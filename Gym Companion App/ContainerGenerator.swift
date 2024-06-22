//
//  ContainerGenerator.swift
//  Gym Companion App
//
//  Created by Geoffrey Karnbach on 22.06.24.
//

import Foundation
import SwiftData

actor ContainerGenerator {
    
    @MainActor
    static func create(shouldCreateDefaults: inout Bool) -> ModelContainer {
        let schema = Schema([
            ExerciseInTraining.self,
            ExerciseCategory.self,
            ExerciseExecution.self,
            TrainingPlan.self,
            ExerciseExecutionSet.self,
            Exercise.self
            
        ])
        
        let configuration = ModelConfiguration()
        let container = try! ModelContainer(for: schema, configurations: [configuration])
        
        if true {
            shouldCreateDefaults = false
            let exercises = JsonDecoders.decodeExercises(from: "exercisesDefault")
            print("HELLO CONTAINER")
            print(exercises)
            if !exercises.isEmpty {
                exercises.forEach { exercise in
                    print(exercise)
                    let item = Exercise(explanation: "TODO", fullName: exercise.fullname, iconName: "dumbbell", maxWeight: 100, minWeight: 20, name: exercise.name, weightStep: 5, category: nil, executions: [], inTrainings: [])
                    
                    container.mainContext.insert(item)
                }
            }
        }

        return container
    }
}
