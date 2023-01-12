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
        $0.font = .haraM2M18
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
                    contentView.layer.borderWidth = 0
                    optionTitle.textColor = .hWhite
                }
            } else {
                contentView.backgroundColor = .hWhite
                contentView.layer.borderWidth = 1
                optionTitle.textColor = .hGray2
            }
        }
    }
    
//    private var percent = 30 {
//        didSet {
//            self.percentLabel.setLabel(text: "\(percent)%", font: .haraH2M16)
//        }
//    }
    
//    private let percentLabel = UILabel().then {
//        $0.textColor = .hGray2
//    }
    
    // MARK: - View Life Cycle
    override init(frame: CGRect) {
        super.init(frame: .zero)
        setUI()
        setLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Function
    func sendOptionTitle() -> String {
        return self.optionTitle.text ?? ""
    }
    
//    func getPercentage(percent: Int) {
//        self.percent = percent
//    }
    
    // MARK: - UI
    private func setUI() {
        contentView.makeRounded(cornerRadius: 8)
        contentView.backgroundColor = .hWhite
        contentView.layer.borderColor = UIColor.hBlue3.cgColor
        contentView.layer.borderWidth = 1
        optionTitle.textColor = .hGray2
    }
    
    // MARK: - Layout
    private func setLayout() {
        contentView.addSubviews([optionTitle])

        optionTitle.snp.makeConstraints {
            $0.leading.equalToSuperview().offset(14)
            $0.centerY.equalToSuperview()
        }
        
//        percentLabel.snp.makeConstraints {
//            $0.trailing.equalToSuperview().inset(14)
//            $0.centerY.equalToSuperview()
//        }
    }
    
}
