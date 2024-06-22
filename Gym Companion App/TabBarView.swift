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
            
            ExerciseListView()
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
