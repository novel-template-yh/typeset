#!/bin/sh

for i in pdf aux bbl blg bst fdb_latexmk fls idx ilg ind lof log lol lot ltjruby nav out snm toc xmpi txt
do
  find .typesetting -type f -name "*.$i" | xargs rm -rf
  find body -type f -name "*.$i" | xargs rm -rf
  find cover -type f -name "*.$i" | xargs rm -rf
  find cropmark -type f -name "*.$i" | xargs rm -rf
done

rm -rf *.zip
