//
//  WorriedAloneVC.swift
//  HARA
//
//  Created by 누리링 on 2023/01/06.
//

import UIKit
import SnapKit
import Then
import Moya


class WorriedAloneVC: UIViewController {
            
    private let worriedAllButton = UIButton().then {
        $0.setImage(UIImage(named: "storage_ing_all"), for: .normal)
    }
    
    private let editButton = UIButton().then {
        $0.setTitle("편집", for: .normal)
        $0.setTitleColor(.hBlack, for: .normal)
        $0.titleLabel?.font = .haraB2M14
    }

    
    
    private lazy var aloneCollectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout()).then {
        //UICollectionViewFlowLayout의 인스턴스를 생성
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        $0.backgroundColor = .clear
        $0.isScrollEnabled = true
        $0.showsVerticalScrollIndicator = false
        $0.delegate = self
        $0.dataSource = self

    }
    
    
    //section별, item별로 부여할 여백 상수로 저장
    let sectionSpacing: CGFloat = 20
    let itemSpacing: CGFloat = 8
    
    // 수직 스크롤이라는 가정 하에, rowCount는 몇개의 행을 사용할지를 저장한 변수
    let width: CGFloat = UIScreen.main.bounds.width - (itemSpacing * (row)) - (sectionSpacing * 1)
    let itemWidth: CGFloat = width / row

    
    var worriedList: [WorriedAloneModel] = [
        WorriedAloneModel(worring: "storage_ing", categoryTitle: "일상", mainText: "난 이제 지쳤어요 땡벌", date: "2022.12.25")
    ]
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setLayout()
        register()
    }

}


extension WorriedAloneVC {
    private func setLayout() {
        view.addSubview(aloneCollectionView)
        [worriedAllButton, editButton].forEach {
            view.addSubview($0)
        }
        worriedAllButton.snp.makeConstraints{
            $0.top.equalTo(10.adjustedH)
            $0.leading.equalTo(2.adjustedW).inset(7)
        }
        editButton.snp.makeConstraints{
            $0.top.equalTo(10.adjustedH)
            $0.trailing.equalTo(2.adjustedW).inset(12)
        }
    }
    
    private func register() {
        aloneCollectionView.register(
            WorriedAloneCVC.self,
            forCellWithReuseIdentifier: WorriedAloneCVC.identifier
        )
    }
    
//    private func calculateCellHeight() -> CGFloat {
//        let count = CGFloat(musicList.count)
//        let heightCount = count / 2 + count.truncatingRemainder(dividingBy: 2)
//        return heightCount * kCellHeight + (heightCount - 1) * kMusicLineSpacing + kMusicInset.top + kMusicInset.bottom
//    }
    
}


// MARK: - UICollectionViewDelegateFlowLayout

extension WorriedAloneVC: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let screenWidth = UIScreen.main.bounds.width
      // let doubleCellWidth = screenWidth - kMusicInset.left - kMusicInset.right - kMusicInterItemSpacing
        return CGSize(width: doubleCellWidth / 2, height: 198)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return itemSpacing
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return itemSpacing
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return itemSpacing
    }
}

// MARK: -UICollectionViewDataSource


//색션별 개수 반환
extension WorriedAloneVC: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 5
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: WorriedAloneCVC.identifier, for: indexPath)
                as? WorriedAloneCVC else { return UICollectionViewCell() }
        //worriedAloneCell.dataBind(model: musicList[indexPath.item])
        return cell
    }
    
//    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
//        print("\(indexPath.section), \(indexPath.row)")
//    }
    
}
