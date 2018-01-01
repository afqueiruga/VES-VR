VR
==

This is my fork of the Paraview mobile app to support the Google Cardboard VR libary.
The iOS app has an extra button to it switches to rendering the scene in VR. It worked
pretty well. However, the desktop-mobile linking doesn't compile properly in this latest
version of VES, and the library is no longer maintained, so I stopped working on it 
heavily. I haven't looked at the new VTK library because there isn't a new mobile app
yet.

Note: VES is no longer being maintained. Please use VTK as we have added support
for mobile architectures.


Introduction
============
VES is the VTK OpenGL ES Rendering Toolkit. It is a C++ rendering library for
mobile devices using OpenGL ES 2.0. VES integrates with the Visualization
Toolkit (VTK) to deliver scientific and medical visualization capabilities
to mobile application developers.

Licensing
=========
- For VES license please refer LICENSE.txt

- VES uses Eigen and Eigen is LGPL license. Please visit
  http://eigen.tuxfamily.org/index.php?title=Licensing_FAQ for more
  information on Eigen licensing.

- VES uses VTK. VTK is an open-source toolkit licensed under the BSD license.
  Please visit http://www.vtk.org/VTK/project/license.html for more information
  on VTK licensing.

Wiki
====
http://vtk.org/Wiki/VES

Support
=======
ves@public.kitware.com
