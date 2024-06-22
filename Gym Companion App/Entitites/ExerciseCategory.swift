//
//  ExerciseCategory.swift
//  Gym Companion App
//
//  Created by Geoffrey Karnbach on 21.06.24.
//
//

import Foundation
import SwiftData


@Model public class ExerciseCategory {
    
    @Attribute(.unique) var name: String?
    @Relationship(inverse: \Exercise.category) var exercises: [Exercise]?
    
    init(name: String? = nil, exercises: [Exercise]? = nil) {
        self.name = name
        self.exercises = exercises
    }
    
}
