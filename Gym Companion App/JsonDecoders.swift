//
//  JsonDecoders.swift
//  Gym Companion App
//
//  Created by Geoffrey Karnbach on 22.06.24.
//

import Foundation

struct ExerciseJSON: Codable {
    let name: String
    let fullname: String
    let categoryName: String
}

struct ExerciseCategoryJSON: Codable {
    let name: String
}

struct JsonDecoders {
    
    static func decodeExercises(from fileName: String) -> [ExerciseJSON] {
        // Get the URL of the JSON file in the main bundle
        guard let url = Bundle.main.url(forResource: fileName, withExtension: "json") else {
            print("Failed to find \(fileName).json in main bundle.")
            return []
        }
            
        do {
            // Load data from the JSON file
            let data = try Data(contentsOf: url)
            
            print(data)
            
            // Decode the JSON data into an array of ExerciseJSON objects
            let exercises = try JSONDecoder().decode([ExerciseJSON].self, from: data)
            
            return exercises
        } catch {
            print("Error decoding \(fileName).json:", error.localizedDescription)
            return []
        }
    }
    
    static func decodeExerciseCategories(from fileName: String) -> [ExerciseCategoryJSON] {
        // Get the URL of the JSON file in the main bundle
        guard let url = Bundle.main.url(forResource: fileName, withExtension: "json") else {
            print("Failed to find \(fileName).json in main bundle.")
            return []
        }
    
        
        do {
            // Load data from the JSON file
            let data = try Data(contentsOf: url)
            
            print(data)
            
            // Decode the JSON data into an array of ExerciseJSON objects
            let exercises = try JSONDecoder().decode([ExerciseCategoryJSON].self, from: data)
            
            return exercises
        } catch {
            print("Error decoding \(fileName).json:", error.localizedDescription)
            return []
        }
    }

}
