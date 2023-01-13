//
//  FirstStepView.swift
//  HARA
//
//  Created by saint on 2023/01/03.
//

import UIKit
import SnapKit
import Then

// MARK: - Protocols
protocol CheckVc1Delegate: AnyObject{
    func checkText(checkTextfield: Bool, checkTextView: Bool)
}

protocol ServerVc1Delegate: AnyObject{
    func saveVc1Data(title: String, content: String)
}

class FirstWriteStepVC: UIViewController{
    
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
    
    private var checkTextfield: Bool = false
    private var checkTextView: Bool = false
    
    private let questionLabel = UILabel().then{
        $0.numberOfLines = 2
        let boldString = NSAttributedString(string: "무엇", attributes: [
            .font: UIFont.haraM1B24])
        let normalString = NSAttributedString(string: "에 대해\n고민중인가요?", attributes: [
            .font: UIFont.haraM1M24])
        
        let title = boldString + normalString
        $0.attributedText = title
    }
    
    let titleletterNumLabel = UILabel().then {
        $0.text = "0/25"
        $0.font = .haraB3R14
        $0.textColor = .hGray3
        $0.textAlignment = .right
    }
    
    private let titleTextField = UITextField().then{
        $0.borderStyle = .none
        $0.layer.borderColor = UIColor.clear.cgColor
        $0.layer.borderWidth = 1
        $0.backgroundColor = .clear
        $0.placeholder = "고민의 제목을 입력해주세요."
        $0.font = .haraM2M18
        $0.textColor = .hGray3
    }
    
    private let editImage = UIImageView().then {
        $0.image = UIImage(named: "editBtn")
        $0.contentMode = .scaleToFill
        $0.backgroundColor = .clear
    }
    
    private let titleUnderLine = UIView().then{
        $0.backgroundColor = .hBlue2
    }
    
    weak var checkVc1Delegate: CheckVc1Delegate?
    weak var serverVc1Delegate: ServerVc1Delegate?
    
    let placeholder = "고민에 대해 더 자세히 적어주세요."
    
    let infoTextView = UITextView().then {
        $0.font = .haraH2M16
        $0.textColor = .hGray3
        $0.layer.cornerRadius = 12
        $0.layer.borderColor = UIColor.hBlue3.cgColor
        $0.layer.borderWidth = 1
        $0.backgroundColor = .clear
        $0.textContainerInset = UIEdgeInsets(top: 14.adjustedH, left: 12.adjustedW, bottom: 14.adjustedH, right: 12.adjustedW)
    }
    
    let detailletterNumLabel = UILabel().then {
        $0.text = "0/300"
        $0.font = .haraB3R14
        $0.textColor = .hGray3
        $0.textAlignment = .right
    }
    
    // MARK: - Life Cycles
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.isHidden = true
        self.view.backgroundColor = .white
        titleTextField.delegate = self
        titleTextField.returnKeyType = .done
        setLayout()
        setKeyboardLocation()
        setupTextView()
    }
    
    // MARK: - Function
    private func setKeyboardLocation() {
        /// 등록
        NotificationCenter.default.addObserver(self, selector:#selector(keyboardWillShown(_:)),name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector:#selector(keyboardWillBeHidden(_:)),name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    /// 키보드가 보일때 화면을 위로 100 만큼 올린다.
    @objc func keyboardWillShown(_ notificiation: NSNotification) {
      self.view.frame = CGRect(x: 0, y: -100, width: self.view.frame.size.width, height: self.view.frame.size.height)
    }
     
    /// 키보드가 사라질때 화면을 다시 원복한다.
    @objc func keyboardWillBeHidden(_ notification: NSNotification) {
      self.view.frame = CGRect(x: 0, y: 0, width: self.view.frame.size.width, height: self.view.frame.size.height)
    }
    
    func setupTextView() {
        infoTextView.delegate = self
        infoTextView.text = placeholder /// 초반 placeholder 생성
        infoTextView.textColor = .hGray3 /// 초반 placeholder 색상 설정
    }
}

// MARK: - Layout
extension FirstWriteStepVC{
    private func setLayout(){
        view.addSubViews([background, navigationView, progressView, questionLabel, titleletterNumLabel, titleTextField, editImage, titleUnderLine,
                          infoTextView, detailletterNumLabel])
        
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
            $0.width.equalTo((UIScreen.main.bounds.size.width/4))
        }
        
        questionLabel.snp.makeConstraints{
            $0.top.equalTo(progressView.snp.bottom).offset(70.adjustedH)
            $0.leading.equalToSuperview().offset(16.adjustedW)
        }
        
        titleletterNumLabel.snp.makeConstraints {
            $0.top.equalTo(titleUnderLine.snp.bottom).offset(3.adjustedH)
            $0.trailing.equalToSuperview().offset(-20.adjustedW)
        }
        
        titleTextField.snp.makeConstraints{
            $0.top.equalTo(questionLabel.snp.bottom).offset(34.adjustedH)
            $0.leading.equalToSuperview().offset(18.adjustedW)
            $0.trailing.equalToSuperview().offset(-40.adjustedW)
            $0.height.equalTo(32.adjustedH)
        }
        
        editImage.snp.makeConstraints{
            $0.trailing.equalToSuperview().offset(-18.adjustedW)
            $0.centerY.equalTo(titleTextField)
            $0.width.equalTo(17.adjustedW)
            $0.height.equalTo(17.adjustedH)
        }
        
        titleUnderLine.snp.makeConstraints{
            $0.top.equalTo(titleTextField.snp.bottom).offset(5.adjustedH)
            $0.leading.equalToSuperview().offset(16.adjustedW)
            $0.trailing.equalToSuperview().offset(-16.adjustedW)
            $0.height.equalTo(1)
        }
        
        infoTextView.snp.makeConstraints{
            $0.top.equalTo(titleUnderLine.snp.bottom).offset(38.adjustedH)
            $0.leading.equalToSuperview().offset(16.adjustedW)
            $0.trailing.equalToSuperview().offset(-16.adjustedW)
            $0.height.equalTo(314.adjustedH)
        }
        
        detailletterNumLabel.snp.makeConstraints{
            $0.bottom.equalTo(infoTextView.snp.bottom).offset(-16.adjustedH)
            $0.trailing.equalTo(infoTextView.snp.trailing).offset(-16.adjustedW)
        }
    }
}

// MARK: - UITextFieldDelegate
extension FirstWriteStepVC: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.becomeFirstResponder()
        return true
    }
    
    /// 글자수 25자 이하로 제한
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if let char = string.cString(using: String.Encoding.utf8) {
            /// backSpace는 글자수 제한이 걸려도 눌릴 수 있게 해줌
            let isBackSpace = strcmp(char, "\\b")
            if isBackSpace == -92 {
                return true
            }
        }
        guard textField.text!.count < 25 else { return false }
        return true
    }
    
    func textFieldDidChangeSelection(_ textField: UITextField) {
        /// 글자 수 부분 색상 변경 및 글자 수 표시
        let attributedString = NSMutableAttributedString(string: "\(titleTextField.text!.count)/25")
        attributedString.addAttribute(.foregroundColor, value: UIColor.hBlue1, range: ("\(titleTextField.text!.count)/25" as NSString).range(of:"\(titleTextField.text!.count)"))
        titleletterNumLabel.attributedText = attributedString
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        if textField.text!.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty || textField.text == placeholder {
            checkTextfield = false
        }else{
            checkTextfield = true
        }
        /// 텍스트 필드 및 텍스트 뷰 확인 후에 WriteVC로 데이터 전달
        checkVc1Delegate?.checkText(checkTextfield: checkTextfield, checkTextView: checkTextView)
        /// WriteVC로 변경된 데이터를 전달
        serverVc1Delegate?.saveVc1Data(title: titleTextField.text!, content: infoTextView.text)
    }
}

// MARK: - UITextViewDelegate
extension FirstWriteStepVC: UITextViewDelegate {
    func textViewDidBeginEditing(_ textView: UITextView) {
        /// 플레이스홀더
        if textView.text.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty {
            infoTextView.textColor = .hGray3
            infoTextView.text = placeholder
        } else if textView.text == placeholder {
            infoTextView.textColor = .hGray3
            infoTextView.text = nil
        }
    }
    
    func textViewDidChange(_ textView: UITextView) {
        /// 글자 수 제한
        if infoTextView.text.count > 300 {
            infoTextView.deleteBackward()
        }
        
        /// 아래 글자 수 표시되게 하기
        detailletterNumLabel.text = "\(infoTextView.text.count)/300"
        
        /// 글자 수 부분 색상 변경
        let attributedString = NSMutableAttributedString(string: "\(infoTextView.text.count)/300")
        attributedString.addAttribute(.foregroundColor, value: UIColor.hBlue1, range: ("\(infoTextView.text.count)/300" as NSString).range(of:"\(infoTextView.text.count)"))
        detailletterNumLabel.attributedText = attributedString
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        /// 플레이스홀더
        if textView.text.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty || textView.text == placeholder {
            infoTextView.textColor = .hGray3
            infoTextView.text = placeholder
            detailletterNumLabel.textColor = .hGray3 /// 텍스트 개수가 0일 경우에는 글자 수 표시 색상이 모두 gray 색이게 설정
            detailletterNumLabel.text = "0/300"
            checkTextView = false
        }
        else{
            checkTextView = true
        }
        /// 텍스트 필드 및 텍스트 뷰 확인 후에 WriteVC로 데이터 전달
        checkVc1Delegate?.checkText(checkTextfield: checkTextfield, checkTextView: checkTextView)
        /// WriteVC로 변경된 데이터를 전달
        serverVc1Delegate?.saveVc1Data(title: titleTextField.text!, content: infoTextView.text)
    }
}




