//
//  ExerciseInTraining.swift
//  Gym Companion App
//
//  Created by Geoffrey Karnbach on 21.06.24.
//
//

import Foundation
import SwiftData


@Model public class ExerciseInTraining {
    var order: Int32? = 0
    var repCount: Int32? = 0
    var setCount: Int32? = 0
    var weight: Int32? = 0
    var exercise: Exercise?
    var exerciseExecution: [ExerciseExecution]?
    var trainingPlan: TrainingPlan?
    
    init(order: Int32? = nil, repCount: Int32? = nil, setCount: Int32? = nil, weight: Int32? = nil, exercise: Exercise? = nil, exerciseExecution: [ExerciseExecution]? = nil, trainingPlan: TrainingPlan? = nil) {
        self.order = order
        self.repCount = repCount
        self.setCount = setCount
        self.weight = weight
        self.exercise = exercise
        self.exerciseExecution = exerciseExecution
        self.trainingPlan = trainingPlan
    }
    
}
