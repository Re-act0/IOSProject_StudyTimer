//
//  MainViewController.swift
//

import UIKit

class MainViewController: UIViewController {

    @IBOutlet weak var userNameLabel: UILabel!
    @IBOutlet weak var startDateLabel: UILabel!
    @IBOutlet weak var endDateLabel: UILabel!
    @IBOutlet weak var stateButton: UIButton!
    @IBOutlet weak var todayStudyTimeLabel: UILabel!
    @IBOutlet weak var todayProgressBar: UIStackView!
    @IBOutlet weak var yesterdayProgressBar: UIStackView!
    @IBOutlet weak var yesterdaySleepTimeLabel: UILabel!
    @IBOutlet weak var yesterdayRestTimeLabel: UILabel!
    @IBOutlet weak var yesterdayStudyTimeLabel: UILabel!
    @IBOutlet weak var tomorrowProgressBar: UIStackView!
    @IBOutlet weak var tomorrowSleepTimeLabel: UILabel!
    @IBOutlet weak var tomorrowRestTimeLabel: UILabel!
    @IBOutlet weak var tomorrowStudyTimeLabel: UILabel!
    @IBOutlet weak var nextTestTextView: UITextField!
    @IBOutlet weak var leftTimeLabel: UILabel!
    
    @IBOutlet weak var todaySleepTimeWidth: NSLayoutConstraint!
    @IBOutlet weak var todayStudyTimeWidth: NSLayoutConstraint!
    @IBOutlet weak var yesterdaySleepTimeWidth: NSLayoutConstraint!
    @IBOutlet weak var yesterdayStudyTimeWidth: NSLayoutConstraint!
    @IBOutlet weak var tomorrowSleepTimeWidth: NSLayoutConstraint!
    @IBOutlet weak var tomorrowStudyTimeWidth: NSLayoutConstraint!
    
    var isStudying = false
    
    var todayStudyTime: Int!
    var timer: Timer?
    var tomorrowSleepHour: Int!
    var tomorrowGoalsHour: Int!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        todayStudyTime = UserDefaults.standard.integer(forKey: ConstantsKey.todayStudyTime)
        setView()
    }
    
    private func setView() {
        let userName = UserDefaults.standard.string(forKey: ConstantsKey.userName)
        userNameLabel.text = userName
        
        let startDate = UserDefaults.standard.object(forKey: ConstantsKey.startDate) as! Date
        startDateLabel.text = startDate.toString()
        
        let endDate = UserDefaults.standard.object(forKey: ConstantsKey.endDate) as! Date
        endDateLabel.text = endDate.toString()

        leftTimeLabel.text = getLeftTime() + "시간"
        
        setTodayProgressBar()
        setYesterdayProgressBar()
        setTomorrowProgressBar()
    }
    
    private func getLeftTime() -> String {
        let testDate = UserDefaults.standard.object(forKey: ConstantsKey.endDate) as! Date
        let leftDate = NSInteger(Date().distance(to: testDate))
        let leftHours = (leftDate / 3600)
        return String(leftHours)
    }
    
    private func setTodayProgressBar() {
        let sleepTime = UserDefaults.standard.integer(forKey: ConstantsKey.todaySleepTime)
        
        let studyTimePercent = calculateTimePercent(second: todayStudyTime)
        let sleepTimePercent = calculateTimePercent(second: sleepTime)
        
        todaySleepTimeWidth.constant = todayProgressBar.frame.width * sleepTimePercent
        todayStudyTimeWidth.constant = todayProgressBar.frame.width * studyTimePercent
        todayStudyTimeLabel.text = "\(String(format: "%.3f", studyTimePercent * 100))%"
    }

    private func setYesterdayProgressBar() {
        let sleepTime = UserDefaults.standard.integer(forKey: ConstantsKey.yesterdaySleepTime)
        let studtyTime = UserDefaults.standard.integer(forKey: ConstantsKey.yesterdayStudyTime)
        
        let sleepTimePercent = calculateTimePercent(second: sleepTime)
        let studyTimePercent = calculateTimePercent(second: studtyTime)
        
        yesterdaySleepTimeWidth.constant = tomorrowProgressBar.frame.width * sleepTimePercent
        yesterdayStudyTimeWidth.constant = tomorrowProgressBar.frame.width * studyTimePercent
        yesterdaySleepTimeLabel.text = "\(Int(sleepTimePercent * 100))%"
        yesterdayStudyTimeLabel.text = "\(Int(studyTimePercent * 100))%"
        yesterdayRestTimeLabel.text = "\(100 - Int(sleepTimePercent * 100) - Int(studyTimePercent * 100))%"
    }
    
    private func setTomorrowProgressBar() {
        let sleepTime = Double(tomorrowSleepHour) / Double(24)
        let studyTime = Double(tomorrowGoalsHour) / Double(24)
        tomorrowSleepTimeWidth.constant = tomorrowProgressBar.frame.width * sleepTime
        tomorrowStudyTimeWidth.constant = tomorrowProgressBar.frame.width * studyTime
        tomorrowSleepTimeLabel.text = "\(Int(sleepTime * 100))%"
        tomorrowStudyTimeLabel.text = "\(Int(studyTime * 100))%"
        tomorrowRestTimeLabel.text = "\(100 - Int(sleepTime * 100) - Int(studyTime * 100))%"
    }
    
    private func calculateTimePercent(second: Int) -> Double {
        return Double(second) / Double(86400)
    }
    
    private func startAnimation() {
        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = [UIColor.red.cgColor, UIColor.white.cgColor, UIColor.red.cgColor]
        gradientLayer.locations = [0.0, 0.5, 1.0]
        gradientLayer.startPoint = CGPoint(x: 0.0, y: 0.5)
        gradientLayer.endPoint = CGPoint(x: 1.0, y: 0.5)
        gradientLayer.frame = todayProgressBar.subviews.first!.bounds
        
        let animation = CABasicAnimation(keyPath: "position.x")
        animation.fromValue = -todayProgressBar.subviews.first!.bounds.width / 2
        animation.toValue = todayProgressBar.subviews.first!.bounds.width + todayProgressBar.subviews.first!.bounds.width / 2
        animation.duration = 2
        animation.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeInEaseOut)
        
        let group = CAAnimationGroup()
        group.animations = [animation]
        group.duration = 2
        group.repeatCount = Float.greatestFiniteMagnitude
        gradientLayer.add(group, forKey: "glare")
        todayProgressBar.subviews.first!.clipsToBounds = true
        todayProgressBar.subviews.first!.layer.addSublayer(gradientLayer)
    }
    
    private func stopAnimation() {
        todayProgressBar.subviews.first!.layer.sublayers?.forEach { $0.removeFromSuperlayer() }
    }
    
    
    @objc private func startCount() {
        todayStudyTime += 1
        
        let studyTimePercent = calculateTimePercent(second: todayStudyTime)
        todayStudyTimeWidth.constant = todayProgressBar.frame.width * studyTimePercent
        todayStudyTimeLabel.text = "\(String(format: "%.3f", studyTimePercent * 100))%"
    }
    
    @IBAction func clickState(_ sender: UIButton) {
        isStudying.toggle()
        if isStudying {
            stateButton.setTitle("휴식하기", for: .normal)
            timer = Timer.scheduledTimer(timeInterval:1, target:self, selector:#selector(startCount), userInfo: nil, repeats: true)
            
            startAnimation()
        } else {
            stateButton.setTitle("공부 시작", for: .normal)
            timer?.invalidate()
            timer = nil
            
            stopAnimation()
            setTodayProgressBar()
            UserDefaults.standard.setValue(Date().toString(), forKey: ConstantsKey.todayDate)
            UserDefaults.standard.setValue(todayStudyTime, forKey: ConstantsKey.todayStudyTime)
        }
    }
    
    @IBAction func clickModify(_ sender: UIButton) {
        let sleepTime = UserDefaults.standard.integer(forKey: ConstantsKey.todaySleepTime)
        
        let alert = ModifyPopup(studyTime: todayStudyTime / 3600, sleepTime: sleepTime / 3600, event: { studyTime, sleepTime in
            self.todayStudyTime = studyTime * 3600
            UserDefaults.standard.setValue(studyTime * 3600, forKey: ConstantsKey.todayStudyTime)
            UserDefaults.standard.setValue(sleepTime * 3600, forKey: ConstantsKey.todaySleepTime)
            
            self.setTodayProgressBar()
        })
        present(alert, animated: true, completion: nil)
    }
    
    @IBAction func clickReset(_ sender: UIButton) {
        let domain = Bundle.main.bundleIdentifier!
        UserDefaults.standard.removePersistentDomain(forName: domain)
        UserDefaults.standard.synchronize()

        self.navigationController?.popToRootViewController(animated: true)
    }
    
    @IBAction func clickClose(_ sender: UIButton) {
        let studyTime = UserDefaults.standard.integer(forKey: ConstantsKey.todayStudyTime)
        let sleepTime = UserDefaults.standard.integer(forKey: ConstantsKey.todaySleepTime)
        
        UserDefaults.standard.set(studyTime, forKey: ConstantsKey.yesterdayStudyTime)
        UserDefaults.standard.set(sleepTime, forKey: ConstantsKey.yesterdaySleepTime)
        
        UserDefaults.standard.set(0, forKey: ConstantsKey.todayStudyTime)
        UserDefaults.standard.set(0, forKey: ConstantsKey.todaySleepTime)
        
        exit(0)
    }
}
