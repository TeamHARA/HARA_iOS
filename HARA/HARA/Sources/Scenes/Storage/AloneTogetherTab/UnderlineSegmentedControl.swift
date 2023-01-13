//
//  UnderlineSegmentedControl.swift
//  HARA
//
//  Created by 누리링 on 2023/01/04.
//

import Foundation
import Then
import UIKit

final class UnderlineSegmentedControl: UISegmentedControl {
    
    // MARK: - Properties
    private lazy var underlineView: UIView = {
        let width = self.bounds.size.width / CGFloat(self.numberOfSegments)
        let height = 15.0
        let xPosition = CGFloat(self.selectedSegmentIndex * Int(width))
        let yPosition = self.bounds.size.height - 3.0
      
        let view = UIView(frame: CGRect(x: xPosition, y: yPosition, width: width, height: height))
        view.backgroundColor = UIColor.hBlue1
        self.addSubview(view)
        return view
    }()
    
    // MARK: - Life Cycles
    /// segmentedControl의 각 frame의 속성을 rBAD함수를 통해 효과를 모두 제거
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.removeBackgroundAndDivider()
    }
    
    /// segmentedControl의 각 Item들의 속성을 rBAD함수를 통해 효과를 모두 제거
    override init(items: [Any]?) {
        super.init(items: items)
        self.removeBackgroundAndDivider()}
    
    required init?(coder: NSCoder) {
          fatalError()
    }

    // MARK: - Functions
    private func removeBackgroundAndDivider() {
        let image = UIImage()
        self.setBackgroundImage(image, for: .normal, barMetrics: .default)
        self.setBackgroundImage(image, for: .selected, barMetrics: .default)
        self.setBackgroundImage(image, for: .highlighted, barMetrics: .default)

        /// segmentedControl 탭 사이의 바들을 안보여주게끔 해주는 setDividerImage
        self.setDividerImage(image, forLeftSegmentState: .selected, rightSegmentState: .normal, barMetrics: .default)
    }
        
    override func layoutSubviews() {
        super.layoutSubviews()
        let underlineFinalXPosition = (self.bounds.width / CGFloat(self.numberOfSegments)) * CGFloat(self.selectedSegmentIndex)
        UIView.animate(withDuration: 0.1, animations:{
        self.underlineView.frame.origin.x = underlineFinalXPosition})
    }
    
}
