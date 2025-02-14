//=============================================================================
// PROGRAMMER: Rafael Nieves
// PANTHER ID: 6326371
//
// CLASS: COP4655
// SECTION: RTEA RVC 1251
// SEMESTER: The current semester: Spring 2025
// CLASSTIME: Your COP4655 course meeting time :Online
//
// Assignment: Project 2
// DUE: 10 FEB 2025
//
// CERTIFICATION: I certify that this work is my own and that
// none of it is the work of any other person.
//=============================================================================

import UIKit
import Alamofire
import AlamofireImage

class PostCell: UITableViewCell {

    @IBOutlet private weak var usernameLabel: UILabel!
    @IBOutlet private weak var postImageView: UIImageView!
    @IBOutlet private weak var captionLabel: UILabel!
    @IBOutlet private weak var dateLabel: UILabel!

    private var imageDataRequest: DataRequest?

    func configure(with post: Post) {
        // TODO: Pt 1 - Configure Post Cell
        // Username
        if let user = post.user {
            usernameLabel.text = user.username
        }

        // Image
        if let imageFile = post.imageFile,
           let imageUrl = imageFile.url {
            
            // Use AlamofireImage helper to fetch remote image from URL
            imageDataRequest = AF.request(imageUrl).responseImage { [weak self] response in
                switch response.result {
                case .success(let image):
                    // Set image view image with fetched image
                    self?.postImageView.image = image
                case .failure(let error):
                    print("❌ Error fetching image: \(error.localizedDescription)")
                    break
                }
            }
        }

        // Caption
        captionLabel.text = post.caption

        // Date
        if let date = post.createdAt {
            dateLabel.text = DateFormatter.postFormatter.string(from: date)
        }
    }

    override func prepareForReuse() {
        super.prepareForReuse()
        // TODO: P1 - Cancel image download
        // Reset image view image.
        postImageView.image = nil

        // Cancel image request.
        imageDataRequest?.cancel()
    }
}
