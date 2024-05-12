from flask import Flask, request, jsonify
import cv2
import numpy as np
from boxdetect.pipelines import get_boxes
from boxdetect import config
from boxdetect.img_proc import draw_rects, get_image
from keras.models import load_model

app = Flask(__name__)
model = load_model('mnist.h5')  # Load your Keras model
output = []

def preprocess_image(file_path):
    image = cv2.imread(file_path)
    grey = cv2.cvtColor(image.copy(), cv2.COLOR_BGR2GRAY)
    ret, thresh = cv2.threshold(grey.copy(), 150, 255, cv2.THRESH_BINARY_INV)
    cfg = config.PipelinesConfig()

    cfg.width_range = (25, 45)
    cfg.height_range = (25, 45)
    cfg.scaling_factors = [1.0]
    cfg.wh_ratio_range = (0.5, 1.8)
    cfg.group_size_range = (1, 100)
    cfg.morph_kernels_type = 'rectangles'
    cfg.dilation_iterations = 0

    rects, _, _, _ = get_boxes(file_path, cfg=cfg, plot=False)
    out_img = draw_rects(image, rects, thickness=3)

    sorted_rects = sorted(rects, key=lambda x: x[1])
    out = []
    preprocessed_digits = [sorted_rects[12], sorted_rects[17], sorted_rects[24]]
    present = []
    count = 0
    for i, rect in enumerate(sorted_rects):
        if i % 10 == 0 and i != 0:
            present.append(count)
            count = 0
        x, y, w, h = rect
        digit = thresh[y:y + h, x:x + w]
        resized_digit = cv2.resize(digit, (18, 18), interpolation=cv2.INTER_AREA)
        grayscale_digit = resized_digit.copy()
        normalized_digit = grayscale_digit / 255.0
        padded_digit = np.pad(normalized_digit, ((5, 5), (5, 5)), mode='constant', constant_values=0)
        digit_input = padded_digit.reshape(1, 28, 28, 1)
        prediction = model.predict(digit_input)
        out.append(np.argmax(prediction))
        if np.argmax(prediction) == 1:
            count += 1
        output.append(np.argmax(prediction))

    for i in range(len(present)):
        print('student', i + 1, 'is present for {} days and absent for {}'.format(present[i], 10 - present[i]))
    return present

@app.route('/process_image', methods=['POST'])
def process_image():
    global output
    if 'file' not in request.files:
        return jsonify({'error': 'No file provided'})

    file = request.files['file']
    file_path = 'images/yuvan1.jpeg'
    file.save(file_path)

    preprocessed_image = preprocess_image(file_path)

    # Convert int64 objects to regular integers before returning the response
    preprocessed_image = [int(item) for item in preprocessed_image]
    return jsonify({'output': preprocessed_image})

if __name__ == '__main__':
    app.run(debug=True)
