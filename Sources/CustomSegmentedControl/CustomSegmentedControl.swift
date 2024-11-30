//
//  CustomSegmentedControl.swift
//
//  Created by Nkhorbaladze on 30.11.24.
//
import UIKit

public class CustomSegmentedControl: UIControl {
    private var labels = [UILabel]()
    private var thumbView = UIView()
    
    // MARK: - Public Properties
    public var items: [String] = [] {
        didSet {
            setupLabels()
        }
    }
    
    public var selectedIndex: Int = 0 {
        didSet {
            displayNewSelectedIndex()
        }
    }
    
    public var segmentSpacing: CGFloat = 5 {
        didSet {
            setNeedsLayout()
        }
    }
    
    public var thumbColor: UIColor = .blue {
        didSet {
            thumbView.backgroundColor = thumbColor
        }
    }
    
    public var inactiveColor: UIColor = .lightGray {
        didSet {
            setupLabels()
        }
    }
    
    public var selectedTextColor: UIColor = .white {
        didSet {
            setupLabels()
        }
    }
    
    public var inactiveTextColor: UIColor = .darkGray {
        didSet {
            setupLabels()
        }
    }
    
    // MARK: - Initializers
    public override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    public required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupView()
    }
    
    // MARK: - Setup Methods
    private func setupView() {
        backgroundColor = .clear
        thumbView.backgroundColor = thumbColor
        thumbView.layer.cornerRadius = 10
        insertSubview(thumbView, at: 0)
        setupLabels()
    }
    
    private func setupLabels() {
        for label in labels {
            label.removeFromSuperview()
        }
        labels.removeAll()
        
        for (index, item) in items.enumerated() {
            let label = UILabel()
            label.text = item
            label.textAlignment = .center
            label.textColor = index == selectedIndex ? selectedTextColor : inactiveTextColor
            label.backgroundColor = index == selectedIndex ? .clear : inactiveColor
            label.layer.cornerRadius = 10
            label.clipsToBounds = true
            addSubview(label)
            labels.append(label)
        }
        setNeedsLayout()
    }
    
    // MARK: - Layout
    public override func layoutSubviews() {
        super.layoutSubviews()
        
        let segmentWidth = (bounds.width - segmentSpacing * CGFloat(items.count - 1)) / CGFloat(items.count)
        let segmentHeight = bounds.height
        let cornerRadius = segmentHeight / 2
        
        for (index, label) in labels.enumerated() {
            let xPosition = CGFloat(index) * (segmentWidth + segmentSpacing)
            label.frame = CGRect(x: xPosition, y: 0, width: segmentWidth, height: segmentHeight)
            label.layer.cornerRadius = cornerRadius
        }
        
        if selectedIndex < labels.count {
            let selectedLabel = labels[selectedIndex]
            thumbView.frame = selectedLabel.frame
            thumbView.layer.cornerRadius = cornerRadius
        }
    }
    
    // MARK: - Touch Handling
    public override func beginTracking(_ touch: UITouch, with event: UIEvent?) -> Bool {
        let location = touch.location(in: self)
        for (index, label) in labels.enumerated() {
            if label.frame.contains(location) {
                selectedIndex = index
                sendActions(for: .valueChanged)
                break
            }
        }
        return false
    }
    
    private func displayNewSelectedIndex() {
        for (index, label) in labels.enumerated() {
            label.textColor = index == selectedIndex ? selectedTextColor : inactiveTextColor
            label.backgroundColor = index == selectedIndex ? .clear : inactiveColor
        }
        
        if selectedIndex < labels.count {
            let selectedLabel = labels[selectedIndex]
            thumbView.frame = selectedLabel.frame
        }
    }
}
