//
//  CommentHeaderView.swift
//  HARA
//
//  Created by 김담인 on 2023/01/11.
//

import UIKit
import SnapKit
import Then

class CommentHeaderView: UICollectionReusableView {
    
    // MARK: - Properties
    private let borderLine = UIView().then {
        $0.backgroundColor = .hGray5
    }
    
    private var commentLabel = UILabel().then {
        let comments = 10
        $0.font = .haraSub3R12
        $0.text = "댓글 \(comments)"
        $0.textColor = .hBlack
    }
    
    // MARK: - View Life Cycle
    override init(frame: CGRect) {
        super.init(frame: .zero)
        setLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setCommentNums(num: Int) {
        self.commentLabel.text = "댓글 \(num)%"
    }
    
    private func setLayout() {
        self.addSubviews([borderLine, commentLabel])
        
        borderLine.snp.makeConstraints {
            $0.top.equalToSuperview().offset(16)
            $0.leading.trailing.equalToSuperview()
            $0.height.equalTo(1)
        }
        
        commentLabel.snp.makeConstraints {
            $0.top.equalTo(borderLine.snp.bottom).offset(10)
            $0.leading.equalTo(borderLine).offset(16)
            $0.height.equalTo(14)
        }
    }
}
