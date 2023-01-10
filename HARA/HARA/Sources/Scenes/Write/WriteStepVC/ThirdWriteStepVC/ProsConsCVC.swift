//
//  ProsConsView.swift
//  HARA
//
//  Created by saint on 2023/01/09.
//

import UIKit
import SnapKit
import Then

class ProsConsCVC: UICollectionViewCell {
    
    // MARK: - Properties
    private let optionContainerView = UIView().then{
        $0.layer.borderColor = UIColor.hBlue3.cgColor
        $0.layer.borderWidth = 1
        $0.layer.cornerRadius = 8
        $0.backgroundColor = .blue
    }
    
    let optionTitle = UILabel().then{
        $0.font = .haraH2M16
        $0.textColor = .hGray3
        $0.text = "안녕 나는 리드 김담인"
    }
    
    let imageInsertButton = UIButton().then {
        $0.setBackgroundImage(UIImage(named: "insertImageBtn"), for: .normal)
        $0.contentMode = .scaleAspectFit
    }
    
    private let divisionLine = UIView().then {
        $0.backgroundColor = .hBlue3
    }
    
    private let prosLabel = UILabel().then{
        $0.backgroundColor = .clear
        $0.text = "장점"
        $0.font = .haraB2M14
        $0.textColor = .hBlue1
    }
    
    private let consLabel = UILabel().then{
        $0.backgroundColor = .clear
        $0.text = "단점"
        $0.font = .haraB2M14
        $0.textColor = .hRed
    }
    
    let prosPlaceHolder = "해당 선택지의 장점을 적어보세요"
    let consPlaceHolder = "해당 선택지의 단점을 적어보세요"
    
    private let prosTextView = UITextView().then{
        $0.font = .haraH2M16
        $0.textColor = .hGray3
        $0.backgroundColor = .hRed
        $0.layer.cornerRadius = 12
        $0.layer.borderColor = UIColor.hBlue3.cgColor
        $0.layer.borderWidth = 1
        $0.backgroundColor = .clear
        $0.textContainerInset = UIEdgeInsets(top: 5.adjustedH, left: 39.adjustedW, bottom: 5.adjustedH, right: 8.adjustedW)
    }
    
    private let consTextView = UITextView().then{
        $0.font = .haraH2M16
        $0.textColor = .hGray3
        $0.backgroundColor = .hRed
        $0.layer.cornerRadius = 12
        $0.layer.borderColor = UIColor.hBlue3.cgColor
        $0.layer.borderWidth = 1
        $0.backgroundColor = .clear
        $0.textContainerInset = UIEdgeInsets(top: 5.adjustedH, left: 39.adjustedW, bottom: 5.adjustedH, right: 8.adjustedW)
    }
    
    // MARK: - Life Cycles
    override init(frame: CGRect) {
        super.init(frame: frame)
        setLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Functions
    func setupTextView() {
        prosTextView.delegate = self
        prosTextView.text = prosPlaceHolder /// 초반 placeholder 생성
        prosTextView.textColor = .hGray3 /// 초반 placeholder 색상 설정
        
        consTextView.delegate = self
        consTextView.text = consPlaceHolder /// 초반 placeholder 생성
        consTextView.textColor = .hGray3 /// 초반 placeholder 색상 설정
    }
}

extension ProsConsView{
    private func setLayout(){
        self.addSubView(optionContainerView)
        optionContainerView.addSubviews([optionTitle, imageInsertButton, divisionLine, prosTextView, consTextView])
        
        optionContainerView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        optionTitle.snp.makeConstraints{
            $0.leading.equalToSuperview().offset(14.adjustedW)
            $0.top.equalToSuperview().offset(15.adjustedH)
            $0.trailing.equalTo(imageInsertButton.snp.leading).offset(-10.adjustedW)
            $0.height.equalTo(19.adjustedH)
        }
        
        imageInsertButton.snp.makeConstraints{
            $0.top.equalToSuperview().offset(16.adjustedH)
            $0.trailing.equalToSuperview().offset(-15.adjustedW)
            $0.width.equalTo(18.adjustedW)
            $0.height.equalTo(18.adjustedH)
        }
        
        divisionLine.snp.makeConstraints{
            $0.top.equalTo(optionTitle.snp.bottom).offset(16.adjustedH)
            $0.centerX.equalToSuperview()
            $0.width.equalTo(315.adjustedW)
            $0.height.equalTo(1)
        }
        
        prosTextView.snp.makeConstraints{
            $0.top.equalTo(divisionLine.snp.bottom).offset(14.adjustedH)
            $0.centerX.equalToSuperview()
            $0.width.equalTo(315.adjustedW)
            $0.height.equalTo(34.adjustedH)
        }
        
        consTextView.snp.makeConstraints{
            $0.top.equalTo(prosTextView.snp.bottom).offset(6.adjustedH)
            $0.centerX.equalToSuperview()
            $0.width.equalTo(315.adjustedW)
            $0.height.equalTo(34.adjustedH)
        }
    }
}

// MARK: - UITextViewDelegate
extension ProsConsView: UITextViewDelegate{
    internal func textViewDidChange(_ textView: UITextView) { // internal/>?
        
        let size = CGSize(width: 315.adjustedW, height: .infinity)
        let estimatedSize = textView.sizeThatFits(size)
        
        textView.constraints.forEach { (constraint) in
            /// 180 이하일때는 더 이상 줄어들지 않게하기
            if estimatedSize.height <= 34 {
            }
            else {
                if constraint.firstAttribute == .height {
                    constraint.constant = estimatedSize.height
                }
            }
        }
        /// 글자 수 제한
        if prosTextView.text.count > 50{
            prosTextView.deleteBackward()
        }
        else if consTextView.text.count > 50{
            consTextView.deleteBackward()
        }
    }
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        /// 플레이스홀더
        if textView.text.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty {
            prosTextView.text = prosPlaceHolder /// 초반 placeholder 생성
            prosTextView.textColor = .hGray3 /// 초반 placeholder 색상 설정

            consTextView.text = consPlaceHolder /// 초반 placeholder 생성
            consTextView.textColor = .hGray3 /// 초반 placeholder 색상 설정
        } else if prosTextView.text == prosPlaceHolder {
            prosTextView.text = nil /// placeholder 제거
            prosTextView.textColor = .hGray3 /// 글자색 설정
        }
        else if consTextView.text == consPlaceHolder{
            consTextView.text = nil /// placeholder 제거
            consTextView.textColor = .hGray3 /// 글자색 설정
        }
    }
}
