#!/bin/bash

for CARD in `ls -1 originals/`;
  do convert originals/$CARD -resize 216x300 resized/$CARD;
done
