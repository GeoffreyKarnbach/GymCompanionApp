//
//  ExerciseExecutionSet.swift
//  Gym Companion App
//
//  Created by Geoffrey Karnbach on 21.06.24.
//
//

import Foundation
import SwiftData


@Model public class ExerciseExecutionSet {
    var reps: Int32? = 0
    var weight: Float? = 0.0
    var exerciseExecution: ExerciseExecution?
    
    init(reps: Int32? = nil, weight: Float? = nil, exerciseExecution: ExerciseExecution? = nil) {
        self.reps = reps
        self.weight = weight
        self.exerciseExecution = exerciseExecution
    }
}
