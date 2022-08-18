//
//  ViewController.swift
//
//  Created by 이중엽 on 2022/08/10.
//

import UIKit

//MARK: - Class - TodoListViewController
///**Class TodoListViewController**
///- note: UIViewController 클래스
///- authors: 이중엽
class TodoListViewController: UIViewController {
    
    //MARK: 변수 선언
    //View
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var inputViewBottom: NSLayoutConstraint!
    @IBOutlet weak var inputTextField: UITextField!
    
    //Button
    @IBOutlet weak var isTodayButton: UIButton!
    @IBOutlet weak var addButton: UIButton!
    
    let todoListViewModel = TodoViewModel()
    
    ///**앱을 화면에 들어오면 처음 실행시키는 함수**
    ///- note: 키보드 반응 연결 및 데이터 불러오기
    ///- parameters:
    ///- returns:
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //키보드 디텍션
        //self (UIViewController) 가 관찰하고 UIResponder.keyboardWillShowNotification가 감지되면, selector 메소드 실행
        //#selector(메소드) = 메소드를 selector 인스턴스로 생성
        //해당 메소드는 @objc 속성을 달아주어야함
        NotificationCenter.default.addObserver(self, selector: #selector(adjustInputView), name: UIResponder.keyboardWillShowNotification, object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(adjustInputView), name: UIResponder.keyboardWillHideNotification, object: nil)
        
        //데이터 불러오기
        todoListViewModel.loadTasks()
    }

    //MARK: 메서드 선언
    
    ///**today 버튼 클릭 시 액션 버튼**
    ///- note: today 체크
    ///- parameters:
    ///- returns:
    @IBAction func isTodayButtonTapped(_ sender: UIButton) {
        //토글 형태로 구현
        isTodayButton.isSelected = !isTodayButton.isSelected
    }
    
    ///**추가 버튼 클릭 시 액션 버튼**
    ///- note: input task field에 작성한 text로 todo 객체를 생성하여 저장
    ///- parameters:
    ///- returns:
    @IBAction func addTaskButtonTapped(_ sender: UIButton) {
        //input 데이터 정보
        guard let detail = inputTextField.text, detail.isEmpty == false else { return }
        
        //입력받은 데이터와 isToday 체크 여부로 todo 인스턴스 생성
        let todo = TodoManager.shared.createTodo(detail: detail, isToday: isTodayButton.isSelected)
        
        //todo 객체를 todos 리스트에 추가
        todoListViewModel.addTodo(todo)
        
        //collection View 리로드
        collectionView.reloadData()
        
        //text field 초기화
        inputTextField.text = ""
        
        //today 버튼 초기화
        isTodayButton.isSelected = false
    }
    
    ///**배경화면 View 터치시 액션 함수**
    ///- note: input text field에 집중되어 있는 responder를 해지
    ///- parameters:
    ///- returns:
    @IBAction func tapBG(_ sender: Any) {
        //키보드가 올라와 있는 first Responder를 resign
        inputTextField.resignFirstResponder()
    }
    
}

//MARK: - Extension - TodoListViewController - UICollectionViewDataSource
///**Extension TodoListViewController**
///- note: collection view의 데이터를 관리
///- note: UICollectionViewDataSource
///- authors: 이중엽
extension TodoListViewController: UICollectionViewDataSource{
    
    ///**섹션의 갯수를 반환**
    ///- note: 섹션의 갯수
    ///- parameters:
    ///- returns: Int
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        //today , comming up 두개
        return todoListViewModel.numOfSection
    }
    
    ///**섹션 별 아이템이 몇개인지 리턴**
    ///- note: 섹션 별 아이템 갯수 반환
    ///- note: UICollectionViewDataSource 프로토콜 구현 **필수 메소드**
    ///- parameters:
    ///     - numberOfItemsInSection: section index
    ///- returns: Int
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if section == 0 {
            return todoListViewModel.todayTodos.count
        } else {
            return todoListViewModel.upcomingTodos.count
        }
    }
    
    ///**셀 설정**
    ///- note: cell(todo 객체) 설정
    ///- note: UICollectionViewDataSource 프로토콜 구현 **필수 메소드**
    ///- parameters:
    ///     - cellForItemAt: 셀의 index 정보
    ///- returns: UICollectionReusableView()
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        //cell = identifier가 TodoListCell인 cell
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "TodoListCell", for: indexPath) as? TodoListCell else {
            return UICollectionViewCell()
        }
        
        //Todo 변수 생성
        var todo: Todo
        
        //section은 총 2가지로 Today(index == 0) 와 CommingUp(index == 1) 중 하나
        //indexPath.section가 0인 경우에 todo는 today 배열의 아이템(todo)
        //indexPath.section가 1인 경우에 todo는 upcoming 배열의 아이템(todo)
        if indexPath.section == 0 {
            todo = todoListViewModel.todayTodos[indexPath.item]
        }else {
            todo = todoListViewModel.upcomingTodos[indexPath.item]
        }
        
        //cell(== todo) 인스턴스 데이터 설정(업데이트)
        cell.updateUI(todo: todo)
        
        //doneButtonTapHandler 클로저가 실행될 때 실행
        //데이터 리로드
        cell.doneButtonTapHandler = { isDone in
            todo.isDone = isDone
            self.todoListViewModel.updateTodo(todo)
            self.collectionView.reloadData()
        }
        
        //deleteButtonTapHandler 클로저가 실행될 때 실행
        //데이터 리로드
        cell.deleteButtonTapHandler = {
            self.todoListViewModel.deleteTodo(todo)
            self.collectionView.reloadData()
        }
        return cell
    }
    
    ///**헤더뷰 설정**
    ///- note: TodoListHeaderView의 Title 변경 및 설정
    ///- note: UICollectionReusableView를 추가하면 구현해야 하는 **필수 메소드**
    ///- parameters:
    ///     - viewForSupplementaryElementOfKind: section의 종류 (header, footer)
    ///- returns: UICollectionReusableView()
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        
        //kind의 종류는 header 또는 footer
        switch kind {
        case UICollectionView.elementKindSectionHeader:
            guard let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "TodoListHeaderView", for: indexPath) as? TodoListHeaderView else {
                return UICollectionReusableView()
            }
            
            guard let section = TodoViewModel.Section(rawValue: indexPath.section) else {
                return UICollectionReusableView()
            }
            
            header.sectionTitleLabel.text = section.title
            return header
            
        default:
            return UICollectionReusableView()
        }
    }
}

//MARK: - Extension - TodoListViewController - UICollectionViewDelegateFlowLayout
///**Extension TodoListViewController**
///- note: cell의 너비와 높이를 구성하기 위한 extention
///- note: UICollectionViewDelegateFlowLayout
///- authors: 이중엽
extension TodoListViewController: UICollectionViewDelegateFlowLayout {
    
    //cell의 너비와 높이를 구성
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let width: CGFloat = collectionView.bounds.width
        let height: CGFloat = 50
        return CGSize(width: width, height: height)
    }
}

//MARK: - Extension - TodoListViewController
///**Extension TodoListViewController**
///- note: 키보드 반응 관련 함수를 구현하기 위한 extension
///- authors: 이중엽
extension TodoListViewController {
    ///**키보드 노출과 함께 view의 하단 위치를 변환**
    ///- note: 키보드가 노출되어 가려지는 하단 View를 키보드의 높이만큼 위로 이동
    ///- parameters:
    ///     - noti: text Field를 클릭했을 때 관련 정보
    ///- returns:
    @objc private func adjustInputView(noti: Notification) {
        //noti의 userInfo가 없으면 함수 종료
        guard let userInfo = noti.userInfo else { return }

        //키보드 프레임 정보
        guard let keyboardFrame = (userInfo[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue else { return }
        
        //noti.name이 keyboardWillShowNotification일 경우 키보드 위치에 맞추어 하단 View 높이 변경
        if noti.name == UIResponder.keyboardWillShowNotification{
            let adjustmentHeight = keyboardFrame.height - view.safeAreaInsets.bottom
            
            print(keyboardFrame.height)
            print(adjustmentHeight)
            inputViewBottom.constant = adjustmentHeight
        }
        //noti.name이 keyboardWillHideNotification일 경우 하단 View 원위치
        else{
            inputViewBottom.constant = 0
        }
    }
    
}

//MARK: - Class - TodoListHeaderView - UICollectionReusableView
///**Class TodoListHeaderView**
///- note: TodoListHeaderView - Todo List Head 부분 Section 영역으로 UICollectionReusableView 클래스 상속
///- note: UICollectionReusableView
///- authors: 이중엽
class TodoListHeaderView: UICollectionReusableView {
    
    @IBOutlet weak var sectionTitleLabel: UILabel!

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
        
    ///**화면이 스토리보드에서 띄워 깨어났을 때 상태 cell의 상태 reset**
    ///- note: 화면이 스토리보드에서 띄워 깨어났을 때 상태 cell의 상태 reset
    ///- parameters:
    ///- returns:
    override func awakeFromNib() {
        super.awakeFromNib()
        reset()
    }
    
    ///**cell의 재사용을 준비할 때 cell의 상태 reset**
    ///- note: cell의 재사용을 준비할 때 cell의 상태 reset
    ///- parameters:
    ///- returns:
    override func prepareForReuse() {
        super.prepareForReuse()
        reset()
    }
    
    ///**cell의 상태 초기 상태로 리셋**
    ///- note: cell 초기 상태로 reset
    ///- parameters:
    ///- returns:
    func reset() {
        descriptionLabel.alpha = 1
        deleteButton.isHidden = true
        showStrikeThrough(false)
    }
    
    ///**updateUI UI 업데이트**
    ///- note: UI의 todo를 각 객체에 맞추어 수정해준다.
    ///- parameters:
    ///     - todo: Todo 인스턴스
    ///- returns:
    func updateUI(todo: Todo) {
        checkButton.isSelected = todo.isDone
        descriptionLabel.text = todo.detail
        descriptionLabel.alpha = todo.isDone ? 0.2 : 1
        deleteButton.isHidden = todo.isDone == false
        showStrikeThrough(todo.isDone)
    }

    
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
        //alpha - 선명도
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
        print("버튼 클릭")
        deleteButtonTapHandler?()
    }
    
    
}
