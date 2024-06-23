//
//  JsonEncoders.swift
//  Gym Companion App
//
//  Created by Geoffrey Karnbach on 23.06.24.
//

import Foundation

struct JsonEncoders {
    
    static func encodeNewCustomExercise(fileName: String, exercise: ExerciseJSON) -> Bool {
        print(fileName)
        print(exercise.name)
        
        guard let url = Bundle.main.url(forResource: fileName, withExtension: "json") else {
            print("Failed to find \(fileName).json in main bundle.")
            return false
        }


        do {
            
            var exercises: [ExerciseJSON]
            
            do {
                let data = try Data(contentsOf: url)
                
                print(data)
                
                // Decode the JSON data into an array of ExerciseJSON objects
                exercises = try JSONDecoder().decode([ExerciseJSON].self, from: data)
            }
            catch {
                exercises = []
            }

            
            exercises.append(exercise)
            
            let updatedJson = try JSONEncoder().encode(exercises)
            
            if let updatedJsonString = String(data: updatedJson, encoding: .utf8) {
                print("Updated JSON:")
                print(updatedJsonString)
            }
            
            try updatedJson.write(to: url)
            
            print("WRITTEN")
            
            return true
        } catch {
            print("Error decoding \(fileName).json:", error.localizedDescription)
            return false
        }
    }
}
