import cv2
import pytesseract
import re

def extract_text(image_path):
    images = cv2.imread(image_path)
    gray_scale_image = cv2.cvtColor(images, cv2.COLOR_BGR2GRAY)
    ret, thresh1 = cv2.threshold(gray_scale_image, 0, 255, cv2.THRESH_OTSU | cv2.THRESH_BINARY_INV)
    
    rect_kernel = cv2.getStructuringElement(cv2.MORPH_RECT, (25, 25))
    dilation = cv2.dilate(thresh1, rect_kernel, iterations=1)

    contours, hierarchy = cv2.findContours(dilation, cv2.RETR_EXTERNAL, cv2.CHAIN_APPROX_NONE)
    paragraph = ""
    cnt_list = []
    
    for cnt in contours:
        x, y, w, h = cv2.boundingRect(cnt)
        cropped = gray_scale_image[y:y + h, x:x + w]
        text = pytesseract.image_to_string(cropped)
        cnt_list.append([x, y, text])
        
    sorted_list = sorted(cnt_list, key=lambda x: x[1])

    for item in sorted_list:
        paragraph += item[2] + " "

    cleaned_paragraph = re.sub(r'\s+', ' ', paragraph)
    cleaned_paragraph = re.sub(r'/hpf', '', cleaned_paragraph)
    cleaned_paragraph = re.sub(r'\\n', ' ', cleaned_paragraph)

    return cleaned_paragraph.strip()
