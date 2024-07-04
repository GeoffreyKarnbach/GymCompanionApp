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
                Exercise.self,
                TrainingPlanExecution.self
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
            
            let exerciseInTraining2 = ExerciseInTraining(order: 2, repCount: 12, setCount: 3, weight: 25, exercise: exercise2, exerciseExecution: [], trainingPlan: trainingsplan1)
            
            container.mainContext.insert(exerciseInTraining1)
            
            let exerciseExecution1 = ExerciseExecution(executionScore: 1, exhaustScore: 1, exercise: exercise1, exerciseExecutionSets: [], exerciseInTraining: exerciseInTraining1)
            
            let exerciseExecutionSet1 = ExerciseExecutionSet(reps: 12, weight: 10, exerciseExecution: exerciseExecution1)
            let exerciseExecutionSet2 = ExerciseExecutionSet(reps: 12, weight: 10, exerciseExecution: exerciseExecution1)
            let exerciseExecutionSet3 = ExerciseExecutionSet(reps: 12, weight: 10, exerciseExecution: exerciseExecution1)

            exerciseExecution1.exerciseExecutionSets?.append(exerciseExecutionSet1)
            exerciseExecution1.exerciseExecutionSets?.append(exerciseExecutionSet2)
            exerciseExecution1.exerciseExecutionSets?.append(exerciseExecutionSet3)
            
            ///
            
            let exerciseExecution2 = ExerciseExecution(executionScore: 2, exhaustScore: 2, exercise: exercise1, exerciseExecutionSets: [], exerciseInTraining: exerciseInTraining1)
            
            let exerciseExecutionSet4 = ExerciseExecutionSet(reps: 12, weight: 15, exerciseExecution: exerciseExecution2)
            let exerciseExecutionSet5 = ExerciseExecutionSet(reps: 12, weight: 15, exerciseExecution: exerciseExecution2)
            let exerciseExecutionSet6 = ExerciseExecutionSet(reps: 12, weight: 15, exerciseExecution: exerciseExecution2)

            exerciseExecution2.exerciseExecutionSets?.append(exerciseExecutionSet4)
            exerciseExecution2.exerciseExecutionSets?.append(exerciseExecutionSet5)
            exerciseExecution2.exerciseExecutionSets?.append(exerciseExecutionSet6)
            
            ///

            let exerciseExecution3 = ExerciseExecution(executionScore: 3, exhaustScore: 3, exercise: exercise1, exerciseExecutionSets: [], exerciseInTraining: exerciseInTraining1)
            
            let exerciseExecutionSet7 = ExerciseExecutionSet(reps: 12, weight: 22.5, exerciseExecution: exerciseExecution3)
            let exerciseExecutionSet8 = ExerciseExecutionSet(reps: 12, weight: 22.5, exerciseExecution: exerciseExecution3)
            let exerciseExecutionSet9 = ExerciseExecutionSet(reps: 12, weight: 22.5, exerciseExecution: exerciseExecution3)

            exerciseExecution3.exerciseExecutionSets?.append(exerciseExecutionSet7)
            exerciseExecution3.exerciseExecutionSets?.append(exerciseExecutionSet8)
            exerciseExecution3.exerciseExecutionSets?.append(exerciseExecutionSet9)
            
            
            ///
            
            container.mainContext.insert(exerciseExecution1)
            container.mainContext.insert(exerciseExecutionSet1)
            container.mainContext.insert(exerciseExecutionSet2)
            container.mainContext.insert(exerciseExecutionSet3)
            
            container.mainContext.insert(exerciseExecution2)
            container.mainContext.insert(exerciseExecutionSet4)
            container.mainContext.insert(exerciseExecutionSet5)
            container.mainContext.insert(exerciseExecutionSet6)
            
            container.mainContext.insert(exerciseExecution3)
            container.mainContext.insert(exerciseExecutionSet7)
            container.mainContext.insert(exerciseExecutionSet8)
            container.mainContext.insert(exerciseExecutionSet9)

            exercise1.executions?.append(exerciseExecution1)
            exercise1.executions?.append(exerciseExecution2)
            exercise1.executions?.append(exerciseExecution3)


            let activeTrainingPlan = TrainingPlanExecution(startTimeStamp: Int32(Date().timeIntervalSince1970), endTimeStamp: -1, trainingsPlan: trainingsplan1, exerciseExecution: [exerciseExecution1])
            
            let activeTrainingPlan2 = TrainingPlanExecution(startTimeStamp: Int32(Date().timeIntervalSince1970) + 86400, endTimeStamp: -1, trainingsPlan: trainingsplan1, exerciseExecution: [exerciseExecution2])
            
            let activeTrainingPlan3 = TrainingPlanExecution(startTimeStamp: Int32(Date().timeIntervalSince1970) + 172800, endTimeStamp: -1, trainingsPlan: trainingsplan1, exerciseExecution: [exerciseExecution3])

            container.mainContext.insert(activeTrainingPlan)
            container.mainContext.insert(activeTrainingPlan2)
            container.mainContext.insert(activeTrainingPlan3)

            ///
            
            let exerciseExecution4 = ExerciseExecution(executionScore: 3, exhaustScore: 3, exercise: exercise1, exerciseExecutionSets: [], exerciseInTraining: exerciseInTraining1)
            
            let exerciseExecutionSet10 = ExerciseExecutionSet(reps: 12, weight: 21, exerciseExecution: exerciseExecution4)

            exerciseExecution4.exerciseExecutionSets?.append(exerciseExecutionSet10)
            
            container.mainContext.insert(exerciseExecution4)
            container.mainContext.insert(exerciseExecutionSet10)
            
            exercise1.executions?.append(exerciseExecution4)

            let activeTrainingPlan4 = TrainingPlanExecution(startTimeStamp: Int32(Date().timeIntervalSince1970) + 604800, endTimeStamp: -1, trainingsPlan: trainingsplan1, exerciseExecution: [exerciseExecution4])
            
            container.mainContext.insert(activeTrainingPlan4)

            ///
            
            let exerciseExecution5 = ExerciseExecution(executionScore: 3, exhaustScore: 3, exercise: exercise1, exerciseExecutionSets: [], exerciseInTraining: exerciseInTraining1)
            
            let exerciseExecutionSet11 = ExerciseExecutionSet(reps: 12, weight: 26, exerciseExecution: exerciseExecution4)

            exerciseExecution5.exerciseExecutionSets?.append(exerciseExecutionSet11)
            
            container.mainContext.insert(exerciseExecution5)
            container.mainContext.insert(exerciseExecutionSet11)
            
            exercise1.executions?.append(exerciseExecution5)

            let activeTrainingPlan5 = TrainingPlanExecution(startTimeStamp: Int32(Date().timeIntervalSince1970) + 86400*15, endTimeStamp: -1, trainingsPlan: trainingsplan1, exerciseExecution: [exerciseExecution5])
            
            container.mainContext.insert(activeTrainingPlan5)

            ///
            return container
        } catch {
            fatalError("Failed to create model container for previewing: \(error.localizedDescription)")
        }
    }()
}
