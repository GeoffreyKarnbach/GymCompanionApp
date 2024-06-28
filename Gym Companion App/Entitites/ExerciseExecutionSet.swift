//
//  ExerciseExecutionSet.swift
//  Gym Companion App
//
//  Created by Geoffrey Karnbach on 21.06.24.
//
//

import Foundation
import SwiftData


@Model public class ExerciseExecutionSet: Hashable {
    var reps: Int32 = 0
    var weight: Float = 0.0
    var exerciseExecution: ExerciseExecution?
    let eeID = UUID().uuidString
    
    init(reps: Int32, weight: Float, exerciseExecution: ExerciseExecution? = nil) {
        self.reps = reps
        self.weight = weight
        self.exerciseExecution = exerciseExecution
    }
    
    public func hash(into hasher: inout Hasher) {
        hasher.combine(eeID)
    }
}
