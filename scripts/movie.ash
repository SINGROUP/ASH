frame remove 1 nframes

while nframes < 50
  create frame*0.2 10.0*sin:(frame*0.1) 0.0
  frame new
endwhile
frame remove

frame first
while frame < nframes
  frame next
  wait 200
endwhile


