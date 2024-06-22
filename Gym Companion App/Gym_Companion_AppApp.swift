//
//  Gym_Companion_AppApp.swift
//  Gym Companion App
//
//  Created by Geoffrey Karnbach on 18.06.24.
//

import SwiftUI
import SwiftData
import CoreData

@main
struct Gym_Companion_AppApp: App {

    var body: some Scene {
        WindowGroup {
            TabBarView()
        }
        .modelContainer(for: [
            ExerciseInTraining.self,
            ExerciseCategory.self,
            ExerciseExecution.self,
            TrainingPlan.self,
            ExerciseExecutionSet.self,
            Exercise.self
            
        ])
    }
    
    /**
    private func addInitialContent(context: ModelContext) throws {
        let categoryNames = ["Arms", "Legs", "Chest", "Back", "Core"]
        
        for name in categoryNames {
            let category = ExerciseCategory()
            category.name = name
            // Set other properties if needed
        }
        
        try context.save()
        
        
    }
     **/

}
