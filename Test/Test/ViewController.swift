//
//  ViewController.swift
//  Test
//
//  Created by 이중엽 on 2022/08/10.
//

import UIKit

class ViewController: UIViewController {
    
    //MARK: 변수 선언
    @IBOutlet weak var mainLabel: UILabel!
    @IBOutlet weak var numberLabel: UILabel!
    
    var comNum: Int = Int.random(in: 1 ... 10)
    
    @IBOutlet weak var stack1: UIStackView!
    @IBOutlet weak var stack2: UIStackView!
    
    //버튼
    @IBOutlet weak var resetButton: UIButton!
    
    //MARK: 앱 첫 실행 함수
    //앱을 화면에 들어오면 처음 실행시키는 함수
    override func viewDidLoad() {
        super.viewDidLoad()
        
        mainLabel.text = "선택하세요."
        numberLabel.text = ""
        
    }

    //MARK: 메서드 선언
    
    @IBAction func buttonTapped(_ sender: UIButton) {
        // 1) 버튼의 숫자를 가져옴
        // 2) numberLabel이 입력한 숫자에 따라 변화
        // 3) 선택한 숫자를 임의의 변수에 저장
//        if sender.isEnabled {
            numberLabel.text = sender.currentTitle
//        }
    }
    
    @IBAction func selectButtonTapped(_ sender: UIButton) {
        //1) 컴퓨터의 숫자와 내가 입력한 숫자를 비교 UP / DOWN / BINGO (mainLabel)
        guard let num = numberLabel.text else { return }
        guard let myNum = Int(num) else {
            mainLabel.text = "선택된 숫자가 없습니다."
            return
        }
        
        if comNum > myNum {
            mainLabel.text = "Up"
        }
        else if comNum < myNum {
            mainLabel.text = "Down"
        }
        else {
            mainLabel.text = "Bingo"
            setButtonEnabled(false)
        }
        
    }
    
    
    @IBAction func resetButtonTapped(_ sender: UIButton) {
        mainLabel.text = "선택하세요."
        numberLabel.text = ""
        
        comNum = Int.random(in: 1 ... 10)
        setButtonEnabled(true)
    }
    
    func setButtonEnabled(_ enable: Bool) {
        let stackCount = stack1.arrangedSubviews.count
        for idx in (0 ..< stackCount) {
            let stackViewItem = stack1.arrangedSubviews[idx] as! UIButton
            stackViewItem.isEnabled = enable
        }
        
        let stackCount2 = stack2.arrangedSubviews.count
        for idx in (0 ..< stackCount2) {
            let stackViewItem = stack2.arrangedSubviews[idx] as! UIButton
            stackViewItem.isEnabled = enable
        }
    }
}
