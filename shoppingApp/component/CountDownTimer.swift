//
//  CountDownTimer.swift
//  shoppingApp
//
//  Created by 陳昱維 on 2023/11/17.
//

import UIKit
import SnapKit

//FIXME: 目前是使用UILabel元件搭配動畫效果去呈現，有另一種寫法是每個數字都是一個collectionView不斷輪播
class CountDownTimer: UIView {
    private var backgroundView: UIView!
    private var hourTensLabel: UILabel!
    private var hourOnesLabel: UILabel!
    private var colonLabel: UILabel!
    private var backgroundView1: UIView!
    private var minuteTensLabel: UILabel!
    private var minuteOnesLabel: UILabel!
    private var colonLabel1: UILabel!
    private var backgroundView2: UIView!
    private var secondTensLabel: UILabel!
    private var secondOnesLabel: UILabel!
    
    var countDownTimer: Timer?
    var totalTime = 3600 //以秒為單位
    let horizontalSpace = 3
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupElement()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupElement()
    }
    
    func setupElement() {
        hourTensLabel = createLabel()
        hourOnesLabel = createLabel()
        minuteTensLabel = createLabel()
        minuteOnesLabel = createLabel()
        secondTensLabel = createLabel()
        secondOnesLabel = createLabel()
        colonLabel = createColonLabel()
        colonLabel1 = createColonLabel()
        backgroundView = createBackgroundView()
        backgroundView1 = createBackgroundView()
        backgroundView2 = createBackgroundView()
        
        setupUI()
    }
    
    func setupUI() {
        addSubview(backgroundView)
        backgroundView.addSubview(hourTensLabel)
        backgroundView.addSubview(hourOnesLabel)
        addSubview(colonLabel)
        addSubview(backgroundView1)
        backgroundView1.addSubview(minuteTensLabel)
        backgroundView1.addSubview(minuteOnesLabel)
        addSubview(colonLabel1)
        addSubview(backgroundView2)
        backgroundView2.addSubview(secondTensLabel)
        backgroundView2.addSubview(secondOnesLabel)

        backgroundView.snp.makeConstraints { make in
            make.top.left.bottom.equalToSuperview()
            make.width.equalTo(25)
        }
        
        hourTensLabel.snp.makeConstraints { make in
            make.top.bottom.equalToSuperview()
            make.left.equalTo(2)
        }
        
        hourOnesLabel.snp.makeConstraints { make in
            make.top.bottom.equalTo(hourTensLabel)
            make.left.equalTo(hourTensLabel.snp.right)
        }
        
        colonLabel.snp.makeConstraints { make in
            make.top.bottom.equalTo(hourTensLabel)
            make.left.equalTo(backgroundView.snp.right).offset(horizontalSpace)
        }
        
        backgroundView1.snp.makeConstraints { make in
            make.top.bottom.equalToSuperview()
            make.left.equalTo(colonLabel.snp.right).offset(horizontalSpace)
            make.width.equalTo(25)
        }
        
        minuteTensLabel.snp.makeConstraints { make in
            make.top.bottom.equalToSuperview()
            make.left.equalTo(2)
        }
        
        minuteOnesLabel.snp.makeConstraints { make in
            make.top.bottom.equalTo(minuteTensLabel)
            make.left.equalTo(minuteTensLabel.snp.right)
        }
        
        colonLabel1.snp.makeConstraints { make in
            make.top.bottom.equalTo(hourTensLabel)
            make.left.equalTo(backgroundView1.snp.right).offset(horizontalSpace)
        }
        
        backgroundView2.snp.makeConstraints { make in
            make.top.bottom.equalToSuperview()
            make.width.equalTo(25)
            make.left.equalTo(colonLabel1.snp.right).offset(horizontalSpace)
        }
        
        secondTensLabel.snp.makeConstraints { make in
            make.top.bottom.equalToSuperview()
            make.left.equalTo(2)
        }
        
        secondOnesLabel.snp.makeConstraints { make in
            make.top.bottom.equalTo(secondTensLabel)
            make.left.equalTo(secondTensLabel.snp.right)
        }
    }
    
    func startTimer() {
        countDownTimer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(updateTime), userInfo: nil, repeats: true)
    }
    
    @objc func updateTime() {
        if totalTime > 0 {
            totalTime -= 1
            updateTimerLabel()
        } else {
            stopTimer()
        }
    }
    
    func updateTimerLabel() {
        let hours = totalTime / 3600
        let minutes = (totalTime % 3600) / 60
        let seconds = totalTime % 60
        
        checkTime(label: hourTensLabel, time: hours / 10)
        checkTime(label: hourOnesLabel, time: hours % 10)
        checkTime(label: minuteTensLabel, time: minutes / 10)
        checkTime(label: minuteOnesLabel, time: minutes % 10)
        checkTime(label: secondTensLabel, time: seconds / 10)
        checkTime(label: secondOnesLabel, time: seconds % 10)
    }
    
    func checkTime(label: UILabel, time: Int) {
        if label.text != String(format: "%01d", time) {
            animateTimerLable(label: label, newText: String(format: "%01d", time))
        }
    }
    
    func stopTimer() {
        countDownTimer?.invalidate()
    }
    
    func animateTimerLable(label: UILabel, newText: String) {
        // 新增數字往上滑的動畫
        let transition = CATransition()
        transition.duration = 0.3
        transition.type = .reveal
        transition.subtype = .fromTop
        
        transition.startProgress = 0.0
        transition.endProgress = 0.2
        
        label.layer.add(transition, forKey: kCATransition)
        label.text = newText
    }
    
    private func createLabel() -> UILabel {
        let label = UILabel()
        label.textAlignment = .center
        label.textColor = .white
        label.text = "0"
        return label
    }
    
    private func createColonLabel() -> UILabel {
        let label = UILabel()
        label.text = ":"
        return label
    }
    
    private func createBackgroundView() -> UIView {
        let view = UIView()
        view.backgroundColor = .black
        view.layer.cornerRadius = 5
        return view
    }
}
