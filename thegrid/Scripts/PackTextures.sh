#!/bin/sh

# PackTextures.sh
# bumba
#RGBA4444
# Created by Alain Hufkens on 14/02/11.
# Copyright 2011 Nascom. All rights reserved.

#!/bin/sh

TP="/usr/local/bin/TexturePacker"

if [ "${ACTION}" = "clean" ]
then
    echo "cleaning..."

    rm thegrid/Resources/SpriteSheets/tile-assets.*
    rm thegrid/Resources/SpriteSheets/icon-assets.*

else
    echo "building..."

# Game Art

    ${TP} --smart-update \
          --format cocos2d \
          --data thegrid/Resources/SpriteSheets/tile-assets.plist \
          --sheet thegrid/Resources/SpriteSheets/tile-assets.pvr.ccz \
          --enable-rotation \
          --dither-fs \
          --shape-padding 1 \
          --opt RGBA4444 \
          --trim \
          thegrid/Art/TileAssets/*.png

    ${TP} --smart-update \
          --format cocos2d \
          --data thegrid/Resources/SpriteSheets/icon-assets.plist \
          --sheet thegrid/Resources/SpriteSheets/icon-assets.pvr.ccz \
          --enable-rotation \
          --dither-fs \
          --shape-padding 1 \
          --opt RGBA4444 \
          --trim \
          thegrid/Art/IconAssets/*.png

fi
exit 0

