//
//  FavList.swift
//  PlatziProject
//
//  Created by Mike Jasso on 12/07/24.
//

import SwiftUI
import RealmSwift

struct FavList: View {
    
    @ObservedResults(FavVideo.self) var favVideos

    
    var body: some View {
        NavigationView {
            VStack {
                List(favVideos, id: \.id) { video in
                    Text("id: \(video.videoID)")
                }
            }
            .navigationTitle("Fav Videos")
        }
    }
}

#Preview {
    FavList()
}
