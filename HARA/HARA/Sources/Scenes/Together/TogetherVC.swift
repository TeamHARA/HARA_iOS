//
//  TogetherVC.swift
//  HARA
//
//  Created by 김담인 on 2022/12/27.
//

import UIKit
import SnapKit
import Then

final class TogetherVC: UIViewController {
    
    // MARK: - Properties
    private let togetherNaviView = DefaultNavigationView()
    
    private let categoryCV = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout()).then {
        $0.backgroundColor = .clear
        $0.showsHorizontalScrollIndicator = false
        $0.contentInset = UIEdgeInsets.zero
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        $0.collectionViewLayout = layout
    }
    
    private let worryCardCV = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout()).then {
        $0.backgroundColor = .clear
        $0.showsVerticalScrollIndicator = false
        $0.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 50, right: 0)
    }
    
    private let categoryTitles = ["전체", "일상", "연애", "패션/뷰티", "커리어", "운동", "여행", "기타"]
    
    /// 고민의 개수
    private var worryNums = 10
    /// 선택지의 개수
    private var optionNums = 2
    
    
    // MARK: - View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.isHidden = true
        self.view.backgroundColor = .white
        setCategoryCV()
        registerCell()
        setLayout()
        categoryCV.selectItem(at: IndexPath(item: 0, section: 0), animated: false, scrollPosition: .right)
    }
    
    // MARK: - Function
    private func setCategoryCV() {
        categoryCV.dataSource = self
        categoryCV.delegate = self
        
        worryCardCV.dataSource = self
        worryCardCV.delegate = self
    }
    
    private func registerCell() {
        categoryCV.register(cell: CategoryCVC.self, forCellWithReuseIdentifier: CategoryCVC.className)
        
        worryCardCV.register(cell: WorryCardCVC.self, forCellWithReuseIdentifier: WorryCardCVC.className)
    }
}
// MARK: - UICollectionViewDelegateFlowLayout
extension TogetherVC: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if collectionView == categoryCV {
            let sizingCell = CategoryCVC()
            sizingCell.setData(data: categoryTitles[indexPath.row])
            sizingCell.categoryLabel.sizeToFit()
            
            let cellWidth = sizingCell.categoryLabel.frame.width + 24
            let cellHeight = CGFloat(31)
            return CGSize(width: cellWidth, height: cellHeight)
        }else {
            /// cell의 높이 값이 0이 나와서 상수에 adjustedH쓰는 것으로 대체
//            let sizingCell = WorryCardCVC()
//            let height = sizingCell.contentView.frame.height
            let width = collectionView.frame.width
            /// 선택지 두개 일때(default) 13mini 기준 worryCardCVC의 높이 383 + optionNums - 기본 선택지 개수(2개)를 빼고 그 값에 여백 포함 셀 높이 50 계산하고 adjustedH
            let height = CGFloat((339 + (optionNums-2)*50)).adjustedH
            print(height)
            return CGSize(width: width, height: height)
        }
    }
}

// MARK: - UICollectionViewDataSource
extension TogetherVC: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == categoryCV {
            return 8
        }else {
            return worryNums
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if collectionView == categoryCV {
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CategoryCVC.className, for: indexPath) as? CategoryCVC
            else { return UICollectionViewCell() }
            cell.setData(data: categoryTitles[indexPath.row])
            if indexPath.row != 0 {
                cell.contentView.layer.borderColor = UIColor.hBlue2.cgColor
                cell.contentView.layer.borderWidth = 1
            }
            return cell
        }else if collectionView == worryCardCV {
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: WorryCardCVC.className, for: indexPath) as? WorryCardCVC else { return UICollectionViewCell() }
            
            /// VC의 optionNums를 cell의 optionNums에 전달
            cell.setCellNums(optionNums: self.optionNums)
            return cell
        }else {
            return UICollectionViewCell()
        }
    }
    
}

// MARK: - Layout
extension TogetherVC {
    private func setLayout() {
        self.view.addSubviews([togetherNaviView, categoryCV, worryCardCV])
        
        togetherNaviView.snp.makeConstraints {
            $0.top.equalTo(self.view.safeAreaLayoutGuide)
            $0.leading.trailing.equalToSuperview().inset(16)
            $0.height.equalTo(24.adjustedH)
        }
        
        categoryCV.snp.makeConstraints {
            $0.top.equalTo(togetherNaviView.snp.bottom).offset(25)
            $0.leading.equalToSuperview().inset(16)
            $0.trailing.equalToSuperview().inset(16)
            $0.height.equalTo(31)
        }
        
        worryCardCV.snp.makeConstraints {
            $0.top.equalTo(categoryCV.snp.bottom).offset(12)
            $0.leading.equalToSuperview().offset(12)
            $0.trailing.bottom.equalToSuperview().inset(12)
        }
        
    }
    
}
