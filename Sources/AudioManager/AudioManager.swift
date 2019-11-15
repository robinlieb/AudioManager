import AVFoundation

public class AudioManager : NSObject, AVAudioPlayerDelegate {
    
    // MARK: - Singleton
    public static let shared = AudioManager()
    
    // MARK: - Init
    private override init() {
        do {
            try AVAudioSession.sharedInstance().setCategory(.playback, mode: .default)
            try AVAudioSession.sharedInstance().setActive(true)
        } catch let error {
            print(error.localizedDescription)
        }
        
    }
    
    // MARK: - Propterties
    private var players: [URL: AVAudioPlayer] = [:]
    
    // MARK: - Public
    
    /// Plays audio for given filename.
    ///
    /// - Parameters:
    ///     - audioFileName: The name of the audio resource file.
    ///     - volume: Volume of the audio, ranging from 0.0 through 1.0 on a linear scale.
    ///     - audioFileType: Type of file. Default type is mp3
    ///
    /// - Precondition: If audio is already playing it adjusts the volume.
    public func playAudio(audioFileName: String, volume: Float = 0.5, audioFileType: String = "mp3") {
        
        guard let bundle = Bundle.main.path(forResource: audioFileName, ofType: audioFileType) else { return }
        let audioFileNameURL = URL(fileURLWithPath: bundle)
        
        if let player = players[audioFileNameURL] {
            
            if !player.isPlaying {
                player.volume = volume
                player.prepareToPlay()
                player.play()
            } else {
                player.volume = volume
            }
        } else {
            do {
                let player = try AVAudioPlayer(contentsOf: audioFileNameURL)
                players[audioFileNameURL] = player
                player.volume = volume
                player.prepareToPlay()
                player.play()
            } catch let error {
                print(error.localizedDescription)
            }
        }
    }
    
    /// Plays or stops audio depending audio is playing or not.
    ///
    /// - Parameters:
    ///     - audioFileName: The name of the audio resource file.
    ///     - audioFileType: Type of file. Default type is mp3
    public func playOrStopAudio(audioFileName: String, audioFileType: String = "mp3") {
        
        guard let bundle = Bundle.main.path(forResource: audioFileName, ofType: audioFileType) else { return }
        let audioFileNameURL = URL(fileURLWithPath: bundle)
        
        if let player = players[audioFileNameURL] {
            
            if !player.isPlaying {
                player.prepareToPlay()
                player.play()
            } else {
                player.stop()
            }
        } else {
            do {
                let player = try AVAudioPlayer(contentsOf: audioFileNameURL)
                players[audioFileNameURL] = player
                player.prepareToPlay()
                player.play()
            } catch let error {
                print(error.localizedDescription)
            }
        }
    }
    
    /// Stops audio for given filename.
    ///
    /// - Parameters:
    ///     - audioFileName: The name of the audio resource file.
    ///     - audioFileType: Type of file. Default type is mp3
    public func stopAudio(audioFileName: String, audioFileType: String = "mp3") {
        
        guard let bundle = Bundle.main.path(forResource: audioFileName, ofType: audioFileType) else { return }
        let audioFileNameURL = URL(fileURLWithPath: bundle)
        
        if let player = players[audioFileNameURL] {
            
            if player.isPlaying {
                player.stop()
            }
        }
    }
    
    /// Changes volume of audio.
    ///
    /// - Parameters:
    ///     - audioFileName: The name of the audio resource file.
    ///     - volume: Volume of the audio, ranging from 0.0 through 1.0 on a linear scale.
    ///     - audioFileType: Type of file. Default type is mp3
    public func changeVolume(audioFileName: String, volume: Float, audioFileType: String = "mp3") {
        guard let bundle = Bundle.main.path(forResource: audioFileName, ofType: audioFileType) else { return }
        let audioFileNameURL = URL(fileURLWithPath: bundle)
        
        if let player = players[audioFileNameURL] {
            player.volume = volume
        } else {
            print("Could not adjust volume - player is not running!")
        }
    }
    
    /// Stops all audios of AudioManager
    ///
    public func stopAllAudios() {
        for player in players {
            player.value.stop()
        }
    }
    
    /// Plays muliple audios
    ///
    /// - Parameters:
    ///     - audioFileNames: Array of the names of the audio resource file.
    public func playAudios(audioFileNames: [String]) {
        for audioFileName in audioFileNames {
            self.playAudio(audioFileName: audioFileName)
        }
    }
    
    /// Plays muliple audios
    ///
    /// - Parameters:
    ///     - audioFileNames: Variadic parameter of the names of the audio resource file.
    public func playAudios(audioFileNames: String...) {
        for audioFileName in audioFileNames {
            self.playAudio(audioFileName: audioFileName)
        }
    }
    
    /// Plays muliple audios with delay
    ///
    /// - Parameters:
    ///     - audioFileNames: Array of the names of the audio resource file.
    ///     - withDelay: Delay of audio in seconds
    public func playAudios(audioFileNames: [String], withDelay: Double) {
        for (index, audioFileName) in audioFileNames.enumerated() {
            let delay = withDelay * Double(index)
            let _ = Timer.scheduledTimer(timeInterval: delay, target: self, selector: #selector(playAudioNotification(_:)), userInfo: ["fileName": audioFileName], repeats: false)
        }
    }
    
    // MARK: - Private
    
    @objc private func playAudioNotification(_ notification: NSNotification) {
        if let audioFileName = notification.userInfo?["fileName"] as? String {
            self.playAudio(audioFileName: audioFileName)
        }
    }

}
