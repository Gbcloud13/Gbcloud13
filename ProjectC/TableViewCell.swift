import UIKit

class TableViewCell: UITableViewCell {
    var listingImageView: UIImageView!
    var titleLbl: UILabel!
    var commentsLbl: UILabel!
    var scoreLbl: UILabel!
    
    var data: ChildData? {
        didSet {
            self.dataBinding()
        }
    }
    
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:)")
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        listingImageView = UIImageView()
        listingImageView.layer.masksToBounds = false
        contentView.addSubview(listingImageView)
        
        titleLbl = UILabel()
        titleLbl.numberOfLines = 0
        titleLbl.textColor = UIColor.black
        contentView.addSubview(titleLbl)
        
        commentsLbl = UILabel()
        commentsLbl.textColor = UIColor.black
        contentView.addSubview(commentsLbl)
        
        scoreLbl = UILabel()
        scoreLbl.textColor = UIColor.black
        contentView.addSubview(scoreLbl)
        
        // Set any attributes of your UI components here.
        [titleLbl, commentsLbl, scoreLbl].forEach { (lbl) in
            lbl?.translatesAutoresizingMaskIntoConstraints = false
            lbl?.font = UIFont.systemFont(ofSize: 20)
        }
      
    }
    
    private func dataBinding() {
        let imageUrl = URL(string: data?.imageUrl ?? "")
        self.listingImageView.sd_setImage(with: imageUrl, completed: nil)
        self.titleLbl.text = "Title: \(data?.title ?? "")"
        self.commentsLbl.text = "Comments: \(data?.numComments ?? 0)"
        self.scoreLbl.text = "Score: \(data?.score ?? 0)"
        self.constraintsHandling()
    }
    
    private func constraintsHandling() {
        let width = CGFloat(data?.thumbnailWidth ?? 0)
        let height = CGFloat(data?.thumbnailHeight ?? 0)
        
        listingImageView.translatesAutoresizingMaskIntoConstraints = false
    
        listingImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor).isActive = true
        listingImageView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor).isActive = true
        listingImageView.widthAnchor.constraint(equalToConstant: width).isActive = true
        listingImageView.heightAnchor.constraint(equalToConstant: height).isActive = true
   
        NSLayoutConstraint.activate([
            titleLbl.leadingAnchor.constraint(equalTo: listingImageView.trailingAnchor, constant: 20),
            titleLbl.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 5),
            titleLbl.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            titleLbl.heightAnchor.constraint(equalToConstant: 100),
            
            commentsLbl.leadingAnchor.constraint(equalTo: listingImageView.trailingAnchor, constant: 20),
            commentsLbl.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            commentsLbl.topAnchor.constraint(equalTo: titleLbl.bottomAnchor, constant: 5),
            commentsLbl.heightAnchor.constraint(equalToConstant: 50),
            
            scoreLbl.leadingAnchor.constraint(equalTo: listingImageView.trailingAnchor, constant: 20),
            scoreLbl.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -20),
            scoreLbl.topAnchor.constraint(equalTo: commentsLbl.bottomAnchor, constant: 5),
            scoreLbl.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            scoreLbl.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
}
