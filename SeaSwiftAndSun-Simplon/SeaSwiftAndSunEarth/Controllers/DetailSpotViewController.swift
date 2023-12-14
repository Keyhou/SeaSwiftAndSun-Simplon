import UIKit

class DetailSpotViewController: UIViewController {
    
    // MARK: - Properties
    var selectedSpot: Spot?
    var selectedImage: UIImage?
    
    // MARK: - IBOutlets
    @IBOutlet weak var detailsView: UIView!
    @IBOutlet weak var spotName: UILabel!
    @IBOutlet weak var spotImage: UIImageView!
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Check if a spot is selected and set up the UI
        if let spot = selectedSpot {
            setUpUI(spot: spot)
        }
        self.detailsView.accessibilityIdentifier = "DetailSpotView"
    }
    
    // MARK: - UI Setup
    func setUpUI(spot: Spot) {
        spotImage.image = selectedImage
        spotImage.layer.cornerRadius = spotImage.frame.size.width / 2
        spotName.text = spot.fields.destination
        
        // Set up the detailed information view for the spot
        setUpSpotDetails(spot: spot)
    }
    
    // MARK: - Surf Break Details
    private func setUpSpotDetails(spot: Spot) {
        // Peak surf season details
        let peakSurfSeason: [(title: String, dates: String)] = [
            ("Peak Season", "\(spot.fields.peakSurfSeasonBegins)・\(spot.fields.peakSurfSeasonEnds)")
        ]
        
        var surfBreakView: UIView?
    
        var surfBreakContainerView: UIView?

        if let spotSurfBreak = spot.fields.surfBreak.first {
            surfBreakView = createLabelWithBackground(
                text: spotSurfBreak,
                backgroundColor: surfBreakBackgroundColor(surfBreak: spotSurfBreak),
                cornerRadius: 10
            )

            surfBreakContainerView = UIView()
            surfBreakContainerView?.translatesAutoresizingMaskIntoConstraints = false
            surfBreakContainerView?.addSubview(surfBreakView!)

            // Add surfBreakContainerView to detailsView
            detailsView.addSubview(surfBreakContainerView!)

           
            surfBreakContainerView!.topAnchor.constraint(equalTo: detailsView.topAnchor, constant: 10).isActive = true
            surfBreakContainerView!.leadingAnchor.constraint(equalTo: detailsView.leadingAnchor, constant: 10).isActive = true
            surfBreakContainerView!.bottomAnchor.constraint(lessThanOrEqualTo: detailsView.bottomAnchor).isActive = true
            surfBreakContainerView!.trailingAnchor.constraint(lessThanOrEqualTo: detailsView.trailingAnchor, constant: -10).isActive = true

            surfBreakView!.topAnchor.constraint(equalTo: surfBreakContainerView!.topAnchor, constant: 10).isActive = true
            surfBreakView!.leadingAnchor.constraint(equalTo: surfBreakContainerView!.leadingAnchor, constant: 10).isActive = true
            surfBreakView!.heightAnchor.constraint(equalToConstant: 20).isActive = true
            surfBreakView!.bottomAnchor.constraint(equalTo: surfBreakContainerView!.bottomAnchor, constant: -10).isActive = true
            surfBreakView!.trailingAnchor.constraint(equalTo: surfBreakContainerView!.trailingAnchor, constant: -10).isActive = true

           
        }
        // Difficulty level stars
        let difficultyLevel = spot.fields.difficultyLevel
        let starsRow = createStarsRow(difficultyLevel: difficultyLevel)
        detailsView.addSubview(starsRow)

        var previousView: UIView = detailsView
        previousView = surfBreakContainerView ?? detailsView

        // Add constraints for stars row
        NSLayoutConstraint.activate([
            starsRow.topAnchor.constraint(equalTo: previousView.topAnchor, constant: 10),
            starsRow.trailingAnchor.constraint(equalTo: detailsView.trailingAnchor, constant: -10),
            starsRow.heightAnchor.constraint(equalToConstant: 25)
        ])
        
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
                    clockImageView.topAnchor.constraint(equalTo: surfBreakContainerView!.bottomAnchor, constant: 20),
                    clockImageView.leadingAnchor.constraint(equalTo: detailsView.leadingAnchor, constant: 10), // Adjusted to leadingAnchor
                    clockImageView.widthAnchor.constraint(equalToConstant: 15),
                    clockImageView.heightAnchor.constraint(equalToConstant: 15),

                    titleLabel.centerYAnchor.constraint(equalTo: clockImageView.centerYAnchor),
                    titleLabel.leadingAnchor.constraint(equalTo: clockImageView.trailingAnchor, constant: 8),
                    titleLabel.widthAnchor.constraint(equalToConstant: 220),
                    titleLabel.heightAnchor.constraint(equalToConstant: 25),

                    scheduleLabel.centerYAnchor.constraint(equalTo: clockImageView.centerYAnchor),
                    scheduleLabel.trailingAnchor.constraint(equalTo: detailsView.trailingAnchor, constant: -10),
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
                    iconImageView.topAnchor.constraint(equalTo: previousView.bottomAnchor, constant: 11),
                    iconImageView.leadingAnchor.constraint(equalTo: detailsView.leadingAnchor, constant: 10),
                    iconImageView.widthAnchor.constraint(equalToConstant: 15),
                    iconImageView.heightAnchor.constraint(equalToConstant: 15),

                    detailView.topAnchor.constraint(equalTo: previousView.bottomAnchor, constant: 7),
                    detailView.leadingAnchor.constraint(equalTo: iconImageView.trailingAnchor, constant: 8),
                    detailView.trailingAnchor.constraint(equalTo: detailsView.trailingAnchor, constant: -10),
                    detailView.heightAnchor.constraint(equalToConstant: 25)
                ])
            previousView = detailView
        }
    }
    
    // MARK: - Helper functions
    
    // Helper function to create a text with a background
    private func createLabelWithBackground(text: String, backgroundColor: UIColor, cornerRadius: CGFloat) -> UILabel {
        
        let label = UILabel()
        label.text = text
        label.backgroundColor = backgroundColor
        label.layer.cornerRadius = cornerRadius
        label.clipsToBounds = true
        label.translatesAutoresizingMaskIntoConstraints = false
    
        
        return label
    }
    
    // Helper function to determine background color based on surf break
    private func surfBreakBackgroundColor(surfBreak: String?) -> UIColor {
        switch surfBreak {
        case "Reef Break":
            return .systemCyan
        case "Point Break":
            return .systemMint
        case "Beach Break":
            return .systemTeal
        case "Outer Banks":
            return .systemPink
        default:
            return .systemYellow
        }
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
    
    // Helper function to create a row of stars based on difficulty level
    private func createStarsRow(difficultyLevel: Int) -> UIStackView {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.spacing = 4

        // You can customize the star image based on your needs
        let starImage = UIImage(systemName: "star.fill")
        let starImageViews: [UIImageView] = (0..<difficultyLevel).map { _ in
            let imageView = UIImageView(image: starImage)
            imageView.tintColor = .systemOrange
            return imageView
        }

        for starImageView in starImageViews {
            stackView.addArrangedSubview(starImageView)
        }

        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
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
