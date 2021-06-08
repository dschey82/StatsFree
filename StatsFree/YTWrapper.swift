import UIKit
import SwiftUI
import youtube_ios_player_helper

public struct YTWrapper : UIViewRepresentable {
    private var playerView = YTPlayerView()
    
    public func makeUIView(context: Context) -> YTPlayerView {
        return playerView
    }
    
    public func updateUIView(_ uiView: YTPlayerView, context: Context) {
        //
    }
    
    public func loadVideo(videoId: String) {
        playerView.load(withVideoId: videoId)
    }
    
    public func pause() {
        playerView.pauseVideo()
    }
    
    public func play() {
        playerView.playVideo()
    }
    
    public func getTime(handler: @escaping (Float, Error?)-> Void) {
        playerView.currentTime{ (result, err) in
            handler(result, err)
        }
    }
}
