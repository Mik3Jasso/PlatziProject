//
//  NetWorkAlert.swift
//  PlatziProject
//
//  Created by Mike Jasso on 12/07/24.
//

import SwiftUI
import Reachability

struct NetworkAlert: View {
    
    @ObservedObject private var networkManager = NetworkManager()
    
    
    var body: some View {
        VStack {
            if networkManager.isReachable {
                Image(systemName: "wifi")
                    .resizable()
                    .foregroundColor(.green)
                    .scaledToFit()
                    .transition(.opacity)

            } else {
                Image(systemName: "wifi.slash")
                    .resizable()
                    .foregroundColor(.red)
                    .scaledToFit()
                    .transition(.opacity)
            }
        }
        .frame(maxHeight: 15)
    }
}

#Preview {
    NetworkAlert()
}
