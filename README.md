# Pose Estimation Play Ground
Will Release some of useful functions in my PhD research in object pose estimation.

1. SICP: Iterative closest point method with scaling parameters.

Citation: 'An extension of the ICP algorithm considering scaling factor', Shaoyi Du, Nanning Zheng, Shihui Ying, Qubo You, Yang Wu.

How to use:

1) Define the param.outer_number and param.inner_number

2) Initialize the S0, based on my experience, [1 0; 0 1] is good to go.

3) 'if_visualization' could be set to either 0 or 1 depnds on whether the user hope to visualize the progress of alignment.

4) Model and data are 2 by N matrix.

5) Current implemented in 2D.
