import cv2
from boxdetect.pipelines import get_boxes
from boxdetect import config
from boxdetect.img_proc import draw_rects, get_image
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
def hdr(file_path):
    image = cv2.imread(file_path)
    grey = cv2.cvtColor(image.copy(), cv2.COLOR_BGR2GRAY)
    ret, thresh = cv2.threshold(grey.copy(), 150, 255, cv2.THRESH_BINARY_INV)
    plt.imshow(thresh, cmap='gray')
    plt.show()
    cfg = config.PipelinesConfig()

    # important to adjust these values to match the size of boxes on your image
    cfg.width_range = (25,45)
    cfg.height_range = (25,45)

    # the more scaling factors the more accurate the results but also it takes more time to processing
    # too small scaling factor may cause false positives
    # too big scaling factor will take a lot of processing time
    cfg.scaling_factors = [1.0]

    # w/h ratio range for boxes/rectangles filtering
    cfg.wh_ratio_range = (0.5, 1.8)

    # range of groups sizes to be returned
    cfg.group_size_range = (1, 100)

    # for this image we will use rectangles as a kernel for morphological transformations
    cfg.morph_kernels_type = 'rectangles'  # 'lines'

    # num of iterations when running dilation tranformation (to engance the image)
    cfg.dilation_iterations = 0

    rects, _, _, _ = get_boxes(
        file_path, cfg=cfg, plot=False)

    out_img = draw_rects(image, rects, thickness=3)

    plt.figure(figsize=(15,20))
    plt.imshow(out_img)
    plt.show()
    sorted_rects = sorted(rects, key=lambda x: x[1])
    out = []
    preprocessed_digits = [sorted_rects[12],sorted_rects[17],sorted_rects[24]]
    present = []
    count = 0
    for i, rect in enumerate(sorted_rects):
        if i % 10 == 0 and i != 0:
            present.append(count)
            count = 0
        # Extract digit image data based on rectangle coordinates
        x, y, w, h = rect
        digit = thresh[y:y+h, x:x+w]
        # Resize the digit image to 28x28 pixels
        resized_digit = cv2.resize(digit, (18, 18), interpolation=cv2.INTER_AREA)
        # Convert the resized digit image to grayscale (if not already)
        grayscale_digit = resized_digit.copy()

        # Normalize pixel values to [0, 1]
        normalized_digit = grayscale_digit / 255.0
        padded_digit = np.pad(normalized_digit, ((5,5),(5,5)), mode='constant', constant_values=0)
        # Reshape the digit image to match the input shape of the model
        digit_input = padded_digit.reshape(1, 28, 28, 1)

        # Make prediction with the model
        prediction = model.predict(digit_input)
        
        print ("\n\n---------------------------------------\n\n")
        print ("=========PREDICTION============ \n\n")
        # plt.imshow(digit_input.reshape(28, 28), cmap="gray")
        # plt.show()
        print("\n\nFinal Output: {}".format(np.argmax(prediction)))
        out.append(np.argmax(prediction))
        if np.argmax(prediction) == 1:
            count += 1   
        print ("\nPrediction (Softmax) from the neural network:\n\n {}".format(prediction))
        
        hard_maxed_prediction = np.zeros(prediction.shape)
        hard_maxed_prediction[0][np.argmax(prediction)] = 1
        print ("\n\nHard-maxed form of the prediction: \n\n {}".format(hard_maxed_prediction))
        print ("\n\n---------------------------------------\n\n")
        output.append(np.argmax(prediction))

    for i in range(len(present)):
        print('student',i+1,'is present for {} days and absent for {}'.format(present[i],10-present[i]))
    return present

# Call the function with the image file path
output = hdr('images/yuvan1.jpeg')
print("Predictions:", output)