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
    var isDefault: Bool
    var explanation: String
    var fullName: String
    var iconName: String
    var maxWeight: Int32 = 0
    var minWeight: Int32 = 0
    var name: String
    var weightStep: Float = 0
    var category: ExerciseCategory?
    var executions: [ExerciseExecution]?
    @Relationship(deleteRule: .cascade, inverse: \ExerciseInTraining.exercise) var inTrainings: [ExerciseInTraining]?
    
    init(isDefault: Bool = true, explanation: String = "", fullName: String = "", iconName: String = "", maxWeight: Int32 = 0, minWeight: Int32 = 0, name: String = "", weightStep: Float = 0, category: ExerciseCategory? = nil, executions: [ExerciseExecution]? = nil, inTrainings: [ExerciseInTraining]? = nil) {
        self.isDefault = isDefault
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
