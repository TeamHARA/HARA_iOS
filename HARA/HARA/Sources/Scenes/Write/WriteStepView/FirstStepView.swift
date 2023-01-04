//
//  FirstStepView.swift
//  HARA
//
//  Created by saint on 2023/01/03.
//

import UIKit
import SnapKit
import Then

class FirstStepView: UIViewController{
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.isHidden = true
        self.view.backgroundColor = .clear
    }
}

//
//class FirstStepView: UIView{
//    
//    let scrollView = UIScrollView().then {
//        $0.backgroundColor = .clear
//    }
//    
//    let contentView = UIView().then{
//        $0.backgroundColor = .clear
//    }
//    
//
//
//    private let titleTextField = UITextField().then {
//        $0.placeholder = "제목을 입력하세요"
//        $0.font = .systemFont(ofSize: 18.adjustedW, weight: .bold)
//        $0.borderStyle = .roundedRect
//    }
//
//    private let mainTextField = UITextField().then {
//        $0.placeholder = "어떤 내용을 입력할건가요?"
//        $0.font = .systemFont(ofSize: 16.adjustedW, weight: .medium)
//        $0.borderStyle = .roundedRect
//    }
//    
//    private let pracTextField = UITextField().then {
//        $0.placeholder = "어떤 내용을 입력할건가요?"
//        $0.font = .systemFont(ofSize: 16.adjustedW, weight: .medium)
//        $0.borderStyle = .roundedRect
//    }
//
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        self.navigationController?.navigationBar.isHidden = true
//        self.view.backgroundColor = .white
//        setlayout()
//        setContentViewFlow()
//        addTapGesture()
//    }
//}
//
//
//        
//        view.addSubview(scrollView)
//        scrollView.addSubview(contentView)
//        
//        scrollView.snp.makeConstraints{
//            $0.edges.equalTo(self.view.safeAreaLayoutGuide)
//        }
//        contentView.snp.makeConstraints{
//            $0.edges.equalTo(scrollView.contentLayoutGuide)
//        }
//        
//        contentView.addSubViews([closeButton, titleLabel,
//                               titleTextField, mainTextField, pracTextField])
//        
//        closeButton.snp.makeConstraints{
//            $0.top.equalToSuperview().offset(13.adjustedH)
//            $0.leading.equalToSuperview().offset(16.adjustedW)
//            $0.width.equalTo(24.adjustedW)
//            $0.height.equalTo(24.adjustedH)
//        }
//        titleLabel.snp.makeConstraints{
//            $0.top.equalToSuperview().offset(15)
//            $0.centerX.equalToSuperview()
//        }
//        titleTextField.snp.makeConstraints {
//            $0.top.equalTo(closeButton.snp.bottom).offset(90.adjustedH)
//            $0.leading.equalToSuperview().offset(16.adjustedW)
//            $0.trailing.equalToSuperview().offset(-16.adjustedW)
//            $0.height.equalTo(40.adjustedH)
//        }
//        mainTextField.snp.makeConstraints {
//            $0.top.equalTo(closeButton.snp.bottom).offset(144.adjustedH)
//            $0.leading.equalToSuperview().offset(16.adjustedW)
//            $0.trailing.equalToSuperview().offset(-16.adjustedW)
//            $0.height.equalTo(156.adjustedH)
//        }
//        pracTextField.snp.makeConstraints {
//            $0.top.equalTo(closeButton.snp.bottom).offset(300.adjustedH)
//            $0.leading.equalToSuperview().offset(16.adjustedW)
//            $0.trailing.equalToSuperview().offset(-16.adjustedW)
//            $0.height.equalTo(800.adjustedH)
//        }
//    }
//    
//    private func setContentViewFlow() {
//        contentView.widthAnchor.constraint(equalTo: scrollView.widthAnchor).isActive = true
//
//        let contentViewHeight = contentView.heightAnchor.constraint(greaterThanOrEqualTo: view.heightAnchor)
//        contentViewHeight.priority = .defaultLow
//        contentViewHeight.isActive = true
//    }
//
//    private func addTapGesture() {
//        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(hideKeyboard(_:)))
//        view.addGestureRecognizer(tapGesture)
//    }
//    
//    @objc
//    private func hideKeyboard(_ sender: Any) {
//        view.endEditing(true)
//    }
//}
//
//extension WriteVC: UITextFieldDelegate {
//    /// ✅ textField 에서 편집을 시작한 후
//    func textFieldDidBeginEditing(_ textField: UITextField) {
//        /// 키보드 업
//        textField.becomeFirstResponder()
//        /// 입력 시 textField 를 강조하기 위한 테두리 설정
//        textField.layer.borderWidth = 2
//        textField.layer.borderColor = UIColor.red.cgColor
//    }
//}
