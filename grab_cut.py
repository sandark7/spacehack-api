import numpy as np
import matplotlib.pyplot as plt
import cv2
import sklearn.preprocessing as scale
import flask as flask

filename = "spec/support/test_image_4.jpg"
img = cv2.imread(filename)

h,w = img.shape[:2]

mask = np.zeros((h,w), dtype='uint8')
rect = (85,44,158,250)
bgdModel = np.zeros((1,65),np.float64)
fgdModel = np.zeros((1,65),np.float64)

cv2.grabCut(img,mask,rect,bgdModel,fgdModel,15,mode=cv2.GC_INIT_WITH_RECT)

# If mask==2 or mask== 1, mask2 get 0, other wise it gets 1 as 'uint8' type.
mask2 = np.where((mask==2)|(mask==0),0,1).astype('uint8')

img_cut = img*mask2[:,:,np.newaxis]

b_channel, g_channel, r_channel = cv2.split(img)

mn = np.min(mask2)
mx = np.max(mask2)
mask3 = np.uint8((mask2 - mn)*255/(mx - mn))

alpha_channel = np.ones(mask3.shape, dtype=mask3.dtype) #creating a dummy alpha channel image.
img_RGBA = cv2.merge((r_channel, g_channel, b_channel, mask3))

plt.imshow(img_RGBA)
plt.show()

