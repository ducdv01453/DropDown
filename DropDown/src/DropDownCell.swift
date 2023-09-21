//
//  DropDownCellTableViewCell.swift
//  DropDown
//
//  Created by Kevin Hirsch on 28/07/15.
//  Copyright (c) 2015 Kevin Hirsch. All rights reserved.
//

#if os(iOS)

import UIKit

open class DropDownCell: UITableViewCell {
		
	//UI
	@IBOutlet open weak var optionLabel: UILabel!
    @IBOutlet open weak var imageViewCheckMark: UIImageView!
    
	var selectedBackgroundColor: UIColor?
    var checkmarkColor: UIColor?
    var highlightTextColor: UIColor?
    var normalTextColor: UIColor?

}

//MARK: - UI

extension DropDownCell {
	
	override open func awakeFromNib() {
		super.awakeFromNib()
		
		backgroundColor = .clear
	}
	
	override open var isSelected: Bool {
		willSet {
			setSelected(newValue, animated: false)
		}
	}
	
	override open var isHighlighted: Bool {
		willSet {
            setCustomHighlighted(newValue, animated: false)
		}
	}
    
    func setCustomHighlighted(_ selected: Bool, animated: Bool) {
        let executeSelection: () -> Void = { [weak self] in
            guard let `self` = self else { return }
            self.imageViewCheckMark.tintColor = checkmarkColor ?? .gray
            
            if let selectedBackgroundColor = self.selectedBackgroundColor {
                if selected {
                    self.backgroundColor = selectedBackgroundColor
                    self.optionLabel.textColor = self.highlightTextColor
                } else {
                    self.backgroundColor = .clear
                    self.optionLabel.textColor = self.normalTextColor
                }
            }
        }
        
        if animated {
            UIView.animate(withDuration: 0.3, animations: {
                executeSelection()
            })
        } else {
            executeSelection()
        }

        accessibilityTraits = selected ? .selected : .none
    }

	override open func setHighlighted(_ highlighted: Bool, animated: Bool) {
        setCustomHighlighted(highlighted, animated: animated)
	}
    
	override open func setSelected(_ selected: Bool, animated: Bool) {
		let executeSelection: () -> Void = { [weak self] in
			guard let `self` = self else { return }
            self.imageViewCheckMark.tintColor = checkmarkColor ?? .gray
            
			if let selectedBackgroundColor = self.selectedBackgroundColor {
				if selected {
                    self.imageViewCheckMark.image = UIImage(systemName: "checkmark")
					self.backgroundColor = selectedBackgroundColor
                    self.optionLabel.textColor = self.highlightTextColor
				} else {
                    self.imageViewCheckMark.image = nil
					self.backgroundColor = .clear
                    self.optionLabel.textColor = self.normalTextColor
				}
			}
		}
		
		if animated {
			UIView.animate(withDuration: 0.3, animations: {
				executeSelection()
			})
		} else {
			executeSelection()
		}

		accessibilityTraits = selected ? .selected : .none
	}
	
}

#endif
