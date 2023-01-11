//
//  FinalChoiceCVC.swift
//  HARA
//
//  Created by 김담인 on 2023/01/11.
//

import UIKit
import SnapKit
import Then

class FinalChoiceCVC: UICollectionViewCell {
    
    // MARK: - Properties
    
    private let optionTitle = UILabel().then {
        $0.textColor = .hBlack
        $0.font = .haraB3R14
        $0.text = "선택지 글자수 제한은 공백 포함 20"
    }
    
    private var alreadySelected = false
    
    override var isSelected: Bool {
        didSet {
            if isSelected {
                /// 셀을 클릭할 때 cell 의 isSelect가 바로 true로 되기 때문에 alreadySlected를 통해 이미 선택된 상태면 isSelect를 false로 바꿈
                if alreadySelected {
                    alreadySelected = false
                    isSelected = false
                }else {
                    optionTitle.textColor = .hWhite
                    alreadySelected = true
                    contentView.backgroundColor = .hBlue1
                }
            } else {
                optionTitle.textColor = .hGray2
                contentView.backgroundColor = .hWhite
                contentView.layer.borderColor = UIColor.hBlue3.cgColor
                contentView.layer.borderWidth = 1
            }
        }
    }
    
    private var percent = 30
    
    private let percentLabel = UILabel().then {
        $0.textColor = .hGray2
        $0.font = .haraH2M16
        $0.text = "30%"
    }
    
    // MARK: - View Life Cycle
    override init(frame: CGRect) {
        super.init(frame: .zero)
        setUI()
        setLayout()
        //        setPressAction()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - UI
    private func setUI() {
        contentView.makeRounded(cornerRadius: 30)
        contentView.backgroundColor = .hWhite
        contentView.layer.borderColor = UIColor.hBlue3.cgColor
        contentView.layer.borderWidth = 1
        optionTitle.textColor = .hBlack
    }
    
    // MARK: - Layout
    private func setLayout() {
        contentView.addSubviews([optionTitle, percentLabel])

        optionTitle.snp.makeConstraints {
            $0.leading.equalToSuperview().offset(14)
            $0.top.equalToSuperview().offset(13)
        }
        
        percentLabel.snp.makeConstraints {
            $0.top.equalToSuperview().offset(14)
            $0.trailing.equalToSuperview().offset(14)
        }
    }
    
}
