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
        
        if shouldCreateDefaults {
            
            try! container.mainContext.delete(model: ExerciseCategory.self)
            try! container.mainContext.delete(model: Exercise.self)
            
            shouldCreateDefaults = false
            
            let exerciseCategories = JsonDecoders.decodeExerciseCategories(from: "exercisesDefaultCategories")
            if !exerciseCategories.isEmpty {
                exerciseCategories.forEach { exerciseCategory in
                    let item = ExerciseCategory(name: exerciseCategory.name, exercises: [])
                    
                    container.mainContext.insert(item)
                }
            }
            
            try! container.mainContext.save()
            
            let exercises = JsonDecoders.decodeExercises(from: "exercisesDefault")

            if !exercises.isEmpty {
                exercises.forEach { exercise in
                    
                    var fetchDescriptor = FetchDescriptor<ExerciseCategory>(
                        predicate: #Predicate {
                            category in category.name == exercise.categoryName
                        }
                    )
                    
                    fetchDescriptor.fetchLimit = 1
                    
                    let exerciseCategory = try! container.mainContext.fetch(fetchDescriptor)
                    if exerciseCategory.count != 1 {
                        fatalError("Cannot find category!!!")
                    }
                    
                    let exerciseCategoryItem = exerciseCategory[0]
                    
                    let item = Exercise(isDefault: true, explanation: "TODO", fullName: exercise.fullname, iconName: "dumbbell", maxWeight: 100, minWeight: 20, name: exercise.name, weightStep: 5, category: exerciseCategoryItem, executions: [], inTrainings: [])
                    
                    exerciseCategoryItem.exercises.append(item)
                    
                    container.mainContext.insert(item)
                }
            }
            
        }
        
        let customExercises = JsonDecoders.decodeExercises(from: "exercisesCustom")

        if !customExercises.isEmpty {
            customExercises.forEach { exercise in
                
                var fetchDescriptor = FetchDescriptor<ExerciseCategory>(
                    predicate: #Predicate {
                        category in category.name == exercise.categoryName
                    }
                )
                
                fetchDescriptor.fetchLimit = 1
                
                let exerciseCategory = try! container.mainContext.fetch(fetchDescriptor)
                if exerciseCategory.count != 1 {
                    fatalError("Cannot find category!!!")
                }
                
                let exerciseCategoryItem = exerciseCategory[0]
                
                let item = Exercise(isDefault: false, explanation: "TODO", fullName: exercise.fullname, iconName: "dumbbell", maxWeight: 100, minWeight: 20, name: exercise.name, weightStep: 5, category: exerciseCategoryItem, executions: [], inTrainings: [])
                
                exerciseCategoryItem.exercises.append(item)
                
                container.mainContext.insert(item)
            }
        }

        return container
    }
}
