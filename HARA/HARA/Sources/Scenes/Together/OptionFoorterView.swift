//
//  optionFoorterView.swift
//  HARA
//
//  Created by 김담인 on 2023/01/07.
//

import UIKit
import SnapKit
import Then

final class OptionFooterView: UICollectionReusableView {
    
    // MARK: - Properties
    private var voteButton = UIButton().then {
        $0.setTitle("투표하기", for: .normal)
        $0.contentHorizontalAlignment = .center
        $0.setTitleColor(.hOrange1, for: .normal)
        $0.setBackgroundColor(.hWhite, for: .normal)
        $0.setBackgroundColor(.hOrange3, for: .selected)
        $0.makeRounded(cornerRadius: 8)
        $0.layer.borderColor = UIColor.hOrange2.cgColor
        $0.layer.borderWidth = 1
    }
    
//    self.voteButton {
//        didSet {
//            self.voteButton.isSelected = true
//        }
//    }
    
    // MARK: - View Life Cycle
    override init(frame: CGRect) {
        super.init(frame: frame)
        setLayout()
        setPressAction()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Function
    private func setPressAction() {
        voteButton.press {
            self.voteButton.isSelected.toggle()
            if self.voteButton.isSelected == true {
                self.voteButton.backgroundColor = .hOrange3
                self.voteButton.setTitleColor(.hOrange2, for: .selected)
                self.voteButton.layer.borderWidth = 0
                print("선택")
            }else {
                self.voteButton.backgroundColor = .hWhite
                self.voteButton.layer.borderColor = UIColor.hOrange3.cgColor
                self.voteButton.layer.borderWidth = 1
                self.voteButton.setTitleColor(.hOrange2, for: .normal)
                print("비선택")
            }
        }
    }
    
    func selectVoteButton() {
        self.voteButton.isSelected.toggle()
        print("버튼 클릭")
    }
    
    // MARK: - Layout
    private func setLayout() {
        self.addSubview(voteButton)
        voteButton.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
}


