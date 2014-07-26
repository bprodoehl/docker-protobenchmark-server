#!/usr/bin/env python

import getopt, math, numpy, sys
from PIL import Image

sizeInKB = 10

def generateImages(num, sizeInKB):
    # a 1x1 pixel is ~633 bytes
    sizeInKB = sizeInKB - 0.618
    if (sizeInKB < 0):
        sizeInKB = 0.0001

    height = math.ceil(math.sqrt(1666.67 * sizeInKB))
    width = math.ceil(math.sqrt(1666.67 * sizeInKB))

    for n in xrange(num):
        a = numpy.random.rand(height,width,3) * 255
        im_out = Image.fromarray(a.astype('uint8')).convert('RGBA')
        filename = 'test_'+str(int(math.ceil(sizeInKB)))+'KB'
        if (num > 1):
            filename = filename + '_' + str(n)
        filename = filename + '.jpg'
        im_out.save(filename)

def main(argv):
   num = 1
   sizeInKB = 100
   try:
      opts, args = getopt.getopt(argv,"hn:s:",["num=","size="])
   except getopt.GetoptError:
      print 'generate-images.py -n <number of images> -s <size in KB>'
      sys.exit(2)
   for opt, arg in opts:
      if opt == '-h':
         print 'generate-images.py -n <number of images> -s <size in KB>'
         sys.exit()
      elif opt in ("-n", "--num"):
         num = int(arg)
      elif opt in ("-s", "--size"):
         sizeInKB = float(arg)
   generateImages(num, sizeInKB)

if __name__ == "__main__":
   main(sys.argv[1:])
