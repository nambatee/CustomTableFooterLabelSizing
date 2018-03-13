import UIKit

class CustomFooter: UITableViewHeaderFooterView {
    
    public static var nib: UINib {
        return UINib(nibName: "CustomFooter", bundle: nil)
    }
    
    @IBOutlet weak var label: UILabel!
    
    public func heightWithExpectedWidth(_ width: CGFloat) -> CGFloat {
        label.preferredMaxLayoutWidth = width;
        return systemLayoutSizeFitting(UILayoutFittingCompressedSize).height
    }
}
