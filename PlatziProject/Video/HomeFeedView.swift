//
//  ContentView.swift
//  PlatziProject
//
//  Created by Mike Jasso on 10/07/24.
//

import SwiftUI
import SDWebImageSwiftUI

struct HomeFeedView: View {
    @State var videos: Videos? = nil
    @State var searchText = ""
    
    var body: some View {
        VStack {
            TextField("", text: $searchText, prompt: Text("Search...").foregroundColor(.gray))
                .bold()
                .font(.title2)
                .padding(16)
                .border(.gray, width: 1)
                .padding(16)
                .onSubmit {
                    Task{
                        do {
                            let response = try await Network().fetchData(searchText)
                            print("Response: \(response)")
                            videos = response
                        } catch HTTPRequestError.invalidData {
                            print("Error: Invalid Data")
                        } catch HTTPRequestError.invalidURL {
                            print("Error: Invalid URL")
                        } catch HTTPRequestError.invalidResponse {
                            print("Erorr: Invalid Response")
                        }
                    }
                }
        }.onAppear() {
            Task{
                do {
                    let response = try await Network().fetchPopularVideos()
                    print("Response: \(response)")
                    videos = response
                } catch {
                    print("Error")
                }
            }
        }
        List(videos?.videos.first?.videoFiles ?? [], id: \.id) { video in
           VideoItem(video: video)
        }
        .navigationTitle("Video List")
    }
}




#Preview {
    HomeFeedView()
}
