import cv2

# Load the input image
image = cv2.imread('ocr-project/WhatsApp Image 2024-04-29 at 17.41.46.jpeg')

# Define bounding box coordinates or regions of interest (ROIs)
bounding_boxes = [(63,0,126,173), (564,0,631,174),(325,0,382,167)]  # List of tuples (x1, y1, x2, y2) representing bounding boxes

# Crop the regions of interest from the input image
cropped_images = []
for bbox in bounding_boxes:
    x1, y1, x2, y2 = bbox
    cropped_image = image[y1:y2, x1:x2]  # Crop the region defined by the bounding box
    cropped_images.append(cropped_image)

# Output the cropped images
for i, cropped_image in enumerate(cropped_images):
    cv2.imwrite(f'cropped_image_{i}.jpg', cropped_image)  # Save each cropped image to a file
