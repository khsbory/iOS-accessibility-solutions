//
//  MusicPlayerViewController.swift
//  IosAccessibilityDemos
//
//  Created by Jeonggyu Park on 2021/02/03.
//  Copyright © 2021 Jeonggyu Park. All rights reserved.
//

import UIKit
import AVFoundation

class MusicPlayerViewController: UIViewController, AVAudioPlayerDelegate {
    
    
    @IBOutlet weak var progressView: UIProgressView!
    
    @IBOutlet weak var playButton: UIImageView!
    
    @IBOutlet weak var remainingTime: UILabel!
    
    @IBOutlet weak var elapsedTime: AccessibileUILabel!
    
    @IBOutlet weak var slider: UISlider!
    
    private var audioPlayer : AVAudioPlayer! // audioPlayer : AVAudioPlayer 인스턴스 변수
    private var progressTimer : Timer! // 타이머를 위한 변수
    
    private let PLAY: Int = 0
    private let PAUSE: Int = 1
    
    override func viewDidLoad() {
        initAudioPlayer()
        initPlayButton()
        initAccessibility()
        
    }
    
    @objc func handlePlayButtonClick(_ sender: UITapGestureRecognizer) {
        togglePlayButton()
    }
    
    // 0.1초마다 호출되며 재생 시간을 표시함
    @objc func updatePlayTime(){
        
        let remainingTimeConvertResult = convertTimeToString(audioPlayer.duration - audioPlayer.currentTime)
        let elapsedTimeConvertResult = convertTimeToString(audioPlayer.currentTime)
        
        remainingTime.text = remainingTimeConvertResult.0
        elapsedTime.text = elapsedTimeConvertResult.0
        
        progressView.progress = Float(audioPlayer.currentTime/audioPlayer.duration)
        
        
        if (Constants.isAccessibilityApplied) {
            remainingTime.accessibilityLabel = "남은 시간" + String(remainingTimeConvertResult.1) + "분" + String(remainingTimeConvertResult.2) + "초"
            elapsedTime.accessibilityLabel = "경과 시간"
            
            elapsedTime.accessibilityValue = String(elapsedTimeConvertResult.1) + "분" + String(elapsedTimeConvertResult.2) + "초" 
        }
    }
    
    private func togglePlayButton() {
        if (playButton.tag == PAUSE) {
            playMusic()
        } else if (playButton.tag == PLAY) {
            pauseMusic()
        }
    }
    
    private func initAudioPlayer(){
        let audioFile : URL! = Bundle.main.url(forResource: "Sunset Island", withExtension: "mp3")
        do {
            audioPlayer = try AVAudioPlayer(contentsOf: audioFile)
        } catch let error as NSError {
            print("Error-initPlay : \(error)")
        }
        
        audioPlayer.delegate = self // audioPlayer의 델리게이트는 self
        audioPlayer.prepareToPlay() // prepareToPlay() 실행
        
        
        updatePlayTime()
        
        progressView.isAccessibilityElement = false
        progressView.progress = 0
        
        
        
        let remainingTimeConvertResult = convertTimeToString(audioPlayer.duration)
        let elapsedTimeConvertResult = convertTimeToString(0)
        
        remainingTime.text = remainingTimeConvertResult.0
        elapsedTime.text = elapsedTimeConvertResult.0
    }
    
    
    private func initPlayButton() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(self.handlePlayButtonClick(_:)))
        tapGesture.numberOfTapsRequired = 1
        tapGesture.numberOfTouchesRequired = 1
        playButton.addGestureRecognizer(tapGesture)
        playButton.isUserInteractionEnabled = true
        
        playButton.isAccessibilityElement = true
        playButton.accessibilityTraits = .button
        
        pauseMusic()
        
        
    }
    
    
    private func playMusic() {
        audioPlayer.play()
        progressTimer = Timer.scheduledTimer(timeInterval: 0.1, target: self, selector: #selector(self.updatePlayTime), userInfo: nil, repeats: true)
        
        playButton.tag = PLAY
        playButton.image = UIImage(named: "pause")
        
        if (Constants.isAccessibilityApplied) {
            playButton.accessibilityLabel = "일시정지"
        }
    }
    
    private func pauseMusic() {
        audioPlayer.pause()
        
        
        
        playButton.tag = PAUSE
        playButton.image = UIImage(named: "play")
        
        if (Constants.isAccessibilityApplied) {
            playButton.accessibilityLabel = "재생"
        }
    }
    
    
    // 00:00 형태의 문자열로 변환함
    func convertTimeToString(_ time:TimeInterval) -> (String, Int, Int) {
        let min = Int(time/60)
        let sec = Int(time.truncatingRemainder(dividingBy: 60))
        let strTime = String(format: "%02d:%02d", min, sec)
        return (strTime, min, sec)
    }
    
    // 재생이 종료되었을 때 호출함
    func audioPlayerDidFinishPlaying(_ player: AVAudioPlayer, successfully flag: Bool) {
        progressTimer.invalidate() // 타이머 무효화
        
        pauseMusic()
    }
    
    
    private func initAccessibility() {
        if (Constants.isAccessibilityApplied) {
            elapsedTime.accessibilityTraits = .adjustable
            elapsedTime.setAudioPlayer(audioPlayer: audioPlayer)
            
            let deltaValue: Double = audioPlayer.duration / 20
            elapsedTime.setDeltaValue(deltaValue: deltaValue)
        }
    }
    
    override func accessibilityPerformMagicTap() -> Bool {
        if (Constants.isAccessibilityApplied) {
            togglePlayButton()
        }
        return true
    }
}

class AccessibileUILabel: UILabel {
    
    private var audioPlayer : AVAudioPlayer?
    private var deltaValue : Double?
    
    func setAudioPlayer(audioPlayer: AVAudioPlayer) {
        self.audioPlayer = audioPlayer
    }
    
    
    func setDeltaValue(deltaValue: Double) {
        self.deltaValue = deltaValue
    }
    
    override var isAccessibilityElement: Bool {
        get { return true }
        set { }
    }
    
    
    override func accessibilityIncrement() {
        if ((audioPlayer?.isPlaying) != nil) {
            audioPlayer?.currentTime = (audioPlayer?.currentTime ?? 0) + deltaValue!
        }
        
    }
    
    override func accessibilityDecrement() {
        if ((audioPlayer?.isPlaying) != nil) {
            audioPlayer?.currentTime = (audioPlayer?.currentTime ?? 0) - deltaValue!
        }
        
    }
}
