//
//  ViewController.swift
//  Timer
//
//  Created by 이중엽 on 2022/09/27.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {

    
    @IBOutlet weak var mainLabel: UILabel!
    @IBOutlet weak var mainSlider: UISlider!
    
    weak var timer: Timer?
    var number: Int = 0
    
    lazy var sliderCenterValue = mainSlider.maximumValue / 2
    
    override func viewDidLoad() {
        super.viewDidLoad()

        configureUI()
    }

    
    func configureUI() {
        mainLabel.text = "초를 선택하세요."
        mainSlider.setValue(sliderCenterValue, animated: false)
    }
    
    //슬라이더의 값이 변경될때 마다 해당 함수가 호출됨
    @IBAction func sliderChanged(_ sender: UISlider) {
        
        let seconds = Int(mainSlider.value * 60)
        mainLabel.text = "\(seconds)초"
        
        number = seconds
    }
    
    
    @IBAction func startButtonTapped(_ sender: UIButton) {
        if number == 0 { return }
        
        timer?.invalidate()
                
        timer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { [self] _ in
            
            if number > 0 {
                number -= 1
                
                
                mainSlider.setValue(Float(number) / Float(60), animated: true)
                mainLabel.text = "\(number)초"
                
            } else {
                number = 0
                mainLabel.text = "초를 선택하세요."
                timer?.invalidate()
                AudioServicesPlayAlertSound(SystemSoundID(1322))
            }
        }
    }
    
    @IBAction func resetButtonTapped(_ sender: UIButton) {
        mainLabel.text = "초를 선택하세요."
        mainSlider.setValue(sliderCenterValue, animated: true)
        number = 0
        timer?.invalidate()
    }
}

