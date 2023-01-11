//
//  SecondStepView.swift
//  HARA
//
//  Created by saint on 2023/01/03.
//

import UIKit
import SnapKit
import Then

// MARK: - Protocols
protocol optionTitleDelegate: AnyObject{
    func sendOptionTitle(optionTitleArray: [String], arrayOrder: Bool)
}

// MARK: - Protocols
protocol CheckVc2Delegate: AnyObject{
    func checkText(checkBaseOption: Bool, checkAddOption: Bool, isButtonClicked: Bool)
}

class SecondWriteStepVC: UIViewController{
    
    // MARK: - Properties
    private let background = UIImageView().then {
        $0.image = UIImage(named: "background")
        $0.contentMode = .scaleToFill
        $0.backgroundColor = .clear
    }
    
    /// stackView의 height을 동적으로 주기 위한 변수
    private var stackViewheight: Int = Int(112.adjustedH)
    
    /// stackView의 순서를 맞게 반환하는지 확인하기 위한 Bool 변수
    private var orderReversed: Bool = false
    
    lazy var navigationView = UIView().then{
        $0.backgroundColor = .hBlue4
    }
    
    lazy var progressView = UIView().then{
        $0.backgroundColor = .hBlue1
    }
    
    private let questionLabel = UILabel().then{
        $0.numberOfLines = 2
        let boldString = NSAttributedString(string: "고민되는 선택지", attributes: [
            .font: UIFont.haraM1B24])
        let normalString = NSAttributedString(string: "를\n적어주세요.", attributes: [
            .font: UIFont.haraM1M24])
        
        let title = boldString + normalString
        $0.attributedText = title
    }
    
    private var checkBaseOption: Bool = false
    private var checkAddOption: Bool = false
    private var isButtonClicked: Bool = true

    /// stackView의 추가할 뷰들 구현
    private lazy var firstOptionView = BaseOptionView().then{
        $0.optionTextField.delegate = self
    }
    private lazy var secondOptionView = BaseOptionView().then{
        $0.optionTextField.delegate = self
    }
    private lazy var thirdOptionView = AddOptionView().then{
        $0.optionTextField.delegate = self
    }
    private lazy var fourthOptionView = AddOptionView().then{
        $0.optionTextField.delegate = self
    }
    private lazy var addButton = AddOptionBtnView()
    
    /// 더이상 없앨 수 없는 기본 옵션 뷰 2개
    private lazy var stackBaseOptionArray: [BaseOptionView] = [firstOptionView, secondOptionView]
    /// 추가되는 옵션뷰(삭제 버튼이 있는) 뷰를 추가해줄 Array
    lazy var stackAddOptionArray: [AddOptionView] = []
    
    /// ThirdWriteStepView로 넘겨주기 위해 각 옵션의 제목을 저장해줄 Array
    var prosConsTitleArray = [String](repeating: "", count: 4)

    private lazy var optionStackView = UIStackView(arrangedSubviews: [firstOptionView, secondOptionView]).then {
        $0.axis = .vertical // default
        $0.distribution = .fillEqually // default
        $0.alignment = .fill // default
        $0.spacing = 16.adjustedH
    }
    
    weak var titledelegate: optionTitleDelegate?
    weak var checkVc2Delegate: CheckVc2Delegate?
    
    // MARK: - Life Cycles
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.isHidden = true
        self.view.backgroundColor = .white
        setLayout()
        setPress()
        /// 등록
        NotificationCenter.default.addObserver(self, selector:#selector(keyboardWillShown(_:)),name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector:#selector(keyboardWillBeHidden(_:)),name: UIResponder.keyboardWillHideNotification, object: nil)
        //textFieldShouldReturn(infoTextField)
    }

    // MARK: - Function
    /// 키보드가 보일때 화면을 위로 120 만큼 올린다.
    @objc func keyboardWillShown(_ notificiation: NSNotification) {
      self.view.frame = CGRect(x: 0, y: -75, width: self.view.frame.size.width, height: self.view.frame.size.height)
    }
     
    /// 키보드가 사라질때 화면을 다시 원복한다.
    @objc func keyboardWillBeHidden(_ notification: NSNotification) {
      self.view.frame = CGRect(x: 0, y: 0, width: self.view.frame.size.width, height: self.view.frame.size.height)
    }
    
    private func setPress() {
        addButton.addOptionButton.press { [self] in
            /// 버튼이 클릭됨과 동시에 다음 탭으로 가는 버튼이 활성화되지 않음
            isButtonClicked = false
            checkVc2Delegate?.checkText(checkBaseOption: checkBaseOption, checkAddOption: checkAddOption, isButtonClicked: isButtonClicked)
            /// 선택지의 height 만큼 stackview의 높이를 조정해줌
            stackViewheight += Int(64.adjustedH)
            self.optionStackView.snp.updateConstraints {
                $0.height.equalTo(self.stackViewheight)
            }
            switch stackAddOptionArray{
            /// 만약 선택지가 1, 2 뿐일때, 3을 추가
            case []:
                optionStackView.addArrangedSubview(thirdOptionView)
                stackAddOptionArray.append(thirdOptionView)
            /// 만약, 선택지가 1, 2, 3일때, 4를 추가
            case [thirdOptionView]:
                optionStackView.addArrangedSubview(fourthOptionView)
                stackAddOptionArray.append(fourthOptionView)
                addButton.isHidden = true
            case [fourthOptionView]:
                optionStackView.addArrangedSubview(thirdOptionView)
                stackAddOptionArray.append(thirdOptionView)
                addButton.isHidden = true
            default:
                break
            }
        }
        thirdOptionView.deleteButton.press {[self] in
            /// 선택지의 height 만큼 stackview의 높이를 조정해줌
            stackViewheight -= Int(64.adjustedH)
            self.optionStackView.snp.updateConstraints {
                $0.height.equalTo(self.stackViewheight)
            }
            prosConsTitleArray[2] = ""
            thirdOptionView.optionTextField.text = ""
            optionStackView.removeArrangedSubview(thirdOptionView)
            thirdOptionView.removeFromSuperview()
            addButton.isHidden = false
            switch stackAddOptionArray{
            case [thirdOptionView], [thirdOptionView,fourthOptionView]:
                stackAddOptionArray.remove(at: 0)
            case [fourthOptionView, thirdOptionView]:
                stackAddOptionArray.remove(at: 1)
            default:
                break
            }
        }
        /// 네번째 옵션뷰의 삭제 버튼이 눌렸을 때,
        fourthOptionView.deleteButton.press {[self] in
            /// 선택지의 height 만큼 stackview의 높이를 조정해줌
            stackViewheight -= Int(64.adjustedH)
            self.optionStackView.snp.updateConstraints {
                $0.height.equalTo(self.stackViewheight)
            }
            prosConsTitleArray[3] = ""
            fourthOptionView.optionTextField.text = ""
            optionStackView.removeArrangedSubview(fourthOptionView)
            fourthOptionView.removeFromSuperview()
            addButton.isHidden = false
            /// 배열의 순서에 따라 값을 remove 위치를 다르게 설정
            switch stackAddOptionArray{
            case [fourthOptionView], [fourthOptionView,thirdOptionView]:
                stackAddOptionArray.remove(at: 0)
            case [thirdOptionView, fourthOptionView]:
                stackAddOptionArray.remove(at: 1)
            default:
                break
            }
        }
    }
}

// MARK: - Layout
extension SecondWriteStepVC{
    func setLayout(){
        view.addSubViews([background, navigationView, progressView, questionLabel, optionStackView, addButton])
        
        background.snp.makeConstraints{
            $0.edges.equalToSuperview()
        }
        
        navigationView.snp.makeConstraints{
            $0.top.equalToSuperview()
            $0.leading.equalToSuperview()
            $0.height.equalTo(4.adjustedH)
            $0.width.equalTo(UIScreen.main.bounds.size.width)
        }
        
        progressView.snp.makeConstraints{
            $0.top.equalToSuperview()
            $0.leading.equalToSuperview()
            $0.height.equalTo(4.adjustedH)
            $0.width.equalTo((UIScreen.main.bounds.size.width/4)*2)
        }
        
        questionLabel.snp.makeConstraints{
            $0.top.equalTo(progressView.snp.bottom).offset(70.adjustedH)
            $0.leading.equalToSuperview().offset(16.adjustedW)
        }
        
        optionStackView.snp.makeConstraints{
            $0.top.equalTo(questionLabel.snp.bottom).offset(54.adjustedH)
            $0.leading.equalToSuperview().offset(16.adjustedW)
            $0.trailing.equalToSuperview().offset(-16.adjustedW)
            $0.height.equalTo(stackViewheight)
        }
        
        addButton.snp.makeConstraints{
            $0.top.equalTo(optionStackView.snp.bottom).offset(16.adjustedH)
            $0.leading.equalToSuperview().offset(16.adjustedW)
            $0.trailing.equalToSuperview().offset(-16.adjustedW)
            $0.height.equalTo(48.adjustedH)
        }
    }
}

// MARK: - UITextFieldDelegate
extension SecondWriteStepVC: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.becomeFirstResponder()
        return true
    }

    /// 각 선택지의 제목을 작성했을 때 그 값을 배열에 계속 할당 시켜준다. 
    func textFieldDidEndEditing(_ textField: UITextField) {
        switch textField{
        case firstOptionView.optionTextField:
            prosConsTitleArray[0] = firstOptionView.optionTextField.text!
        case secondOptionView.optionTextField:
            prosConsTitleArray[1] = secondOptionView.optionTextField.text!
        case thirdOptionView.optionTextField:
            prosConsTitleArray[2] = thirdOptionView.optionTextField.text!
        case fourthOptionView.optionTextField:
            prosConsTitleArray[3] = fourthOptionView.optionTextField.text!
        default:
            break
        }

        if stackAddOptionArray == [fourthOptionView] || stackAddOptionArray == [fourthOptionView, thirdOptionView]{
            orderReversed = true
        }else{
            orderReversed = false
        }
        /// 옵션 제목이 변경될때마다 titledelgate를 통해 세번째 stepView로 값을 보내준다
        titledelegate?.sendOptionTitle(optionTitleArray: prosConsTitleArray, arrayOrder: orderReversed)
        
        /// 각 옵션의 텍스트필드를 감지하여 모두 채워져 있어야만 버튼이 활성화 되게끔 해줌
        if prosConsTitleArray[0] != "" && prosConsTitleArray[1] != "" {
            checkBaseOption = true
        }
        else {
            checkBaseOption = false
        }
        switch stackAddOptionArray {
        case []:
            checkAddOption = true
            isButtonClicked = true
        case [thirdOptionView]:
            isButtonClicked = false
            if prosConsTitleArray[2] != "" {
                checkAddOption = true
                isButtonClicked = true
            }
            else {
                checkAddOption = false
            }
            print(isButtonClicked)
        case [fourthOptionView]:
            isButtonClicked = false
            if prosConsTitleArray[3] != "" {
                checkAddOption = true
                isButtonClicked = true
            }
            else {
                checkAddOption = false
            }
        case [thirdOptionView, fourthOptionView], [fourthOptionView, thirdOptionView]:
            isButtonClicked = false
            if prosConsTitleArray[2] != "" && prosConsTitleArray[3] != "" {
                checkAddOption = true
                isButtonClicked = true
            }
            else {
                checkAddOption = false
            }
        default:
            break
        }
        /// 텍스트 필드의 값의 유무를 계속 체크해서 값이 있을 경우에만 다음 페이지로 넘겨줌
        checkVc2Delegate?.checkText(checkBaseOption: checkBaseOption, checkAddOption: checkAddOption, isButtonClicked: isButtonClicked)
    }
}
