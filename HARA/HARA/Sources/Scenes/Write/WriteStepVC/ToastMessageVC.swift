//
//  ToastMessageView.swift
//  HARA
//
//  Created by saint on 2023/01/11.
//

import UIKit
import SnapKit
import Then

class ToastMessageVC: UIViewController {
    
    // MARK: - Properties
    private let background = UIView().then{
        $0.backgroundColor = .hGray1
    }
    
    private let optionContainerView = UIView().then{
        $0.layer.cornerRadius = 8
        $0.backgroundColor = .hWhite
    }
    
    private let toastTitle = UILabel().then{
        $0.text = "고민글을 게시하시겠습니까?"
        $0.font = .haraB1Sb14
        $0.textColor = .hBlue1
    }
    
    private let toastIntro = UILabel().then{
        $0.text = "게시된 고민글은 수정이 불가능해요"
        $0.font = .haraB3R14
        $0.textColor = .hBlack
    }
    
    let cancelButton = UIButton().then {
        $0.backgroundColor = .hWhite
        $0.layer.cornerRadius = 12
//        $0.layer.borderWidth = 1.0
//        $0.layer.borderColor = UIColor.hBlue3.cgColor
        $0.titleLabel?.font = .haraB2M14
        $0.setTitle("취소", for: .normal)
        $0.setTitleColor(.hGray1, for: .normal)
    }
    
    let acceptButton = UIButton().then {
        $0.backgroundColor = .hWhite
        $0.layer.cornerRadius = 12
//        $0.layer.borderWidth = 1.0
//        $0.layer.borderColor = UIColor.hBlue3.cgColor
        $0.titleLabel?.font = .haraB2M14
        $0.setTitle("확인", for: .normal)
        $0.setTitleColor(.hGray1, for: .normal)
    }
    
    private let hDivisionLine = UIView().then {
        $0.backgroundColor = .hBlue3
    }
    
    private let vDivisionLine = UIView().then {
        $0.backgroundColor = .hBlue3
    }
    
    // MARK: - Life Cycles
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.isHidden = true
        self.view.backgroundColor = .clear
        setLayout()
    }
}

extension ToastMessageVC{
    private func setLayout(){
        view.addSubView(background)
        background.addSubview(optionContainerView)
        optionContainerView.addSubviews([toastTitle, toastIntro, cancelButton, acceptButton, hDivisionLine, vDivisionLine])
        
        background.snp.makeConstraints{
            $0.edges.equalToSuperview()
        }
        
        optionContainerView.snp.makeConstraints {
            $0.width.equalTo(338.adjustedW)
            $0.height.equalTo(182.adjustedH)
            $0.center.equalToSuperview()
        }
        
        toastTitle.snp.makeConstraints{
            $0.top.equalTo(optionContainerView.snp.top).offset(37.adjustedH)
            $0.centerX.equalToSuperview()
            $0.height.equalTo(20)
        }
        
        toastIntro.snp.makeConstraints{
            $0.top.equalTo(toastTitle.snp.bottom).offset(12.adjustedH)
            $0.centerX.equalToSuperview()
            $0.height.equalTo(20)
        }
        
        cancelButton.snp.makeConstraints{
            $0.top.equalTo(toastIntro.snp.bottom).offset(31.adjustedH)
            $0.leading.bottom.equalToSuperview()
            $0.width.equalTo(169.adjustedW)
        }
        
        acceptButton.snp.makeConstraints{
            $0.top.equalTo(toastIntro.snp.bottom).offset(31.adjustedH)
            $0.trailing.bottom.equalToSuperview()
            $0.width.equalTo(169.adjustedW)
        }
        
        hDivisionLine.snp.makeConstraints{
            $0.top.equalTo(cancelButton.snp.top)
            $0.height.equalTo(1)
            $0.width.equalToSuperview()
        }
        
        vDivisionLine.snp.makeConstraints{
            $0.top.equalTo(cancelButton.snp.top)
            $0.trailing.equalTo(cancelButton.snp.trailing)
            $0.height.equalTo(cancelButton)
            $0.width.equalTo(1)
        }
    }
}
