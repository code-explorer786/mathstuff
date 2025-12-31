# https://arxiv.org/pdf/2310.06860
# will probably make this an actual bash script
rm -v out/a-*.png
asy -u 'w=15;h=15;numcars=60' -f pdf a.asy -o out/a;
gs -sDEVICE=png16m -r600 -o out/a-%04d.png out/a.pdf;
ffmpeg -r 30 -f image2 -start_number 1 -i out/a-%04d.png -c:v libx264 -vf "pad=ceil(iw/2)*2:ceil(ih/2)*2" -pix_fmt yuv420p out/a.mp4 -y

