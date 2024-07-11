//
//  ContentView.swift
//  PlatziProject
//
//  Created by Mike Jasso on 10/07/24.
//

import SwiftUI
import SDWebImageSwiftUI

struct HomeFeedView: View {
    @State var videos: [Video] = []
    @State var searchText = ""
    @State var sectionTitle = "Top Videos"
    @State var isFirstTime = true
    
    var body: some View {
        NavigationStack {
            VStack {
                TextField("", text: $searchText, prompt: Text("Search...").foregroundColor(.gray))
                    .bold()
                    .font(.title2)
                    .border(.gray, width: 1)
                    .padding(16)
                    .onSubmit {
                        Task{
                            do {
                                let response = try await Network().fetchData(searchText)
                                print("Response: \(response)")
                                videos = response.videos
                                sectionTitle = searchText
                            } catch HTTPRequestError.invalidData {
                                print("Error: Invalid Data")
                            } catch HTTPRequestError.invalidURL {
                                print("Error: Invalid URL")
                            } catch HTTPRequestError.invalidResponse {
                                print("Erorr: Invalid Response")
                            }
                        }
                    }
                List {
                    Section(sectionTitle) {
                        ForEach(videos, id: \.id) { video in
                            ZStack {
                                VideoItem(video: video)
                                NavigationLink(destination: VideoPlayerView(video: video.videoFiles.first(where: {$0.quality == "sd"}), totalDuration: Double(video.duration), videoSize: CGSize(width: video.width, height: video.height))) {
                                }
                                .opacity(0)
                            }
                        }
                        
                    }
                }
                .listStyle(.plain)
            }
            .background(.white)
            .onAppear() {
                if isFirstTime {
                    Task{
                        do {
                            let response = try await Network().fetchPopularVideos()
                            print("Response: \(response)")
                            videos = response.videos
                            isFirstTime = false
                        } catch {
                            print("Error")
                        }
                    }
                }
            }
        }
    }
}




#Preview {
    HomeFeedView()
}
