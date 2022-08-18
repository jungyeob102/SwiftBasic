//
//  ViewController.swift
//  Test
//
//  Created by 이중엽 on 2022/08/10.
//

import UIKit

class TodoListViewController: UIViewController {
    
    //MARK: 변수 선언
    @IBOutlet weak var collectionView: UICollectionView!
    
    //MARK: 앱 첫 실행 함수
    //앱을 화면에 들어오면 처음 실행시키는 함수
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }

    //MARK: 메서드 선언
    
}

class TodoListHeaderView: UICollectionReusableView {

}

//MARK: - Class - TodoListCell
///**Class TodoListCell**
///- note: TodoListCell - Todo 객체(cell)들을 담는 리스트 뷰
///- note: UICollectionViewCell
///- authors: 이중엽
class TodoListCell: UICollectionViewCell {
    
    //MARK: Class - TodoListCell - Property
    //Button
    @IBOutlet weak var checkButton: UIButton!
    @IBOutlet weak var deleteButton: UIButton!
    //Label
    @IBOutlet weak var descriptionLabel: UILabel!
    //View
    @IBOutlet weak var strikeThroughView: UIView!
    //View Constraint - 넓이
    @IBOutlet weak var strikeThroughWidth: NSLayoutConstraint!
    
    //Closure - handler
    var doneButtonTapHandler: ((Bool) -> Void)?
    var deleteButtonTapHandler: (() -> Void)?
    
    //MARK: Class - TodoListCell - Method
    
    ///**StrikeThrough 노출 함수**
    ///- note: param show를 통해 Strike Through의 넓이를 descriptionLabel의 넓이로 변경
    ///- parameters:
    ///     - show: strike Through를 노출할지 여부 (Bool 타입)
    ///- returns:
    private func showStrikeThrough(_ show: Bool) {
        if show {
            strikeThroughWidth.constant = descriptionLabel.bounds.width
        } else {
            strikeThroughWidth.constant = 0
        }
    }
    
    ///**체크 버튼 액션 함수**
    ///- note: 토글 형식으로 check Button의 체크 여부를 파악하고 그 외 동작들을 실행한다.
    /// 1. strike Though를 노출할지 여부를 결정
    /// 2. description Label 투명도 결정
    /// 3. delete Button 노출 결정
    /// 4. DoneButtonTapHandler 실행 여부
    ///- parameters:
    ///- returns:
    @IBAction func checkButtonTapped(_ sender: UIButton) {
        //토글 형식
        //현재 눌렸으면(true) -> 취소 (false)
        //현재 안눌렸으면(false) -> 체크 (true)
        checkButton.isSelected = !checkButton.isSelected
        
        let isDone = checkButton.isSelected
        showStrikeThrough(isDone)
        //alpha? 투명도를 얘기하는 듯
        descriptionLabel.alpha = isDone ? 0.2 : 1
        //isDone이 true이면 노출 (is Hidden은 false일 때 노출)
        deleteButton.isHidden = !isDone
        doneButtonTapHandler?(isDone)
    }
    
    ///**삭제 버튼 액션 함수**
    ///- note: deleteButtonTapHandler를 통해 동작 여부 전달
    ///- parameters:
    ///- returns:
    @IBAction func deleteButtonTapped(_ sender: UIButton) {
        deleteButtonTapHandler?()
    }
    
    
}
