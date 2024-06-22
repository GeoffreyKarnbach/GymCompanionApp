//
//  TabBarView.swift
//  Gym Companion App
//
//  Created by Geoffrey Karnbach on 18.06.24.
//

import SwiftUI

struct TabBarView: View {
    var body: some View {
        TabView {
            TrainingsPlanView()
                .tabItem {
                    Image(systemName: "figure.strengthtraining.traditional")
                    Text("Trainingspläne")
                }
            
            ExerciseListView(exerciseSections: [
                ExerciseSection(title: "Arme", exercises: ["Arme 1A", "Arme 2A"]),
                ExerciseSection(title: "Bank", exercises: ["Bank 1A", "Bank 2A"]),
                ExerciseSection(title: "Bauch", exercises: ["Bauch 1A", "Bauch 2A"]),
                ExerciseSection(title: "Beine", exercises: ["Beine 1A"]),
                ExerciseSection(title: "Brust", exercises: ["Brust 1A", "Brust 2A", "Brust 3A", "Brust 3A", "Brust 3A", "Brust 3A"])
            ])
                .tabItem {
                    Image(systemName: "dumbbell")
                    Text("Geräte")
                }
            
            GlobalAnalyseView()
                .tabItem {
                    Image(systemName:"chart.bar.xaxis.ascending.badge.clock")
                    Text("Analyse")
                }
        }
    }
}

#Preview {
    TabBarView()
}
