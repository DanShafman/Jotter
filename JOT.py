import cv2
import numpy as np
import sys

def filterNoise(contour):
    
    #eliminate noise
    min_perim = 300
    perim = cv2.arcLength(contour, True)
    print("perim = ", perim)
    if(perim < min_perim):
        return False
    
    return True

def distanceSq(pointA, pointB):
    return np.sqrt(np.power(pointA[0][0] - pointB[0][0], 2) + np.power(pointA[0][1] - pointB[0][1], 2))

def process_image(inputImage):

    original = inputImage

    #resize image
    height, width = original.shape[:2]
    im = cv2.resize(original,(200, 200), interpolation = cv2.INTER_CUBIC)
    
    #grey scale image
    imgray = cv2.cvtColor(im,cv2.COLOR_BGR2GRAY)
    
    #convert to binary image
    ret, thresh = cv2.threshold(imgray, 150, 255,  cv2.THRESH_BINARY_INV)
    
    #find contours
    im2, contours, hierarchy = cv2.findContours(thresh,cv2.RETR_TREE,cv2.CHAIN_APPROX_SIMPLE)
    
    #contains warped image
    dst = np.zeros((100,100), np.uint8)

    for i in range(len(contours)):
    
        if(filterNoise(contours[i])):
            print("first contour point", contours[0][0][0]);
            hull = cv2.convexHull(contours[i])
            perim = cv2.arcLength(hull, True)
        
            #make sure it's quad or triangle or pentagon
            epsilon = 0.05 * perim
            poly = cv2.approxPolyDP(hull, epsilon, True)
            pSides = len(poly)
    
            #make sure shape is quad or triangle
            print("poly sides = ", len(poly))
            if(pSides != 3 and pSides != 4):
                continue
        
            triangle = (pSides == 3)
            quad = (pSides == 4)
#           #find bounding box for shape
#           rect = cv2.minAreaRect(contours[i])
#           box = cv2.boxPoints(rect)
#           box = np.int0(box)
#           cv2.drawContours(imgray,[box], 0, (0,0,255), 2)
#           print("box size = ", len(box), box[0], " ", box[1], " ", box[2], " ", box[3])

            #find shortest side
            d = np.zeros((4), np.float32)
            ratio = np.zeros((4), np.float32)
            lowest = 10000000
            lowestP = 0
        
            #server expects output of 4 ratios, so we include a made up distance for triangles -> d[3]
            #get dis between all 4 points
            d[0] = distanceSq(poly[0], poly[1])
            d[1] = distanceSq(poly[1], poly[2])
            if(triangle):
                d[2] = distanceSq(poly[2], poly[0])
                d[3] = 100000
            else:
                d[2] = distanceSq(poly[2], poly[3])
                d[3] = distanceSq(poly[3], poly[0])
            
            #ratios cancel out scaling
            ratio[0] = d[0] / d[1]
            ratio[1] = d[1] / d[2]
            if(triangle):
                ratio[2] = d[2] / d[1]
                ratio[3] = 100
            else:
                ratio[2] = d[2] / d[3]
                ratio[3] = d[3] / d[0]
            
            for j in range(4):
                print("d[j] = ", ratio[j])
                if(lowest > ratio[j]):
                    lowest = ratio[j]
                    lowestP = j
    
            #store distances in clockwise order starting from shortest side
            output = np.zeros((4), np.float32)
            outputI = 0;
    
            for k in range (lowestP, pSides):
                output[outputI] = ratio[k]
                outputI += 1
            for k in range(0, lowestP):
                output[outputI] = ratio[k]
                outputI += 1
            
            #include random distance for triangle
            if(pSides == 3):
                output[3] = ratio[3]

            print(output)
            sys.stdout.flush()
            return output

input = sys.arg[v]
process_image(input)