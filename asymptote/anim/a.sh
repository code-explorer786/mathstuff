# https://arxiv.org/pdf/2310.06860
# will probably make this an actual bash script
asy -u 'w=12;h=12;numcars=40' -f pdf a.asy -o a; gs -sDEVICE=png16m -r600 -o a-%04d.png a.pdf; ffmpeg -r 30 -f image2 -start_number 1 -i a-%04d.png -c:v libx264 -vf "pad=ceil(iw/2)*2:ceil(ih/2)*2" -pix_fmt yuv420p a.mp4 -y; ffmpeg -i a. mp4 a.gif -y
