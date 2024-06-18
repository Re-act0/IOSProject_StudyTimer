//
//  ModifyPopup.swift
//

import UIKit

class ModifyPopup: UIViewController {

    @IBOutlet weak var studyTimeTextField: UITextField!
    @IBOutlet weak var sleepTimeTextField: UITextField!
    
    private var studyTime: Int!
    private var sleepTime: Int!
    private var clickEvent: ((_ studyTime: Int, _ sleepTime: Int) -> ())!
    
    init(studyTime: Int, sleepTime: Int, event: @escaping (_ studyTime: Int, _ sleepTime: Int) -> ()) {
        self.studyTime = studyTime
        self.sleepTime = sleepTime
        clickEvent = event
        
        super.init(nibName: nil, bundle: nil)
        
        modalPresentationStyle = .overCurrentContext
        modalTransitionStyle = .crossDissolve
    }
    
    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        studyTimeTextField.text = String(studyTime)
        sleepTimeTextField.text = String(sleepTime)
        addListenerHideKeyboard(self.view)
    }
    
    private func addListenerHideKeyboard(_ view : UIView){
        let gesture = UITapGestureRecognizer(target: self, action:  #selector(self.clickedViewBody(sender:)))
        view.addGestureRecognizer(gesture)
        gesture.cancelsTouchesInView = false
    }
    
    @objc private func clickedViewBody(sender:UIGestureRecognizer) {
        self.view.endEditing(true)
    }
    
    @IBAction func clickClose(_ sender: UIButton) {
        dismiss(animated: true)
    }
    
    @IBAction func clickButton(_ sender: UIButton) {
        let studyTime = Int(studyTimeTextField.text!) ?? 0
        let sleepTime = Int(sleepTimeTextField.text!) ?? 0
        
        clickEvent(studyTime, sleepTime)
        
        dismiss(animated: true)
    }
}
