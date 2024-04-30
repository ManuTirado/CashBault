//
//  HomeView.swift
//  CashBault
//
//  Created by manueltirado on 29/4/24.
//

import SwiftUI

struct HomeView: View {

    var body: some View {
        VStack {
            Text("Home View")
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color.red)
    }
}

#Preview {
    HomeView()
        .environmentObject(AppState())
}
