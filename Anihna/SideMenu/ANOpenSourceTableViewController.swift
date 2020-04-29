//
//  UIVIewController.swift
//  Anihna
//
//  Created by Raihana Souleymane on 4/26/20.
//  Copyright © 2020 Raihana Souleymane. All rights reserved.

import UIKit


let expandingCellId = "expandingCell"
let estimatedHeight: CGFloat = 150
let topInset: CGFloat = 20


class ANOpenSourceTableViewController: UITableViewController {

    let viewModel = MainViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let bgColor = ANStyleGuideManager.Colors.Background()
        self.view.backgroundColor = bgColor
        self.tableView.backgroundColor = bgColor
        let estimatedHeight: CGFloat = 120
        let topInset: CGFloat = 20
        tableView.contentInset.top = topInset
        tableView.estimatedRowHeight = estimatedHeight
        tableView.rowHeight = UITableView.automaticDimension
         self.navigationItem.titleView = ANNavigationBarTitleViewFactory.standardTitleView(withTitle: "Third Party Notices")
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.count()
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        let cell = tableView.dequeueReusableCell(withIdentifier: "expandingCell", for: indexPath) as! ExpandingCell

        cell.title = viewModel.titleForRow(row: indexPath.row)
        cell.detail = viewModel.detailForRow(row: indexPath.row)
        return cell
    }

    // MARK: Table view delegate

    override func tableView(_ tableView: UITableView, willSelectRowAt indexPath: IndexPath) -> IndexPath? {

        if let selectedIndex = tableView.indexPathForSelectedRow {
            if selectedIndex == indexPath {

                tableView.beginUpdates()
                tableView.deselectRow(at: indexPath, animated: true)
                tableView.endUpdates()

                return nil
            }
        }

        return indexPath
    }
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.beginUpdates()
        tableView.endUpdates()
    }

}


struct MainViewModel {

    private let items = SimpleItemStore.defaultItems()

    func count() -> Int {
        return items.count
    }

    func titleForRow(row: Int) -> String {
        return items[row].title
    }

    func detailForRow(row: Int) -> String {
        return items[row].detail
    }
}

protocol ExpandingCellDelegate : class {
    func didSelect(selectedIndexpath: ExpandingCell)
    func didUnselect(unSelectedIndexpath: ExpandingCell)
}

class ExpandingCell: UITableViewCell {

    weak var delegate: ExpandingCellDelegate?
    var title: String? {
        didSet {
            titleLabel.text = title
        }
    }

    var detail: String? {
        didSet {
            detailLabel.text = detail
        }
    }

    @IBOutlet weak var mainView: UIView!
    @IBOutlet private weak var stackView: UIStackView!
    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var detailLabel: UILabel!

    @IBOutlet weak var arrowImage: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        titleLabel.font = ANStyleGuideManager.Fonts.Fields.Field2InputText()
        stackView.arrangedSubviews.last?.isHidden = true
        resetButton()
        let titleColor = ANStyleGuideManager.Colors.Title()
        self.titleLabel.textColor = titleColor
        self.detailLabel.backgroundColor = UIColor.clear
        self.detailLabel.textColor = titleColor
        self.mainView.backgroundColor = ANStyleGuideManager.Colors.InvertedCoolGrays()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        
        super.setSelected(selected, animated: animated)
        
        UIView.animate(withDuration: 0.5,
                       delay: 0,
                       usingSpringWithDamping: 1,
                       initialSpringVelocity: 1,
                       options: UIView.AnimationOptions.curveEaseIn,
                       animations: { () -> Void in
                        self.stackView.arrangedSubviews.last?.isHidden = !selected
                        if selected{
                            self.setButtonForEdit()
                            
                        }else{
                            self.resetButton()
                        }
        },
                       completion: nil)
    }

    func setButtonForEdit(){
        self.arrowImage.image = UIImage.init(named: "Icon - Carat Up - Gray")?.withRenderingMode(.alwaysOriginal)
      
    }

    func resetButton(){
          self.arrowImage.image = UIImage.init(named: "Icon - Carat Down - Gray")?.withRenderingMode(.alwaysOriginal)
    }

}

struct SimpleItemStore {
    static func defaultItems() -> [SimpleItem] {
        return [
            SimpleItem(title: "NVActivityIndicatorView", detail:  "   The MIT License (MIT)  "  + "\n" +
                "   Copyright (c) 2016 Vinh Nguyen  "  +  "\n" + "\n" +
                "Permission is hereby granted, free of charge, to any person obtaining a copy  "  +
                "of this software and associated documentation files (the 'Software'), to deal  "  +
                "in the Software without restriction, including without limitation the rights  "  +
                "to use, copy, modify, merge, publish, distribute, sublicense, and/or sell  "  +
                "copies of the Software, and to permit persons to whom the Software is  "  +
                "furnished to do so, subject to the following conditions:  "  + "\n" +
                "The above copyright notice and this permission notice shall be included in all  "  +
                "copies or substantial portions of the Software.  "  + "\n" +
                "THE SOFTWARE IS PROVIDED 'AS IS', WITHOUT WARRANTY OF ANY KIND, EXPRESS OR  "  +
                "IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,  "  +
                "FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE  "  +
                "AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER  "  +
                "LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,  "  +
                "OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.  " ),
            SimpleItem(title: "SDWebImage", detail:
                "Copyright (c) 2009-2017 Olivier Poitrey rs@dailymotion.com  "  + "\n\n" +
                "Permission is hereby granted, free of charge, to any person obtaining a copy  "  +
                    "of this software and associated documentation files (the 'Software'), to deal  "  +
                    "in the Software without restriction, including without limitation the rights  "  +
                    "to use, copy, modify, merge, publish, distribute, sublicense, and/or sell  "  +
                    "copies of the Software, and to permit persons to whom the Software is furnished  "  +
                    "to do so, subject to the following conditions:  "  + "\n\n" +
                "The above copyright notice and this permission notice shall be included in all  "  +
                "copies or substantial portions of the Software.  "  + "\n\n" +
                "THE SOFTWARE IS PROVIDED 'AS IS', WITHOUT WARRANTY OF ANY KIND, EXPRESS OR  "  +
                "IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,  "  +
                "FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE  "  +
                "AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER  "  +
                "LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,  "  +
                "OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN "  +
                "THE SOFTWARE.  " ),
            SimpleItem(title: "Alamofire", detail: "Copyright (c) 2014-2018 Alamofire Software Foundation (http://alamofire.org/)  "  + "\n\n" +
                "Permission is hereby granted, free of charge, to any person obtaining a copy  "  +
                    "of this software and associated documentation files (the 'Software'), to deal  "  +
                    "in the Software without restriction, including without limitation the rights  "  +
                    "to use, copy, modify, merge, publish, distribute, sublicense, and/or sell  "  +
                    "copies of the Software, and to permit persons to whom the Software is  "  +
                    "furnished to do so, subject to the following conditions:  "   + "\n\n" +
                "The above copyright notice and this permission notice shall be included in  "  +
                "all copies or substantial portions of the Software.  "   + "\n\n" +
                "THE SOFTWARE IS PROVIDED 'AS IS', WITHOUT WARRANTY OF ANY KIND, EXPRESS OR  "  +
                "IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,  "  +
                "FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE  "  +
                "AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER  "  +
                "LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,  "  +
                "OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN  "  +
                "THE SOFTWARE.  " ),
            SimpleItem(title: "KeyChainSwift", detail: "The MIT License  "  + "\n" +
                "Copyright (c) 2015 Marketplacer  " + "\n\n" +
                "Permission is hereby granted, free of charge, to any person obtaining a copy  "  +
                "of this software and associated documentation files (the 'Software'), to deal  "  +
                "in the Software without restriction, including without limitation the rights  "  +
                "to use, copy, modify, merge, publish, distribute, sublicense, and/or sell  "  +
                "copies of the Software, and to permit persons to whom the Software is  "  +
                "furnished to do so, subject to the following conditions:  "  + "\n\n" +
                "The above copyright notice and this permission notice shall be included in  "  +
                "all copies or substantial portions of the Software.  "   + "\n\n" +
                "THE SOFTWARE IS PROVIDED 'AS IS', WITHOUT WARRANTY OF ANY KIND, EXPRESS OR  "  +
                "IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,  "  +
                "FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE  "  +
                "AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER  "  +
                "LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,  "  +
                "OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN  "  +
                "THE SOFTWARE.  " ),
        ]
    }
}
struct SimpleItem {
    let title: String
    let detail: String
}


