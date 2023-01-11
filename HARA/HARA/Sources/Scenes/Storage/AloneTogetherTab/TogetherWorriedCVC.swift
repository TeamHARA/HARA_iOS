//
//  TogetherWorriedCVC.swift
//  HARA
//
//  Created by 누리링 on 2023/01/07.
//


import UIKit
import SnapKit
import Moya
import Then

class TogetherWorriedCVC: UICollectionViewCell {
    
    // MARK: - Properties
    private let worringIcon = UIImageView()
    private let titleLabel = UILabel().then {
        $0.textColor = .hBlue1
        $0.font = .haraB2M14
    }
    
    private let mainLabel = UILabel().then {
        $0.textColor = .hBlack
        $0.font = .haraB3R14
    }
    
    private let date = UILabel().then {
        $0.textColor = .hGray2
        $0.font = .haraSub2M12
    }
    
    // MARK: - Life Cycles
    override init(frame: CGRect) {
        super.init(frame: frame)
        setLayout()
        setCellUI()
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Functions
    private func setCellUI() {
        self.contentView.layer.borderColor = UIColor.hBlue2.cgColor
        self.contentView.layer.borderWidth = 1
        self.contentView.sizeToFit()
        self.contentView.layer.cornerRadius = 10
        self.contentView.backgroundColor = .hWhite
    }
}

extension TogetherWorriedCVC {
    
    // MARK: - Layout
    private func setLayout() {
        backgroundColor = .clear
        contentView.backgroundColor = .clear
        contentView.addSubviews([worringIcon, titleLabel, mainLabel, date])
        
        worringIcon.snp.makeConstraints{
            $0.top.equalToSuperview().offset(12.adjustedH)
            $0.leading.equalTo(12.adjustedW)
            $0.height.equalTo(22.adjustedH)
            $0.width.equalTo(54.adjustedW)
        }
        
        titleLabel.snp.makeConstraints{
            $0.top.equalToSuperview().offset(12.adjustedH)
            $0.leading.equalTo(worringIcon.snp.trailing).offset(6.adjustedW)
            $0.width.equalTo(25.adjustedW)
            $0.height.equalTo(22.adjustedH)
        }
        
        mainLabel.snp.makeConstraints{
            $0.top.equalTo(worringIcon.snp.bottom).offset(8.adjustedH)
            $0.leading.equalToSuperview().offset(12.adjustedW)
        }
        date.snp.makeConstraints{
            $0.bottom.equalToSuperview().inset(12.adjustedH)
            $0.trailing.equalToSuperview().inset(12.adjustedW)
        }
    }
    
    func dataBind(model: WorriedModel){
        worringIcon.image = UIImage(named: model.worring)
        titleLabel.text = model.categoryTitle
        mainLabel.text = model.mainText
        date.text = model.date
    }
}
