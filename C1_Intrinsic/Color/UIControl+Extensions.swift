import UIKit

class MyView_GradiendBackground : UIView {
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        let topColor: UIColor = #colorLiteral(red: 0.02036951855, green: 0.08131060749, blue: 0.1756200194, alpha: 1)
        let bottomColor: UIColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        
        let layer = self.layer as! CAGradientLayer
        layer.colors = [topColor, bottomColor].map{$0.cgColor}
        layer.startPoint = CGPoint(x: 0.5, y: 0.6)
        layer.endPoint = CGPoint (x: 0.5, y: 1)
    }
    
    override class var layerClass: AnyClass {
       get {
           return CAGradientLayer.self
       }
   }
}
