//
//  VideoPlayerView.swift
//  PlatziProject
//
//  Created by Mike Jasso on 10/07/24.
//

import SwiftUI
import VideoPlayer
import CoreMedia


struct VideoPlayerView : View {
    let video: VideoFile?
    var totalDuration: Double = 0
    var videoSize: CGSize
    
    @State private var play: Bool = true
    @State private var time: CMTime = .zero
    @State private var stateText: String = ""
    
    var body: some View {
        VStack {
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

#Preview {
    VideoPlayerView(video: nil, videoSize: CGSize(width: 100, height: 100))
}
