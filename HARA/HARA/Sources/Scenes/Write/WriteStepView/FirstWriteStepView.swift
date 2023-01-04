//
//  FirstStepView.swift
//  HARA
//
//  Created by saint on 2023/01/03.
//

import UIKit
import SnapKit
import Then

class FirstWriteStepView: UIViewController{
    
    lazy var navigationView = UIView().then{
        $0.backgroundColor = .hBlue4
    }
    
    lazy var progressView = UIView().then{
        $0.backgroundColor = .hBlue1
    }
    
    private let questionLabel = UILabel().then{
        $0.numberOfLines = 3
        $0.text = "Q.\n내 고민의\n제목이 무엇인가요?"
        $0.font = .haraM1M24
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.isHidden = true
        self.view.backgroundColor = .hGray1
        setLayout()
    }
}

extension FirstWriteStepView{
    private func setLayout(){
        view.addSubViews([navigationView, progressView])
        
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
//        setLayout()
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

