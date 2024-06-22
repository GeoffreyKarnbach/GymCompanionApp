//
//  ExerciseExecution.swift
//  Gym Companion App
//
//  Created by Geoffrey Karnbach on 21.06.24.
//
//

import Foundation
import SwiftData


@Model public class ExerciseExecution {
    var executionScore: Int32? = 0
    var exhaustScore: Int32? = 0
    var exercise: Exercise?
    @Relationship(inverse: \ExerciseExecutionSet.exerciseExecution) var exerciseExecutionSets: [ExerciseExecutionSet]?
    var exerciseInTraining: ExerciseInTraining?
    
    init(executionScore: Int32? = nil, exhaustScore: Int32? = nil, exercise: Exercise? = nil, exerciseExecutionSets: [ExerciseExecutionSet]? = nil, exerciseInTraining: ExerciseInTraining? = nil) {
        self.executionScore = executionScore
        self.exhaustScore = exhaustScore
        self.exercise = exercise
        self.exerciseExecutionSets = exerciseExecutionSets
        self.exerciseInTraining = exerciseInTraining
    }
}
