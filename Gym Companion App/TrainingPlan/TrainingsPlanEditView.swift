//
//  TrainingsPlanEditView.swift
//  Gym Companion App
//
//  Created by Geoffrey Karnbach on 19.06.24.
//

import SwiftUI

struct TrainingsPlanEditView: View {
    var name: String = "Trainingsplan 1 Name"
    var trainingDays: String = "Tag 1, Tag 4, Tag 7"
    var exercises: [Exercise] = []
    
    var body: some View {
        NavigationView {
            VStack {
                List {
                    ForEach(exercises, id: \.self) { exercise in
                        TrainingsPlanSingleExerciseView()
                    }
                    Button("+ Neue Übung") {
                        /*@START_MENU_TOKEN@*//*@PLACEHOLDER=Action@*/ /*@END_MENU_TOKEN@*/
                    }
                }
                .navigationBarTitle(name, displayMode: .inline)
                Spacer()
                Button("Reihenfolge anpassen") {
                    /*@START_MENU_TOKEN@*//*@PLACEHOLDER=Action@*/ /*@END_MENU_TOKEN@*/
                }
            }
        }
        
    }
}

#Preview {
    TrainingsPlanEditView(
        name:"Trainingsplan 1 Name",
        trainingDays: "Tag 1, Tag 4, Tag 7"
    )
}
