import Foundation
import UIKit

class MyDialog : UIView,UIGestureRecognizerDelegate{
    
    let tap = UITapGestureRecognizer()
    let contentView = UIView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = UIColor.darkGray.withAlphaComponent(0.6)
        tap.addTarget(self, action: #selector(dismiss))
        tap.delegate = self  // 设置tap手势代理，点击子视图不触发该tap事件
        self.addGestureRecognizer(tap)
        showContentView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    func showContentView() {
        contentView.frame = CGRect(x: 50, y: 100, width: self.frame.width - 100, height: 300)
        contentView.backgroundColor = UIColor.white
        contentView.layer.cornerRadius = 8
        contentView.clipsToBounds = true
        self.addSubview(contentView)
    }
    
    @objc func dismiss() {
        self.removeFromSuperview()
    }
    // 这里判断点子view不关闭弹出窗口
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldReceive touch: UITouch) -> Bool {
        if(touch.view == self) {
            return true
        } else {
            return false
        }
    }
    
}
