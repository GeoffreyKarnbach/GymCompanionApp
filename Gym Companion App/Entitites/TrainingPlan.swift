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
    var exerciseInTraining: [ExerciseInTraining]?
    
    init(days: String = "", name: String = "", exerciseInTraining: [ExerciseInTraining]? = nil) {
        self.days = days
        self.name = name
        self.exerciseInTraining = exerciseInTraining
    }
    
}
