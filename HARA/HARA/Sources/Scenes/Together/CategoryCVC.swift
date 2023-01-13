//
//  CategoryCVC.swift
//  HARA
//
//  Created by 김담인 on 2023/01/04.
//

import UIKit
import SnapKit
import Then

class CategoryCVC: UICollectionViewCell {
    
    // MARK: - Properties
    let categoryLabel = UILabel().then {
        $0.textAlignment = .center
        $0.font = .haraH2M16
        $0.textColor = .hBlue2
    }
    
    override var isSelected: Bool {
        didSet {
            if isSelected {
                contentView.backgroundColor = .hBlue1
                categoryLabel.textColor = .hWhite
                contentView.layer.borderWidth = 0
            } else {
                contentView.backgroundColor = .hWhite
                contentView.layer.borderColor = UIColor.hBlue2.cgColor
                contentView.layer.borderWidth = 1
                categoryLabel.textColor = .hBlue2
            }
        }
    }
    
    // MARK: - Initialization
    override init(frame: CGRect) {
        super.init(frame: frame)
        setLayout()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    // MARK: - Function
    func setData(data: String) {
        categoryLabel.text = data
    }
    
    // MARK: - Layout
    private func setLayout() {
        contentView.addSubview(categoryLabel)
        contentView.backgroundColor = .hWhite
        contentView.makeRounded(cornerRadius: 8)
        
        categoryLabel.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
}
