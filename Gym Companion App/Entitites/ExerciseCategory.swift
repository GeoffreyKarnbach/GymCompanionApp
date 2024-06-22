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
    
    @Attribute(.unique) var name: String
    @Relationship(inverse: \Exercise.category) var exercises: [Exercise]?
    
    init(name: String = "", exercises: [Exercise]? = nil) {
        self.name = name
        self.exercises = exercises
    }
    
}

extension ExerciseCategory {
    static var defaults: [ExerciseCategory] {
        [
            .init(name: "Arme", exercises: []),
            .init(name: "Bank", exercises: []),
            .init(name: "Bauch", exercises: []),
            .init(name: "Beine", exercises: []),
            .init(name: "Brust", exercises: []),
            .init(name: "Gesäss", exercises: []),
            .init(name: "Gewichte", exercises: []),
            .init(name: "Multi", exercises: []),
            .init(name: "Rücken", exercises: []),
            .init(name: "Schultern", exercises: []),
            .init(name: "Unterer Rücken", exercises: [])
        ]
    }
}

