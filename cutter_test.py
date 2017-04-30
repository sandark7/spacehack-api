import matplotlib.pyplot as plt
from cutter import Cutter

grabCut = Cutter("spec/support/test_image_4.jpg", (85, 44, 158, 250))
grabbedImage = grabCut.call()

plt.imshow(grabbedImage)
plt.show()
