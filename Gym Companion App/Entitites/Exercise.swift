//
//  Exercise.swift
//  Gym Companion App
//
//  Created by Geoffrey Karnbach on 21.06.24.
//
//

import Foundation
import SwiftData


@Model public class Exercise {
    var explanation: String
    var fullName: String
    var iconName: String
    var maxWeight: Int32 = 0
    var minWeight: Int32 = 0
    var name: String
    var weightStep: Int32 = 0
    var category: ExerciseCategory?
    var executions: [ExerciseExecution]?
    @Relationship(inverse: \ExerciseInTraining.exercise) var inTrainings: [ExerciseInTraining]?
    
    init(explanation: String = "", fullName: String = "", iconName: String = "", maxWeight: Int32 = 0, minWeight: Int32 = 0, name: String = "", weightStep: Int32 = 0, category: ExerciseCategory? = nil, executions: [ExerciseExecution]? = nil, inTrainings: [ExerciseInTraining]? = nil) {
        self.explanation = explanation
        self.fullName = fullName
        self.iconName = iconName
        self.maxWeight = maxWeight
        self.minWeight = minWeight
        self.name = name
        self.weightStep = weightStep
        self.category = category
        self.executions = executions
        self.inTrainings = inTrainings
    }   
    
}
