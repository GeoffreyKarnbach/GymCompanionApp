//
//  TrainingPlan.swift
//  Gym Companion App
//
//  Created by Geoffrey Karnbach on 21.06.24.
//
//

import Foundation
import SwiftData


@Model public class TrainingPlan {
    var days: String
    var name: String
    @Relationship(deleteRule: .cascade, inverse: \ExerciseInTraining.trainingPlan) var exerciseInTraining: [ExerciseInTraining]?
    @Relationship(inverse: \TrainingPlanExecution.trainingsPlan) var trainingPlanExecutions: [TrainingPlanExecution]?
    let tpID: String = UUID().uuidString
    
    init(days: String = "", name: String = "", exerciseInTraining: [ExerciseInTraining]? = nil) {
        self.days = days
        self.name = name
        self.exerciseInTraining = exerciseInTraining
    }
    
}
