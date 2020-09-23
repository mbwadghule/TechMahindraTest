

import Kingfisher
import UIKit

class TableViewCell: UITableViewCell {
    let rowImageView: UIImageView = {
            let img = UIImageView()
            img.contentMode = .scaleAspectFill
            img.translatesAutoresizingMaskIntoConstraints = false 
           // img.layer.cornerRadius = Constants.imageCornerRadius
            img.clipsToBounds = true
            return img
        }()
        let titleLabel: UILabel = {
            let label = UILabel()
            label.font = UIFont.boldSystemFont(ofSize: Constants.titleFontSize)
            label.textColor = UIColor(red: 0.0, green: 0.004, blue: 0.502, alpha: 1.0)
            label.translatesAutoresizingMaskIntoConstraints = false
            return label
        }()
        let descriptionLabel: UILabel = {
            let label = UILabel()
            label.font = UIFont.systemFont(ofSize: Constants.descriptionFontSize)
            label.numberOfLines = Constants.numberOfLines
            label.textColor = .lightGray
            label.translatesAutoresizingMaskIntoConstraints = false
            return label
        }()
        var rowData: RowData? {
            didSet {
                titleLabel.text = rowData?.title
                let description = rowData?.rowDescription
                descriptionLabel.text = description
                if description == nil {
                   descriptionLabel.text = "                                         "
                }
                self.displayCellImage()
            }
        }
        
        override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
            super.init(style: style, reuseIdentifier: reuseIdentifier)
            self.setConstrains()
        }
        required init?(coder aDecoder: NSCoder) {
            super.init(coder: aDecoder)
        }
    }
extension TableViewCell {
    func displayCellImage() {
        if let imgHref = rowData?.imageHref {
            let url = URL(string: imgHref)!
            let resource = ImageResource(downloadURL: url, cacheKey: imgHref)
            self.rowImageView.kf.setImage(with: resource) { result in
                switch result {
                case .success(let value):
                    print(value.source.url?.absoluteString ?? "")
                case .failure(let error):
                    print(error.localizedDescription)
                    self.rowImageView.image = UIImage(named: Constants.blankImageName)
                }
            }
        }
        else {
            self.rowImageView.image = UIImage(named: Constants.blankImageName)
        }
    }
}
// MARK: - Set Constraints
private extension TableViewCell {
    func setConstrains() {
        self.contentView.addSubview(rowImageView)
        self.contentView.addSubview(titleLabel)
        self.contentView.addSubview(descriptionLabel)
        rowImageView.centerYAnchor.constraint(equalTo: self.contentView.centerYAnchor).isActive = true
        rowImageView.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: Constants.leadingValue).isActive = true
        rowImageView.widthAnchor.constraint(equalToConstant: Constants.imageWidth).isActive = true
        rowImageView.heightAnchor.constraint(equalToConstant: Constants.imageHeight).isActive = true
        titleLabel.topAnchor.constraint(equalTo: self.contentView.topAnchor, constant: Constants.leadingValue).isActive = true
        titleLabel.leftAnchor.constraint(equalTo: rowImageView.rightAnchor, constant: Constants.trailingValue).isActive = true
        titleLabel.rightAnchor.constraint(equalTo: self.contentView.rightAnchor, constant: -Constants.leadingValue).isActive = true
        titleLabel.heightAnchor.constraint(equalToConstant: Constants.titleLabelHeight).isActive = true
        descriptionLabel.topAnchor.constraint(equalTo: titleLabel.topAnchor, constant: Constants.vertialGap).isActive = true
        descriptionLabel.leftAnchor.constraint(equalTo: rowImageView.rightAnchor, constant: Constants.trailingValue).isActive = true
        descriptionLabel.rightAnchor.constraint(equalTo: self.contentView.rightAnchor, constant: -Constants.leadingValue).isActive = true
        descriptionLabel.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor, constant: -Constants.leadingValue).isActive = true
    }
}
