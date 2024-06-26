//
//  TrainingPlanExecution.swift
//  Gym Companion App
//
//  Created by Geoffrey Karnbach on 26.06.24.
//

import Foundation
import SwiftData

@Model public class TrainingPlanExecution {
    var startTimeStamp: Int32
    var endTimeStamp: Int32?
    
    var trainingsPlan: TrainingPlan?
    var exerciseExecution: [ExerciseExecution]?
    
    init(startTimeStamp: Int32 = 0, endTimeStamp: Int32 = 0, trainingsPlan: TrainingPlan? = nil, exerciseExecution: [ExerciseExecution]? = nil) {
        self.startTimeStamp = startTimeStamp
        self.endTimeStamp = endTimeStamp
        self.trainingsPlan = trainingsPlan
        self.exerciseExecution = exerciseExecution
    }
    
}
