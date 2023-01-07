//
//  WorriedAloneCVC.swift
//  HARA
//
//  Created by 누리링 on 2023/01/06.
//

import UIKit
import SnapKit
import Moya
import Then

class WorriedAloneCVC: UICollectionViewCell {
    
//    let worring : String
//    let categoryTitle : String
//    let mainText : String
//    let date : String
    
    
    //컬렉션 뷰 셀 변수 지정
    static let identifier = "WorriedAloneCVC"
    
    private let titleLabel = UILabel().then {
        $0.textColor = .hBlack
        $0.font = .haraB2M14
    }
    
    private let mainLabel = UILabel().then {
        $0.textColor = .hBlack
        $0.font = .haraSub2M12
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        layout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension WorriedAloneCVC {
    private func layout() {
        backgroundColor = .clear
        contentView.backgroundColor = .clear
        [titleLabel, mainLabel].forEach{
            contentView.addSubview($0)
        }
        
        titleLabel.snp.makeConstraints{
            $0.top.equalTo(15.adjustedH)
            $0.leading.equalTo(2.adjustedW).inset(10)
            $0.trailing.equalTo(2.adjustedW).inset(10)
            
        }
        
        mainLabel.snp.makeConstraints{
            $0.top.equalTo(20.adjustedH)
            $0.leading.equalTo(2.adjustedH).inset(20)
        }
    }
    
    
    dataBind(model: WorriedAloneModel){
        
        //    let worring : String
        //    let categoryTitle : String
        //    let mainText : String
        //    let date : String
        


    }
}
