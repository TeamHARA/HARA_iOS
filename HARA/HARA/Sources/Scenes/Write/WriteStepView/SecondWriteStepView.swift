//
//  SecondStepView.swift
//  HARA
//
//  Created by saint on 2023/01/03.
//

import UIKit
import SnapKit
import Then

class SecondWriteStepView: UIViewController{
    
    // MARK: - Properties
    private let background = UIImageView().then {
        $0.image = UIImage(named: "background")
        $0.contentMode = .scaleToFill
        $0.backgroundColor = .clear
    }
    
    lazy var navigationView = UIView().then{
        $0.backgroundColor = .hBlue4
    }
    
    lazy var progressView = UIView().then{
        $0.backgroundColor = .hBlue1
    }
    
    private let questionLabel = UILabel().then{
        $0.numberOfLines = 2
        let BoldString = NSAttributedString(string: "고민되는 선택지", attributes: [
            .font: UIFont.haraM1B24])
        let NormalString = NSAttributedString(string: "를\n적어주세요.", attributes: [
            .font: UIFont.haraM1M24])
        
        let title = BoldString + NormalString
        $0.attributedText = title
    }
//
//    /// stackView의 추가할 뷰들 구현
//    private lazy var firstOptionView = BaseOptionView().then
//    private lazy var secondOptionView = BaseOptionView().then
//    private lazy var thirdOptionView = AddOptionView().then
//    private lazy var fourthOptionView = AddOptionView().then
//
//    private lazy var optionStackView = UIStackView(arrangedSubviews: [firstOptionView, secondOptionView, thirdOptionView, fourthOptionView]).then {
//        $0.axis = .vertical // default
//        $0.distribution = .fill // default
//        $0.alignment = .fill // default
//        $0.spacing = 16.adjustedH
//    }
    
    // MARK: - Life Cycles
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.isHidden = true
        self.view.backgroundColor = .white
        setLayout()
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
}

// MARK: - Layout
extension SecondWriteStepView{
    private func setLayout(){
        view.addSubViews([background, navigationView, progressView, questionLabel,
//                         optionStackView
                         ])
        
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
        
//        optionStackView.snp.makeConstraints{
//            $0.top.equalTo(questionLabel).offset(22.adjustedH)
//            $0.leading.equalToSuperview().offset(16.adjustedW)
//            $0.trailing.equalToSuperview().offset(-16.adjustedW)
//            $0.height.equalTo(240.adjustedH)
//        }
    }
}

// MARK: - UITextFieldDelegate
extension SecondWriteStepView: UITextFieldDelegate {
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
