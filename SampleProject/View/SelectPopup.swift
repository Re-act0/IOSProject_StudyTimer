//
//  SelectPopup.swift
//

import UIKit

class SelectPopup: UIViewController {
    
    @IBOutlet weak var list: UIStackView!
    
    private var clickEvent: ((_ result: Int) -> ())!
    
    init(event: @escaping (_ result: Int) -> ()) {
        super.init(nibName: nil, bundle: nil)
        clickEvent = event
        
        modalPresentationStyle = .overCurrentContext
        modalTransitionStyle = .crossDissolve
    }
    
    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    @IBAction func clickButton(_ sender: UIButton) {
        clickEvent(sender.tag)
        dismiss(animated: true)
    }
}
