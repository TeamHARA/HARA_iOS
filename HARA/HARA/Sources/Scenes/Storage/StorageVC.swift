//
//  StorageVC.swift
//  HARA
//
//  Created by 김담인 on 2023/01/02.
//

import UIKit
import SnapKit
import Moya
import Then


class StorageVC: UIViewController {
    
    
    private let topContainerView = UIView()
        
    // 1초 고민해결 버튼 생성 - strorage_oneclick_btn
    // 혼자고민, 함께고민 - UIsegmentedControl + pageViewController
    
    private let haraIcon = UIButton().then {
        $0.setImage(UIImage(named: "storage_logo"), for: .normal)
        
    }
    private let bellButton = UIButton().then {
        $0.setImage(UIImage(named: "storage_Bell"), for: .normal)
    }
    private let setting = UIButton().then {
        $0.setImage(UIImage(named: "storage_setting_icon"), for: .normal)
    }
    private let oneclickButton = UIButton().then {
        $0.setImage(UIImage(named: "strorage_oneclick_btn"), for: .normal)
        $0.tintColor = .gray
    }
    
    private let segmentedControl = UnderlineSegmentedControl(items: ["함께 고민", "같이 고민"])
    
    private let vc1 = UIViewController().then{
        $0.view.backgroundColor = .hBlue1
    }
    
    private let vc2 = UIViewController().then{
        $0.view.backgroundColor = .hBlue1
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()
        setLayout()
        self.view.backgroundColor = .white
    }
}
    
    
    
    extension StorageVC {
        // MARK: - setLayout()
        private func setLayout(){
         
            
            [haraIcon, bellButton, setting, oneclickButton].forEach {
                view.addSubview($0)
            }
            
            haraIcon.snp.makeConstraints{
                $0.top.equalTo(55.4.adjustedH)
                $0.leading.equalTo(45.adjustedW).offset(17)
                $0.width.equalTo(45.8)
                $0.height.equalTo(52)
            }
            bellButton.snp.makeConstraints{
                $0.top.equalTo(70.adjustedH)
                $0.trailing.equalTo(44.adjustedW).inset(47)
            }
            setting.snp.makeConstraints{
                $0.top.equalTo(70.adjustedH)
                $0.trailing.equalTo(44.adjustedW).inset(18.5)
            }
            oneclickButton.snp.makeConstraints{
                $0.top.equalTo(haraIcon.snp.bottom).offset(10)
                $0.trailing.equalTo(2.adjustedW).inset(17)
            }

        }
    }
