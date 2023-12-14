import UIKit

class DetailSpotViewController: UIViewController {
    var selectedSpot: Spot?
    var selectedImage: UIImage?
    
    @IBOutlet weak var detailsView: UIView!
    @IBOutlet weak var spotName: UILabel!
    @IBOutlet weak var spotImage: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Check if a spot is selected and set up the UI
        if let spot = selectedSpot {
            setUpUI(spot: spot)
        }
        
        self.detailsView.accessibilityIdentifier = "DetailSpotView"
    }
    
    // Set up the basic UI elements based on the selected spot
    func setUpUI(spot: Spot) {
        spotImage.image = selectedImage
        spotImage.layer.cornerRadius = spotImage.frame.size.width / 2
        spotName.text = spot.fields.destination
        
        // Set up the detailed information view for the spot
        setUpSpotDetails(spot: spot)
    }
    
    // Helper function to create an image view with a system icon
    private func createIconImageView(systemName: String) -> UIImageView {
        let imageView = UIImageView(image: UIImage(systemName: systemName))
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }
    
    // Helper function to create a label with specified text and alignment
    private func createLabel(text: String, alignment: NSTextAlignment = .left) -> UILabel {
        let label = UILabel()
        label.text = text
        label.textAlignment = alignment
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }
    
    // Set up the detailed information view for the spot, including peak surf season and contact details
    private func setUpSpotDetails(spot: Spot) {
        // Peak surf season details
        let peakSurfSeason: [(title: String, dates: String)] = [
            ("Peak Surf Season", "\(spot.fields.peakSurfSeasonBegins)・\(spot.fields.peakSurfSeasonEnds)")
        ]
        var previousView: UIView = detailsView
        
        for (title, dates) in peakSurfSeason {
            // Create clock icon image view
            let clockImageView = createIconImageView(systemName: "clock")
            detailsView.addSubview(clockImageView)
            
            // Create title label
            let titleLabel = createLabel(text: title)
            detailsView.addSubview(titleLabel)
            
            // Create schedule label
            let scheduleLabel = createLabel(text: dates, alignment: .right)
            detailsView.addSubview(scheduleLabel)
            
            // Add constraints for clock icon, title, and schedule labels
            NSLayoutConstraint.activate([
                clockImageView.topAnchor.constraint(equalTo: previousView.topAnchor, constant: 4),
                clockImageView.leftAnchor.constraint(equalTo: detailsView.leftAnchor, constant: 4),
                clockImageView.widthAnchor.constraint(equalToConstant: 12),
                clockImageView.heightAnchor.constraint(equalToConstant: 12),
                
                titleLabel.centerYAnchor.constraint(equalTo: clockImageView.centerYAnchor),
                titleLabel.leftAnchor.constraint(equalTo: clockImageView.rightAnchor, constant: 8),
                titleLabel.widthAnchor.constraint(equalToConstant: 220),
                titleLabel.heightAnchor.constraint(equalToConstant: 25),
                
                scheduleLabel.centerYAnchor.constraint(equalTo: clockImageView.centerYAnchor),
                scheduleLabel.rightAnchor.constraint(equalTo: detailsView.rightAnchor),
                scheduleLabel.widthAnchor.constraint(equalToConstant: 250),
                scheduleLabel.heightAnchor.constraint(equalToConstant: 25)
            ])
            
            previousView = scheduleLabel
        }
        
        // Contact details, including a link
        let contactDetails: [(icon: String, detail: String)] = [
            ("mappin.and.ellipse", spot.fields.destinationStateCountry),
            ("link", spot.fields.magicSeaweedLink)
        ]
        
        for (icon, detail) in contactDetails {
            // Create icon image view
            let iconImageView = createIconImageView(systemName: icon)
            detailsView.addSubview(iconImageView)
            
            var detailView: UIView
            
            // Check if the detail is a link, and create a UITextView if so
            if icon == "link", let url = URL(string: detail) {
                let linkTextView = createLinkTextView(url: url, detail: detail)
                detailsView.addSubview(linkTextView)
                detailView = linkTextView
            } else {
                // Create a regular label for non-link details
                let detailLabel = createLabel(text: detail)
                detailsView.addSubview(detailLabel)
                detailView = detailLabel
            }
            
            // Add constraints for icon and detail view
            NSLayoutConstraint.activate([
                iconImageView.topAnchor.constraint(equalTo: previousView.bottomAnchor, constant: 10),
                iconImageView.leftAnchor.constraint(equalTo: detailsView.leftAnchor, constant: 4),
                iconImageView.widthAnchor.constraint(equalToConstant: 12),
                iconImageView.heightAnchor.constraint(equalToConstant: 12),
                
                detailView.topAnchor.constraint(equalTo: previousView.bottomAnchor, constant: 10),
                detailView.leftAnchor.constraint(equalTo: iconImageView.rightAnchor, constant: 8),
                detailView.rightAnchor.constraint(equalTo: detailsView.rightAnchor),
                detailView.heightAnchor.constraint(equalToConstant: 25)
            ])
            
            previousView = detailView
        }
    }
    
    // Create a UITextView for displaying a link with tap functionality
    private func createLinkTextView(url: URL, detail: String) -> UITextView {
        let textView = UITextView()
        textView.isEditable = false
        textView.isScrollEnabled = false
        textView.dataDetectorTypes = .link
        textView.textColor = .systemBlue
        textView.backgroundColor = .clear
        textView.textContainer.lineFragmentPadding = 0
        textView.textContainerInset = .zero
        textView.linkTextAttributes = [
            NSAttributedString.Key.foregroundColor: UIColor.systemBlue,
            NSAttributedString.Key.underlineStyle: NSUnderlineStyle.single.rawValue
        ]
        textView.translatesAutoresizingMaskIntoConstraints = false
        textView.heightAnchor.constraint(equalToConstant: 25).isActive = true
        
        // Create an attributed string with a link attribute
        let attributedString = NSMutableAttributedString(string: "\(detail)")
        attributedString.addAttribute(.link, value: url, range: NSRange(location: 0, length: detail.count))
        
        textView.attributedText = attributedString
        
        return textView
    }
}
