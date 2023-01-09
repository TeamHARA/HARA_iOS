//
//  AddOptionView.swift
//  HARA
//
//  Created by saint on 2023/01/09.
//

import UIKit
import SnapKit
import Then

class AddOptionView: UIView {
    
    // MARK: - Properties
    private let optionContainerView = UIView().then{
        $0.layer.borderColor = UIColor.hBlue3.cgColor
        $0.layer.borderWidth = 1
        $0.layer.cornerRadius = 8
        $0.backgroundColor = .hWhite
    }
    
    private let optionTextField = UITextField().then{
        $0.borderStyle = .none
        $0.placeholder = "선택지의 제목을 적어주세요."
        $0.font = .haraH2M16
        $0.textColor = .hGray3
    }
    
    private let imageInsertButton = UIButton().then {
        $0.setBackgroundImage(UIImage(named: "insertImageBtn"), for: .normal)
        $0.contentMode = .scaleAspectFit
    }
    
    private let deleteButton = UIButton().then {
        $0.setBackgroundImage(UIImage(named: "deleteOptionBtn"), for: .normal)
        $0.contentMode = .scaleAspectFit
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension AddOptionView{
    private func setLayout(){
        backgroundColor = .clear
        self.addSubView(optionContainerView)
        optionContainerView.addSubviews([optionTextField, deleteButton, imageInsertButton])
        
        optionContainerView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        deleteButton.snp.makeConstraints{
            $0.leading.equalToSuperview().offset(14.adjustedW)
            $0.centerY.equalToSuperview()
            $0.width.equalTo(18.adjustedW)
            $0.height.equalTo(18.adjustedH)
        }
        
        optionTextField.snp.makeConstraints{
            $0.leading.equalTo(deleteButton.snp.trailing).offset(10.adjustedW)
            $0.centerY.equalToSuperview()
            $0.width.equalTo(200.adjustedW)
            $0.height.equalTo(30)
        }
        
        imageInsertButton.snp.makeConstraints{
            $0.trailing.equalToSuperview().offset(-15.adjustedW)
            $0.centerY.equalToSuperview()
            $0.width.equalTo(18.adjustedW)
            $0.height.equalTo(18.adjustedH)
        }
    }
}
