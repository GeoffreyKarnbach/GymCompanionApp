//
//  ExerciseInTraining.swift
//  Gym Companion App
//
//  Created by Geoffrey Karnbach on 21.06.24.
//
//

import Foundation
import SwiftData


@Model public class ExerciseInTraining: Hashable{
    var order: Int32 = 0
    var repCount: Int32 = 0
    var setCount: Int32 = 0
    var weight: Float = 0
    var exercise: Exercise?
    var exerciseExecution: [ExerciseExecution]?
    var trainingPlan: TrainingPlan?
    let vID = UUID()
    
    init(order: Int32, repCount: Int32, setCount: Int32, weight: Float, exercise: Exercise? = nil, exerciseExecution: [ExerciseExecution]? = nil, trainingPlan: TrainingPlan? = nil) {
        self.order = order
        self.repCount = repCount
        self.setCount = setCount
        self.weight = weight
        self.exercise = exercise
        self.exerciseExecution = exerciseExecution
        self.trainingPlan = trainingPlan
    }
    
    // Hash function
    public func hash(into hasher: inout Hasher) {
        hasher.combine(vID)
    }
    
    /**
    public static func == (lhs: ExerciseInTraining, rhs: ExerciseInTraining) -> Bool {
            return lhs.order == rhs.order &&
                   lhs.repCount == rhs.repCount &&
                   lhs.setCount == rhs.setCount &&
                   lhs.weight == rhs.weight &&
                   lhs.exercise == rhs.exercise &&
                   lhs.exerciseExecution == rhs.exerciseExecution &&
                   lhs.trainingPlan == rhs.trainingPlan
        }
     **/
    
}
