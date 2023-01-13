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
    
    private let categoryLabel = UILabel().then {
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
    
    private let categoryList: Array<String> = ["전체", "일상", "연애", "패션/뷰티", "커리어", "운동", "여행", "기타"]
    
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
    
    func dataBind(model: StorageResponse){
        if model.finalOption != nil {
            worringIcon.image = UIImage(named: "storage_complete")
        }else {
            worringIcon.image = UIImage(named: "storage_ing")
        }
        categoryLabel.text = categoryList[model.categoryId]
        mainLabel.text = model.title
        date.text = model.createdAt
    }
}

// MARK: - Layout
extension TogetherWorriedCVC {
    private func setLayout() {
        backgroundColor = .clear
        contentView.backgroundColor = .clear
        contentView.addSubviews([worringIcon, categoryLabel, mainLabel, date])
        
        worringIcon.snp.makeConstraints{
            $0.top.equalToSuperview().offset(12.adjustedH)
            $0.leading.equalTo(12.adjustedW)
            $0.height.equalTo(22.adjustedH)
            $0.width.equalTo(54.adjustedW)
        }
        
        categoryLabel.snp.makeConstraints{
            $0.top.equalToSuperview().offset(12.adjustedH)
            $0.leading.equalTo(worringIcon.snp.trailing).offset(6.adjustedW)
            $0.width.equalTo(100.adjustedW)
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
    
}
