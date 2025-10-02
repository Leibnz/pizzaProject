//
//  BasketStepper.swift
//  UIKitHomework
//
//  Created by Andrew on 24.08.2025.
//

import UIKit


final class BasketStepper: UIControl {
    var currentValue = 1 {
        didSet {
            currentValue = currentValue > 0 ? currentValue : 0
            currentStepValueLabel.text = "\(currentValue)"
        }
    }
    
    private lazy var decreaseButton: UIButton = {
        let button = UIButton()
         button.setTitleColor(.black, for: .normal)
         button.setTitle("-", for: .normal)
         button.addTarget(self, action: #selector(buttonAction), for: .touchUpInside)
         return button
     }()
     
     private lazy var increaseButton: UIButton = {
         let button = UIButton()
         button.setTitle("+", for: .normal)
         button.addTarget(self, action: #selector(buttonAction), for: .touchUpInside)
         button.setTitleColor(.black, for: .normal)
         return button
     }()

     private lazy var currentStepValueLabel: UILabel = {
         var label = UILabel()
         label.textColor = .black
         label.text = "\(currentValue)"
         label.font = UIFont.monospacedDigitSystemFont(ofSize: 15, weight: UIFont.Weight.regular)
         return label
     }()
    
    // MARK: - Init
        override init(frame: CGRect) {
            super.init(frame: frame)
            setupViews()
            setupConstraints()
        }
        
        required init?(coder: NSCoder) {
            super.init(coder: coder)
            setupViews()
            setupConstraints()
        }
        
        private func setupViews() {
            self.addSubview(decreaseButton)
            self.addSubview(currentStepValueLabel)
            self.addSubview(increaseButton)
        }
        
        private func setupConstraints() {
            decreaseButton.snp.makeConstraints { make in
                make.left.top.bottom.equalToSuperview()
                make.width.equalTo(30)
            }
            
            currentStepValueLabel.snp.makeConstraints { make in
                make.centerY.equalToSuperview()
                make.left.equalTo(decreaseButton.snp.right).offset(4)
            }
            
            increaseButton.snp.makeConstraints { make in
                make.left.equalTo(currentStepValueLabel.snp.right).offset(4)
                make.right.top.bottom.equalToSuperview()
                make.width.equalTo(30)
            }
        }
    
    //MARK: - Actions
       @objc private func buttonAction(_ sender: UIButton) {
           switch sender {
           case decreaseButton:
               currentValue -= 1
           case increaseButton:
               currentValue += 1
           default:
               break
           }
           sendActions(for: .valueChanged)
       }
}
