import numpy as np
import cv2
import sklearn.preprocessing as scale

class Cutter:
  def __init__(self, image_url, rectangle):
    self.image_url = image_url
    self.image = cv2.imread(image_url)
    self.rectangle = rectangle
    self.h, self.w = self.image.shape[:2]
    self.bgdModel = np.zeros((1,65),np.float64)
    self.fgdModel = np.zeros((1,65),np.float64)
  def call(self):
    img = cv2.imread(self.image_url)
    h,w = img.shape[:2]

    mask = np.zeros((h,w), dtype='uint8')
    bgdModel = np.zeros((1,65),np.float64)
    fgdModel = np.zeros((1,65),np.float64)

    cv2.grabCut(img,mask,self.rectangle,bgdModel,fgdModel,10,mode=cv2.GC_INIT_WITH_RECT)

    # If mask==2 or mask== 1, mask2 get 0, other wise it gets 1 as 'uint8' type.
    mask2 = np.where((mask==2)|(mask==0),0,1).astype('uint8')
    # img_cut = img*mask2[:,:,np.newaxis]
    b_channel, g_channel, r_channel = cv2.split(img)

    mn = np.min(mask2)
    mx = np.max(mask2)
    mask3 = np.uint8((mask2 - mn)*255/(mx - mn))

    alpha_channel = np.ones(mask3.shape, dtype=mask3.dtype) #creating a dummy alpha channel image.
    return cv2.merge((r_channel, g_channel, b_channel, mask3))
