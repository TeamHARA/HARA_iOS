//
//  worriedTogetherVC.swift
//  HARA
//
//  Created by 누리링 on 2023/01/06.
//

import UIKit
import SnapKit
import Moya
import Then

class TogetherWorriedVC: UIViewController {
    
    private let worriedAllButton2 = UIButton().then {
        $0.setImage(UIImage(named: "storage_ing_all"), for: .normal)
    }
    private let editButton2 = UIButton().then {
        $0.setTitle("편집", for: .normal)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setLayout()
    }
}

extension TogetherWorriedVC {
    
    private func setLayout() {
        
        [worriedAllButton2, editButton2].forEach {
            view.addSubview($0)
        }
        worriedAllButton2.snp.makeConstraints{
            $0.top.equalTo(80.adjustedH)
            $0.leading.equalTo(2.adjustedW).inset(17)
        }
        editButton2.snp.makeConstraints{
            $0.top.equalTo(80.adjustedH)
            $0.trailing.equalTo(2.adjustedW).inset(17)
        }
    }
}
