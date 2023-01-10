//
//  VotedCVC.swift
//  HARA
//
//  Created by 김담인 on 2023/01/08.
//

import UIKit
import SnapKit
import Then

final class VotedCVC: UICollectionViewCell {
    // MARK: - Properties
    private let checkView = UIImageView().then {
        $0.image = UIImage(named: "together_check_icon")
    }
    
    private let optionLabel = UILabel().then {
        $0.textColor = .hBlack
        $0.font = .haraB3R14
        $0.text = "선택지 글자수 제한은 공백 포함 20"
    }
    
    private let percentageView = UIView().then {
        $0.makeRounded(cornerRadius: 8)
    }
    
    private let percentageValue = UILabel().then {
        $0.font = .haraB2M14
        $0.text = "00%"
    }
    
    private var percentageWidth: CGFloat = 30
    
    // MARK: - View Life Cycle
    override init(frame: CGRect) {
        super.init(frame: .zero)
        setUI()
        setLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - UI
    private func setUI() {
        contentView.makeRounded(cornerRadius: 8)
        contentView.backgroundColor = .hWhite
        contentView.layer.borderColor = UIColor.hGray4.cgColor
        contentView.layer.borderWidth = 1
        optionLabel.textColor = .hBlack
    }
    
    // MARK: - Function
    func setPercentage(percentage: CGFloat, isOptionVoted: Bool) {
        self.percentageWidth = self.contentView.frame.width * (percentage/100)
        self.percentageValue.text = "\(percentage)%"
        
        if isOptionVoted {
            optionLabel.textColor = .hBlue1
            contentView.layer.borderColor = UIColor.hBlue2.cgColor
            contentView.layer.borderWidth = 1
            
            percentageView.backgroundColor = .hBlue3
            percentageValue.textColor = .hBlue1
        } else {
            optionLabel.textColor = .hBlack
            contentView.layer.borderColor = UIColor.hGray4.cgColor
            contentView.layer.borderWidth = 1
            
            percentageView.backgroundColor = .hGray2
            percentageValue.textColor = .hGray2
        }
        self.percentageView.snp.updateConstraints {
            $0.width.equalTo(self.percentageWidth)
        }

    }
    
    // MARK: - Layout
    private func setLayout() {
        contentView.addSubviews([percentageView, checkView, percentageValue, optionLabel])
        
        checkView.snp.makeConstraints {
            $0.top.equalToSuperview().offset(13)
            $0.leading.equalToSuperview().offset(12)
        }
        
        optionLabel.snp.makeConstraints {
            $0.top.equalToSuperview().offset(9)
            $0.leading.equalTo(checkView.snp.trailing).offset(6)
        }
        
        percentageValue.snp.makeConstraints {
            $0.top.equalToSuperview().offset(9)
            $0.trailing.equalToSuperview().inset(14)
        }
        
        percentageView.snp.makeConstraints {
            $0.leading.equalToSuperview()
            $0.width.equalTo(percentageWidth)
            $0.height.equalToSuperview()
        }
        
    }
}
