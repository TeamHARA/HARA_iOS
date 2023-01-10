//
//  SecondStepView.swift
//  HARA
//
//  Created by saint on 2023/01/03.
//

import UIKit
import SnapKit
import Then

class SecondWriteStepVC: UIViewController{
    
    // MARK: - Properties
    private let background = UIImageView().then {
        $0.image = UIImage(named: "background")
        $0.contentMode = .scaleToFill
        $0.backgroundColor = .clear
    }
    
    /// stackView의 height을 동적으로 주기 위한 변수
    private var stackViewheight: Int = Int(112.adjustedH)
    
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

    /// stackView의 추가할 뷰들 구현
    private lazy var firstOptionView = BaseOptionView()
    private lazy var secondOptionView = BaseOptionView()
    private lazy var thirdOptionView = AddOptionView()
    private lazy var fourthOptionView = AddOptionView()
    private lazy var addButton = AddOptionBtnView()
    
    private lazy var stackBaseOptionArray: [BaseOptionView] = [firstOptionView, secondOptionView]
    private lazy var stackAddOptionArray: [AddOptionView] = []

    private lazy var optionStackView = UIStackView(arrangedSubviews: [firstOptionView, secondOptionView]).then {
        $0.axis = .vertical // default
        $0.distribution = .fillEqually // default
        $0.alignment = .fill // default
        $0.spacing = 16.adjustedH
    }
    
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
    /// 키보드가 보일때 화면을 위로 160 만큼 올린다.
    @objc func keyboardWillShown(_ notificiation: NSNotification) {
      self.view.frame = CGRect(x: 0, y: -100, width: self.view.frame.size.width, height: self.view.frame.size.height)
    }
     
    /// 키보드가 사라질때 화면을 다시 원복한다.
    @objc func keyboardWillBeHidden(_ notification: NSNotification) {
      self.view.frame = CGRect(x: 0, y: 0, width: self.view.frame.size.width, height: self.view.frame.size.height)
    }
    
    private func setPress() {
        addButton.addOptionButton.press { [self] in
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
        fourthOptionView.deleteButton.press {[self] in
            /// 선택지의 height 만큼 stackview의 높이를 조정해줌
            stackViewheight -= Int(64.adjustedH)
            self.optionStackView.snp.updateConstraints {
                $0.height.equalTo(self.stackViewheight)
            }
            fourthOptionView.optionTextField.text = ""
            optionStackView.removeArrangedSubview(fourthOptionView)
            fourthOptionView.removeFromSuperview()
            addButton.isHidden = false
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
    /// ✅ textField 에서 편집을 시작한 후
    func textFieldDidBeginEditing(_ textField: UITextField) {
        /// 키보드 업
        textField.becomeFirstResponder()
        /// 입력 시 textField 를 강조하기 위한 테두리 설정
        textField.layer.borderWidth = 1
        textField.layer.borderColor = UIColor.red.cgColor
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.becomeFirstResponder()
        return true
    }
}
