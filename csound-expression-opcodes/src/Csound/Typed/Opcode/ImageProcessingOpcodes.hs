module Csound.Typed.Opcode.ImageProcessingOpcodes (
    
    
    
    imagecreate, imagefree, imagegetpixel, imageload, imagesave, imagesetpixel, imagesize) where

import Control.Monad.Trans.Class
import Csound.Dynamic
import Csound.Typed

-- 

-- | 
-- Create an empty image of a given size.
--
-- Create an empty image of a given size. Individual pixel values can then be set with. imagegetpixel.
--
-- > iimagenum  imagecreate  iwidth, iheight
--
-- csound doc: <http://csound.com/docs/manual/imagecreate.html>
imagecreate ::  D -> D -> SE D
imagecreate b1 b2 = fmap ( D . return) $ SE $ (depT =<<) $ lift $ f <$> unD b1 <*> unD b2
    where f a1 a2 = opcs "imagecreate" [(Ir,[Ir,Ir])] [a1,a2]

-- | 
-- Frees memory allocated for a previously loaded or created image.
--
-- >  imagefree  iimagenum
--
-- csound doc: <http://csound.com/docs/manual/imagefree.html>
imagefree ::  D -> SE ()
imagefree b1 = SE $ (depT_ =<<) $ lift $ f <$> unD b1
    where f a1 = opcs "imagefree" [(Xr,[Ir])] [a1]

-- | 
-- Return the RGB pixel values of a previously opened or created image.
--
-- Return the RGB pixel values of a previously opened or created image. An image can be loaded with imageload. An empty image can be created with imagecreate.
--
-- > ared, agreen, ablue  imagegetpixel  iimagenum, ax, ay
-- > kred, kgreen, kblue  imagegetpixel  iimagenum, kx, ky
--
-- csound doc: <http://csound.com/docs/manual/imagegetpixel.html>
imagegetpixel ::  D -> Sig -> Sig -> (Sig,Sig,Sig)
imagegetpixel b1 b2 b3 = pureTuple $ f <$> unD b1 <*> unSig b2 <*> unSig b3
    where f a1 a2 a3 = mopcs "imagegetpixel" ([Kr,Kr,Kr],[Ir,Kr,Kr]) [a1,a2,a3]

-- | 
-- Load an image.
--
-- Load an image and return a reference to it. Individual pixel values can then be accessed with imagegetpixel.
--
-- > iimagenum  imageload  filename
--
-- csound doc: <http://csound.com/docs/manual/imageload.html>
imageload ::  Spec -> SE D
imageload b1 = fmap ( D . return) $ SE $ (depT =<<) $ lift $ f <$> unSpec b1
    where f a1 = opcs "imageload" [(Ir,[Fr])] [a1]

-- | 
-- Save a previously created image.
--
-- Save a previously created image. An empty image can be created with imagecreate and its pixel RGB values can be set with imagesetpixel. The image will be saved in PNG format.
--
-- >  imagesave  iimagenum, filename
--
-- csound doc: <http://csound.com/docs/manual/imagesave.html>
imagesave ::  D -> Spec -> SE ()
imagesave b1 b2 = SE $ (depT_ =<<) $ lift $ f <$> unD b1 <*> unSpec b2
    where f a1 a2 = opcs "imagesave" [(Xr,[Ir,Fr])] [a1,a2]

-- | 
-- Set the RGB value of a pixel inside a previously opened or created image.
--
-- Set the RGB value of a pixel inside a previously opened or created image. An image can be loaded with imageload. An empty image can be created with imagecreate and saved with imagesave.
--
-- >  imagesetpixel  iimagenum, ax, ay, ared, agreen, ablue
-- >  imagesetpixel  iimagenum, kx, ky, kred, kgreen, kblue
--
-- csound doc: <http://csound.com/docs/manual/imagesetpixel.html>
imagesetpixel ::  D -> Sig -> Sig -> Sig -> Sig -> Sig -> SE ()
imagesetpixel b1 b2 b3 b4 b5 b6 = SE $ (depT_ =<<) $ lift $ f <$> unD b1 <*> unSig b2 <*> unSig b3 <*> unSig b4 <*> unSig b5 <*> unSig b6
    where f a1 a2 a3 a4 a5 a6 = opcs "imagesetpixel" [(Xr,[Ir,Ar,Ar,Ar,Ar,Ar])] [a1,a2,a3,a4,a5,a6]

-- | 
-- Return the width and height of a previously opened or created image.
--
-- Return the width and height of a previously opened or created image. An image can be loaded with imageload. An empty image can be created with imagecreate.
--
-- > iwidth, iheight  imagesize  iimagenum
--
-- csound doc: <http://csound.com/docs/manual/imagesize.html>
imagesize ::  D -> (D,D)
imagesize b1 = pureTuple $ f <$> unD b1
    where f a1 = mopcs "imagesize" ([Ir,Ir],[Ir]) [a1]