//
//  VideoPlayerView.swift
//  PlatziProject
//
//  Created by Mike Jasso on 10/07/24.
//

import SwiftUI
import VideoPlayer
import CoreMedia
import RealmSwift

struct VideoPlayerView : View {
    let video: VideoFile?
    var totalDuration: Double = 0
    var videoSize: CGSize

    @State var isFav: Bool = false
    @State private var play: Bool = true
    @State private var time: CMTime = .zero
    @State private var stateText: String = ""
    
    @ObservedResults(FavVideo.self) var favVideos
    
    var body: some View {
        VStack {
            NetworkAlert()
            VideoPlayer(url: URL(string: video?.link ?? "")!, play: $play, time: $time)
                .onBufferChanged { progress in print("onBufferChanged \(progress)") }
                .aspectRatio(1.78, contentMode: .fit)
                .cornerRadius(16)
                .shadow(color: Color.black.opacity(0.7), radius: 6, x: 0, y: 2)
                .padding()
            
            HStack {
                Button(action: {
                    self.play.toggle()
                }, label: {
                    self.play ? Image(systemName: "pause.fill") : Image(systemName: "play.fill")
                })
                
                Divider().frame(height: 20)
            }
            HStack {
                Button(action: {
                    self.time = CMTimeMakeWithSeconds(max(0, self.time.seconds - 5), preferredTimescale: self.time.timescale)
                }, label: {
                    Image(systemName: "backward.fill")
                })
                
                Divider().frame(height: 20)
                
                Text("\(getTimeString()) / \(getTotalDurationString())")
                
                Divider().frame(height: 20)
                
                Button(action: {
                    self.time = CMTimeMakeWithSeconds(max(0, self.time.seconds + 5), preferredTimescale: self.time.timescale)
                }, label: {
                    Image(systemName: "forward.fill")
                })
            }
            VideoDescription(videoFile: video)
                .padding(.horizontal, 24)
                .overlay {
                    Button(action: {
                        let favVideo = FavVideo()
                        guard let id = video?.id else {
                            return
                        }
                        favVideo.videoID = id
                        $favVideos.append(favVideo)
                        isFav = true
                    }, label: {
                        if !isFav {
                            Image(systemName: "plus")
                                .padding()
                                .background(Color.blue)
                                .foregroundColor(.white)
                                .clipShape(Circle())
                                .padding(.leading, 200)
                                .padding(.top, 130)
                        }
                    })
                }
            Spacer()
        }
        .onDisappear { self.play = false }
    }
    
    func getTimeString() -> String {
        let m = Int(time.seconds / 60)
        let s = Int(time.seconds.truncatingRemainder(dividingBy: 60))
        return String(format: "%d:%02d", arguments: [m, s])
    }
    
    func getTotalDurationString() -> String {
        let m = Int(totalDuration / 60)
        let s = Int(totalDuration.truncatingRemainder(dividingBy: 60))
        return String(format: "%d:%02d", arguments: [m, s])
    }
}
