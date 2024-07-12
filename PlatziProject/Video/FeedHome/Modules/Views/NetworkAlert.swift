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
                Text("Connected to the Internet")
                    .foregroundColor(.green)
            } else {
                Text("No Internet Connection")
                    .foregroundColor(.red)
            }
        }
        .frame(maxHeight: 60)
    }
}

#Preview {
    NetworkAlert()
}
