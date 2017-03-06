### do we want to use this script as a demo (1 = yes)?
define demo 1

### clear previous frames
frame remove 0 nframes 

### define some measures
define dOH 0.9572              ### O-H bond length
define aHOH 104.52*pi/180      ### H-O-H angle
define dOM 0.15                ### O-dummy length
define dOO 2.8                 ### O-O distance in the final ice lattice
define aTilt asin:(-1/3)       ### tilting angle for molecules in the final lattice

### if in demo mode, print some info on what is done
if demo
view perspective              ### isometric view
resize element O 1.0        ### set the display radius of oxygen
resize element H 0.7        ### set the display radius of hydrogen
view angle -pi/2 pi/2 50    ### set the viewpoint to look along the negative z-direction, x-axis right, y-axis up
show cell                   ### draw also the supercell
print " "
print "We define some parameters, for instance"
print "O-H bond = $dOH$ angstroms"
print "H-O-H angle = $aHOH$ radians"
wait 1000
print " "
print "Next, we create a single water molecule"
wait 1000
endif

### create a (TIP4P) water molecule
create 0 0 0 O                                ### oxygen
###create dOM 0 0 dummy                       ### dummy (TIP4P has a massless center carrying a part of the oxygen charge)

### if in demo mode, print some info on what is done
if demo
print " "
print "Oxygen"
wait 1000
endif

create dOH*cos:(aHOH/2) dOH*sin:(aHOH/2) 0 H  ### hydrogen

### if in demo mode, print some info on what is done
if demo
print " "
print "Hydrogen 1"
wait 1000
endif

create dOH*cos:(aHOH/2) -dOH*sin:(aHOH/2) 0 H ### hydrogen

### if in demo mode, print some info on what is done
if demo
print " "
print "Hydrogen 2"
wait 1000
endif

###list ### uncomment if you wish to see the structure of the molecule
cluster ### join the atoms to a molecule
copy    ### copy the molecule to clipboard

### if in demo mode, print some info on what is done
if demo
print " "
print "In an ice lattice, the molecule will end up in various orientations."
print "We can rotate our model molecule to the required orientations first,"
print "and copy them to memory." 
print "Then we can build our lattice from pre-rotated molecules."
wait 1000
endif

rotate y aTilt                           ### rotate the molecule by the tilt angle
uncluster; shift -coord:0; cluster       ### shift the molecule so that the oxygen is at origin (the rotation was made w.r.t. mass center)

### if in demo mode, print some info on what is done
if demo
print " "
print "Orientation 1"
wait 1000
endif

copy 1                                   ### copy the new orientation to slot 1 on clipboard
rotate z pi                              ### rotate around the z axis
uncluster; shift -coord:0; cluster       ### shift oxygen to origin

### if in demo mode, print some info on what is done
if demo
print " "
print "Orientation 2"
wait 1000
endif

cut 2; paste                             ### copy the new orientation to slot 2 on clipboard, paste the original molecule
rotate x pi/2; rotate y (-pi/2-aTilt)/2  ### rotate the molecule first to xz-plane, then around y
uncluster; shift -coord:0; cluster       ### shift oxygen to origin

### if in demo mode, print some info on what is done
if demo
print " "
print "Orientation 3"
wait 1000
endif

copy 3                                   ### copy to slot 3
rotate z pi                              ### rotate around z
uncluster; shift -coord:0; cluster       ### shift oxygen to origin

### if in demo mode, print some info on what is done
if demo
print " "
print "Orientation 4"
wait 1000
endif

cut 4                                    ### copy to slot 4, an empty geometry is left

### define some oxygen to oxygen bonds that occur in an ice lattice
define bond1 [dOO*cos:(pi/3)*cos:(aTilt),dOO*sin:(pi/3)*cos:(aTilt),dOO*sin:(-aTilt)] 
define bond2 [dOO*cos:(aTilt),0,dOO*sin:(aTilt)]
define bond3 [dOO*cos:(pi/3)*cos:(aTilt),-dOO*sin:(pi/3)*cos:(aTilt),dOO*sin:(-aTilt)]
define bond4 [dOO*cos:(aTilt),0,dOO*sin:(-aTilt)]
define bond5 [0,0,dOO]

### if in demo mode, print some info on what is done
if demo
print " "
print "Before building the lattice, let us set up a supercell."
print "Although the lattice is hexagonal, we build an orthorhombic cell."
show cell
wait 1000
endif

### define the supercell - we will build an orthorhombic cell even though the lattice is hexagonal
define cell_diagonal bond1+bond5+bond1+bond2+bond4+bond5  ### the diagonal of the cell
cell x elem:{cell_diagonal,1,1} true    ### set the 1st cell vector length to 1st component of diagonal, and turn on periodic boundaries
cell y elem:{cell_diagonal,1,2} true    ### 2nd cell vector
cell z elem:{cell_diagonal,1,3} true    ### 3rd cell vector

### if in demo mode, print some info on what is done
if demo
list cell
print " "
print "Now we can build the lattice."
print "We start by constructing our unit cell which takes 8 molecules."
wait 1000
endif


### build the ice lattice - molecules in clipboard slots 1 and 3 form one layer and those in slots 2 and 4 the second
paste 1; unpick all                                        ### paste the molecule from slot 1 at origin, deselect it

### if in demo mode, print some info on what is done
if demo
print " "
print "Molecule 1"
wait 1000
endif

paste 3; shift bond1; unpick all                           ### paste the molecule from slot 3, shift it to proper position, deselect

### if in demo mode, print some info on what is done
if demo
print " "
print "Molecule 2"
wait 1000
endif

paste 1; shift bond1+bond2; unpick all                     ### etc.

### if in demo mode, print some info on what is done
if demo
print " "
print "Molecule 3"
wait 1000
endif

paste 3; shift bond1+bond2+bond3; unpick all

### if in demo mode, print some info on what is done
if demo
print " "
print "Molecule 4"
wait 1000
endif

paste 2; shift bond1+bond5; unpick all

### if in demo mode, print some info on what is done
if demo
print " "
print "Molecule 5"
wait 1000
endif

paste 4; shift bond1+bond5+bond4; unpick all

### if in demo mode, print some info on what is done
if demo
print " "
print "Molecule 6"
wait 1000
endif

paste 2; shift bond1+bond5+bond1+bond2; unpick all

### if in demo mode, print some info on what is done
if demo
print " "
print "Molecule 7"
wait 1000
endif

paste 4; shift bond1+bond5+bond1+bond2+bond4; unpick all

### if in demo mode, print some info on what is done
if demo
print " "
print "Molecule 8"
wait 1000
print "We also shift all the molecules slightly so that none"
print "are on the very border of the cell."
print " "
print "This is how our system looks like now!"
endif

pick all; shift bond1/2+bond4/3                            ### select all 8 molecules in our cell and shift them slightly

### if in demo mode, print some info on what is done
if demo
### do an animation
define ii 0
define angles 500
while ii < angles
  define ii ii+1
  view angle -pi/2+10*ii/angles*pi pi/2-ii/angles*pi/2 50
  wait 20
endwhile
print " "
print "To get a bigger piece of ice, we expand our tiny cell by"
print "multiplying it in the directions of the cell vectors."
wait 1000
endif

### to get a bigger piece of ice, copy the supercell in all directions a few times
expand [4,6,4]

### if in demo mode, print some info on what is done
if demo
print " "
print "Finally, let's shift the view to something nicer."
wait 1000
endif

### set the view to something nicer
view isometric           ### isometric view
resize element O 1.0     ### set the display radius of oxygen
resize element H 0.7     ### set the display radius of hydrogen
view angle -pi/2 0 70    ### set the viewpoint to look along the negative z-direction, x-axis right, y-axis up
show cell                ### draw also the supercell
