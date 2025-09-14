//
//  AudioManager.swift
//  Cubit
//

import AVFoundation

class AudioManager {
    private var audioPlayer: AVAudioPlayer?
    
    enum SoundFile: String, CaseIterable {
        case eightSeconds = "8seconds"
        case twelveSeconds = "12seconds"
        case cheer = "cheer"
        case sadTrombone = "Sad_Trombone"
        
        var fileExtension: String {
            switch self {
            case .eightSeconds, .twelveSeconds, .sadTrombone:
                return "mp3"
            case .cheer:
                return "m4a"
            }
        }
    }
    
    func setupAudioSession() {
        do {
            try AVAudioSession.sharedInstance().setCategory(.ambient, mode: .default)
            try AVAudioSession.sharedInstance().setActive(true)
        } catch {
            print("Failed to setup audio session: \(error.localizedDescription)")
        }
    }
    
    func playSound(_ sound: SoundFile) {
        guard let path = Bundle.main.path(forResource: sound.rawValue, ofType: sound.fileExtension) else {
            print("Sound file not found: \(sound.rawValue).\(sound.fileExtension)")
            return
        }
        
        let url = URL(fileURLWithPath: path)
        
        do {
            audioPlayer = try AVAudioPlayer(contentsOf: url)
            audioPlayer?.prepareToPlay()
            audioPlayer?.play()
        } catch {
            print("Failed to play sound \(sound.rawValue): \(error.localizedDescription)")
        }
    }
    
    func stopSound() {
        audioPlayer?.stop()
    }
}