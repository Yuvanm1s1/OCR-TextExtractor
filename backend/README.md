# OCR Attendance and Mark Detection

This project combines Optical Character Recognition (OCR) with machine learning (ML) models for box detection to automate attendance and mark detection tasks. The Flask server receives images containing attendance sheets or mark sheets, processes them using OCR and box detection algorithms, and returns the detected data.

## Features

- **Attendance Detection:** Extracts attendance data from images of attendance sheets, providing information on student presence and absence.
- **Mark Detection:** Recognizes marks or scores from images of mark sheets, enabling automated grading and assessment.

## Setup

1. **Model Setup:** Clone the repository.

## Endpoints

- **`/process_image`:** Accepts POST requests with images and returns detected attendance or marks.

## Dependencies

- Flask: Web framework for Python.
- OpenCV: Computer vision library for image processing tasks.
- NumPy: Library for numerical computations.
- BoxDetect: Package for detecting bounding boxes in images.
- Keras: Deep learning library for ML models.
- Matplotlib: Library for creating visualizations.

## Screenshots

<div style="display:flex">
  <img src="/images/image1.jpeg" alt="Screenshot 1" style="width:33%">
  <img src="/images/image2.jpeg" alt="Screenshot 2" style="width:33%">
  <img src="/images/image3.jpeg" alt="Screenshot 3" style="width:33%">
</div>
<div style="display:flex">
  <img src="/images/image4.jpeg" alt="Screenshot 1" style="width:33%">
  <img src="/images/image5.jpeg" alt="Screenshot 2" style="width:33%">
  <img src="/images/image6.jpeg" alt="Screenshot 3" style="width:33%">
</div>
<div style="display:flex">
  <img src="/images/image7.jpeg" alt="Screenshot 1" style="width:33%">
  <img src="/images/image8.jpeg" alt="Screenshot 2" style="width:33%">
  <img src="/images/marksheet.jpeg" alt="Screenshot 3" style="width:33%">
</div>
<div style="display:flex">
  <img src="/images/yuvan1.png" alt="Screenshot 1" style="width:33%">
</div>

## Key Features

### 1. OCR Attendance Detection
Automatically detects and extracts attendance data from images of attendance sheets, providing information on student presence and absence. The OCR model recognizes text, while box detection algorithms identify individual fields on the sheet.

### 2. Mark Detection and Grading
Recognizes marks or scores from images of mark sheets, enabling automated grading and assessment. By processing mark sheets with OCR and box detection, the system extracts numerical data accurately.

### 3. Automated Data Extraction
Provides an automated solution for extracting data from structured documents, reducing manual effort and potential errors. The combination of OCR and box detection streamlines data extraction tasks in educational institutions.

### 4. Scalability and Efficiency
Designed for scalability, the system can handle large volumes of images efficiently. By automating attendance and mark detection, it improves the efficiency of administrative processes in academic settings.

## Applications

### 1. Educational Institutions
Suitable for schools, colleges, and universities, the system automates attendance tracking and grading tasks. It streamlines administrative processes, reduces manual labor, and ensures accurate data management.

### 2. Training Centers and Workshops
Applicable to training centers and workshops, the system facilitates the management of participant attendance and performance assessment. It enables instructors to focus on teaching rather than manual record-keeping.

### 3. Examination Boards
Useful for examination boards and assessment agencies, the system automates the grading process for standardized tests and examinations. It ensures consistency and accuracy in mark calculation and result generation.

### 4. Corporate Training Programs
Adaptable to corporate training programs, the system simplifies attendance tracking and evaluation of employee performance. It provides insights into training effectiveness and participant engagement.

### 5. Research and Development
Valuable for research projects involving document analysis and data extraction, the system offers tools for processing structured documents. Researchers can leverage OCR and box detection capabilities for data analysis tasks.

## Conclusion

The OCR attendance and mark detection system offers a versatile solution for automating data extraction tasks in various educational and organizational contexts. With its ability to recognize text and numerical data from images, it streamlines administrative processes and enhances efficiency.
