//
//  DetailWorryCardVC.swift
//  HARA
//
//  Created by 김담인 on 2023/01/08.
//

import UIKit
import SnapKit
import Then

enum detailSection {
    case worry
    case comment
}

final class DetailWorryCardVC: UIViewController {
    
    // MARK: - Properties
    private let closeDetailButton = UIButton().then {
        $0.setBackgroundImage(UIImage(named: "detailWorry_close_icon"), for: .normal)
    }
    
    private let worryStateTitle = UILabel().then {
        $0.font = .haraH1Sb16
        $0.textColor = .hGray1
        $0.text = "고민중"
    }
    
    private lazy var voteOptionCV: UICollectionView = {
        let view = UICollectionView(frame: .zero, collectionViewLayout: self.getLayout())
        view.showsHorizontalScrollIndicator = false
        view.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 100, right: 0)
        
        return view
    }()
    
    private var optionNums = 4
    private var commentNums = 10
    
    func getLayout() -> UICollectionViewCompositionalLayout {
        UICollectionViewCompositionalLayout { (section, env) -> NSCollectionLayoutSection? in
            switch section {
            case 0:
//                let fracHeight = CGFloat(Double(1) / Double(self.optionNums))
                let estimatedHeight = CGFloat(300)
                let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .estimated(estimatedHeight) )
                let item = NSCollectionLayoutItem(layoutSize: itemSize)
                //        item.edgeSpacing = NSCollectionLayoutEdgeSpacing(leading: nil, top: nil, trailing: nil, bottom: .fixed(10))
                //        item.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 0, bottom: 12, trailing: 0)
                
                //        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .estimated(estimatedHeight) )
                let group = NSCollectionLayoutGroup.vertical(layoutSize: itemSize, repeatingSubitem: item, count: 1)
                //            group.contentInsets = NSDirectionalEdgeInsets(top: 10, leading: 0, bottom: 10, trailing: 0)
                //        group.interItemSpacing = .fixed(10)
                let section = NSCollectionLayoutSection(group: group)
                section.interGroupSpacing = 10
                section.contentInsets = NSDirectionalEdgeInsets(top: 16, leading: 16, bottom: 10, trailing: 16)
                
                let headerSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .estimated(200))
                let header = NSCollectionLayoutBoundarySupplementaryItem(layoutSize: headerSize,elementKind:UICollectionView.elementKindSectionHeader,alignment: .top)
                
                let footerSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .absolute(44))
                let footer = NSCollectionLayoutBoundarySupplementaryItem(layoutSize: footerSize,elementKind:UICollectionView.elementKindSectionFooter,alignment: .bottom)
                
                section.boundarySupplementaryItems = [header, footer]
                
                return section
            default:
//                let fracHeight = CGFloat(Double(1) / Double(self.commentNums))
                let estimatedHeight = CGFloat(60)
                let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .estimated(estimatedHeight) )
                let item = NSCollectionLayoutItem(layoutSize: itemSize)
                //        item.edgeSpacing = NSCollectionLayoutEdgeSpacing(leading: nil, top: nil, trailing: nil, bottom: .fixed(10))
                //        item.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 0, bottom: 12, trailing: 0)
                
                //        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .estimated(estimatedHeight) )
                let group = NSCollectionLayoutGroup.vertical(layoutSize: itemSize, repeatingSubitem: item, count: 1)
                            group.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 16, bottom: 0, trailing: 16)
                //        group.interItemSpacing = .fixed(10)
                let section = NSCollectionLayoutSection(group: group)
                section.interGroupSpacing = 22
                section.contentInsets = NSDirectionalEdgeInsets(top: 16, leading: 0, bottom: 10, trailing: 0)
                
                let headerSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .estimated(41))
                let header = NSCollectionLayoutBoundarySupplementaryItem(layoutSize: headerSize,elementKind:UICollectionView.elementKindSectionHeader,alignment: .top)
            
                section.boundarySupplementaryItems = [header]
                
                return section
            }
            
        }
    }
    
    private let bottomCommentView = UIView().then {
        $0.backgroundColor = .hWhite
    }
    
    private let unknownCheckButton = UIButton().then {
        $0.setBackgroundImage(UIImage(named: "detailWorry_unChecked_icon"), for: .normal)
        $0.setBackgroundImage(UIImage(named: "detailWorry_checked_icon"), for: .selected)
    }
    
    private let unknownLabel = UILabel().then {
        $0.text = "익명"
        $0.textColor = .hBlack
        $0.font = .haraSub3R12
    }
    
    private lazy var commentSendButton = UIButton().then {
        $0.setBackgroundImage(UIImage(named: "detailWorry_commentSend_icon"), for: .normal)
    }
    
    private let commentTextField = UITextField().then {
        $0.borderStyle = .none
        $0.layer.borderColor = UIColor.hGray4.cgColor
        $0.layer.borderWidth = 1
        $0.layer.cornerRadius = 8
        $0.backgroundColor = .clear
        $0.placeholder = "댓글 내용을 입력해주세요"
        $0.font = .haraB2M14
        $0.textColor = .hGray2
        $0.addLeftPadding(8)
    }
    
    private var isSelected = false
    
    // MARK: - View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .hWhite
        setLayout()
        setPressAction()
        setVoteOptionCV()
    }
    
    override func viewWillLayoutSubviews() {
        self.voteOptionCV.collectionViewLayout.invalidateLayout()
    }
    
    // MARK: - Function
    private func setVoteOptionCV() {
        voteOptionCV.dataSource = self
        voteOptionCV.delegate = self
        
        voteOptionCV.register(cell: DetailWorryCVC.self, forCellWithReuseIdentifier: DetailWorryCVC.className)
        voteOptionCV.register(cell: VotedDetailWorryCVC.self, forCellWithReuseIdentifier: VotedDetailWorryCVC.className)
        voteOptionCV.register(WorryDetailHeaderView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: WorryDetailHeaderView.className)
        voteOptionCV.register(WorryDetailFooterView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionFooter, withReuseIdentifier: WorryDetailFooterView.className)
        voteOptionCV.register(cell: DetailWorryCommentCVC.self, forCellWithReuseIdentifier: DetailWorryCommentCVC.className)
        voteOptionCV.register(CommentHeaderView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: CommentHeaderView.className)
        

    }
    
    private func setPressAction() {
        self.closeDetailButton.press {
            self.dismiss(animated: true)
        }
        
        self.unknownCheckButton.press {
            self.unknownCheckButton.isSelected.toggle()
        }
    }
}

// MARK: - UICollectionViewDataSource
extension DetailWorryCardVC: UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 2
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        if section == 0 {
            return optionNums
        }else {
            return commentNums
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if indexPath.section == 0 {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: DetailWorryCVC.className, for: indexPath) as! DetailWorryCVC
            if isSelected{
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: VotedDetailWorryCVC.className, for: indexPath) as! VotedDetailWorryCVC
                cell.setPercentage(percentage: 50, isOptionVoted: true)
                return cell
            }
            return cell
        }else {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: DetailWorryCommentCVC.className, for: indexPath) as! DetailWorryCommentCVC
            return cell
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        if indexPath.section == 0 {
            switch kind {
            case UICollectionView.elementKindSectionHeader:
                let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: WorryDetailHeaderView.className, for: indexPath) as! WorryDetailHeaderView
                return header
                
            case UICollectionView.elementKindSectionFooter:
                let footer = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: WorryDetailFooterView.className, for: indexPath) as! WorryDetailFooterView
                footer.buttonDelegate = self
                return footer
                
            default:
                return UICollectionReusableView()
            }
            
        }else {
            switch kind {
            case UICollectionView.elementKindSectionHeader:
                let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: CommentHeaderView.className, for: indexPath) as! CommentHeaderView
                return header
            default:
                return UICollectionReusableView()
            }
        }
    }
    
    //    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
    //        let width = collectionView.frame.width
    //        return CGSize(width: width, height: 200.adjustedH)
    //    }
    
}

// MARK: - UICollectionViewDelegate
extension DetailWorryCardVC: UICollectionViewDelegate {
    
}

// MARK: - Layout
extension DetailWorryCardVC {
    private func setLayout() {
        view.addSubviews([closeDetailButton, worryStateTitle, voteOptionCV, bottomCommentView, commentSendButton])
        
        bottomCommentView.addSubviews([unknownCheckButton, unknownLabel, commentTextField, commentSendButton])
        
        closeDetailButton.snp.makeConstraints {
            $0.top.equalTo(self.view.safeAreaLayoutGuide).offset(13)
            $0.leading.equalToSuperview().offset(16)
            $0.height.width.equalTo(24)
        }
        
        worryStateTitle.snp.makeConstraints {
            $0.top.equalTo(self.view.safeAreaLayoutGuide).offset(15)
            $0.centerX.equalToSuperview()
            $0.height.equalTo(19)
        }
        
        voteOptionCV.snp.makeConstraints {
            $0.top.equalTo(worryStateTitle.snp.bottom).offset(16)
            $0.leading.equalToSuperview()
            $0.trailing.equalToSuperview()
            $0.bottom.equalToSuperview()
        }
        
        bottomCommentView.snp.makeConstraints {
            $0.horizontalEdges.equalToSuperview()
            $0.bottom.equalToSuperview()
            $0.height.equalTo(90)
        }
        
        unknownCheckButton.snp.makeConstraints {
            $0.top.equalToSuperview().offset(18)
            $0.leading.equalToSuperview().offset(16)
            $0.width.height.equalTo(14)
        }
        
        unknownLabel.snp.makeConstraints {
            $0.top.equalToSuperview().offset(18)
            $0.leading.equalTo(unknownCheckButton.snp.trailing).offset(4)
            $0.height.equalTo(14)
            $0.width.equalTo(21)
        }
        
        commentTextField.snp.makeConstraints {
            $0.leading.equalTo(unknownLabel.snp.trailing).offset(8)
            $0.trailing.equalToSuperview().inset(16)
            $0.centerY.equalTo(unknownCheckButton)
            $0.height.equalTo(34)
        }
        
        commentSendButton.snp.makeConstraints {
            $0.trailing.equalTo(commentTextField.snp.trailing).inset(8)
            $0.centerY.equalTo(commentTextField)
        }
        
    }
}

extension DetailWorryCardVC: SendButtonAction {
    func sendData(isSelected: Bool) {
        self.isSelected = isSelected
        self.voteOptionCV.reloadData()
    }
}
