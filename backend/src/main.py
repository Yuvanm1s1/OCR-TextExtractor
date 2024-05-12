import cv2
import numpy as np
from keras.datasets import mnist
from keras.layers import Dense, Flatten
from keras.layers.convolutional import Conv2D
from keras.models import Sequential
from keras.utils import to_categorical
import matplotlib.pyplot as plt
from keras.models import load_model
model=load_model('mnist.h5')
output=[]
def hdr(img):
    image = cv2.imread(img)
    grey = cv2.cvtColor(image.copy(), cv2.COLOR_BGR2GRAY)
    ret, thresh = cv2.threshold(grey.copy(), 75, 255, cv2.THRESH_BINARY_INV)
    contours, _ = cv2.findContours(thresh.copy(), cv2.RETR_EXTERNAL, cv2.CHAIN_APPROX_SIMPLE)
    min_width=5
    max_width=60
    min_height=10
    max_height=60
    filtered_contours = []
    for contour in contours:
        area = cv2.contourArea(contour)
        x,y,w,h = cv2.boundingRect(contour)

        width = w
        height = h
        if min_height<=height<=max_height and min_width<=width<=max_width:  # Define a threshold area to filter out larger contours
            filtered_contours.append(contour)
    filtered_contours.sort(key=lambda c: cv2.boundingRect(c)[0],reverse=True)
    preprocessed_digits = []
    for c in filtered_contours:
        x,y,w,h = cv2.boundingRect(c)
        
        # Creating a rectangle around the digit in the original image (for displaying the digits fetched via contours)
        cv2.rectangle(image, (x, y), (x+w, y+h), (0, 255, 0), 2)
        
        # Cropping out the digit from the image corresponding to the current contours in the for loop
        digit = thresh[y:y+h, x:x+w]
        
        # Resizing that digit to (18, 18)
        resized_digit = cv2.resize(digit, (18,18))
        
        # Padding the digit with 5 pixels of black color (zeros) in each side to finally produce the image of (28, 28)
        padded_digit = np.pad(resized_digit, ((5,5),(5,5)), "constant", constant_values=0)
        
        # Adding the preprocessed digit to the list of preprocessed digits
        preprocessed_digits.append(padded_digit)
    print("\n\n\n----------------Contoured Image--------------------")
    plt.imshow(image, cmap="gray")
    plt.show()
    inp = np.array(preprocessed_digits)
    print("after np array")
    out = []
    for digit in preprocessed_digits:
        prediction = model.predict(digit.reshape(1, 28, 28, 1))  
        
        print ("\n\n---------------------------------------\n\n")
        print ("=========PREDICTION============ \n\n")
        plt.imshow(digit.reshape(28, 28), cmap="gray")
        plt.show()
        print("\n\nFinal Output: {}".format(np.argmax(prediction)))
        out.append(np.argmax(prediction))   
        
        print ("\nPrediction (Softmax) from the neural network:\n\n {}".format(prediction))
        
        hard_maxed_prediction = np.zeros(prediction.shape)
        hard_maxed_prediction[0][np.argmax(prediction)] = 1
        print ("\n\nHard-maxed form of the prediction: \n\n {}".format(hard_maxed_prediction))
        print ("\n\n---------------------------------------\n\n")
    output.append(out)
def crop():
    import cv2

    # Load the input image
    image = cv2.imread('images/WhatsApp Image 2024-04-29 at 17.41.46.jpeg')

    # Define bounding box coordinates or regions of interest (ROIs)
    bounding_boxes = [(63,0,126,173),(320,0,382,167), (564,0,631,174)]  # List of tuples (x1, y1, x2, y2) representing bounding boxes

    # Crop the regions of interest from the input image
    cropped_images = []
    for bbox in bounding_boxes:
        x1, y1, x2, y2 = bbox
        cropped_image = image[y1:y2, x1:x2]  # Crop the region defined by the bounding box
        cropped_images.append(cropped_image)

    # Output the cropped images
    for i, cropped_image in enumerate(cropped_images):
        cv2.imwrite(f'images/cropped_image_{i}.jpg', cropped_image)  # Save each cropped image to a file


image_path=['images/cropped_image_0.jpg','images/cropped_image_1.jpg','images/cropped_image_2.jpg']
crop()
for image in image_path:
    hdr(image)
dic = {}
ind = 1
for i in range(len(output)):
    for j in range(len(output[i])):
        if j%2!=0 and i==2:
            continue
        if i==2 and j%2==0:
            dic[ind]=int(str(output[i][j])+str(output[i][j+1]))
        else:
            dic[ind]=output[i][j]
        ind+=1
for key,values in dic.items():
    print(f"Mark for question no {key} is {values}")