/*
 *   This work is licensed under the Creative Commons
 *   Attribution-NonCommercial 4.0 International License (CC BY-NC 4.0).
 *   You should have received a copy of the license along with this work.
 *   If not, see: https://creativecommons.org/licenses/by-nc/4.0/
 *
 *   You are free to:
 *     - Share — copy and redistribute the material in any medium or format
 *     - Adapt — remix, transform, and build upon the material
 *   Under the following terms:
 *     - Attribution — You must give appropriate credit, provide a link to the
 *       license, and indicate if changes were made.
 *     - NonCommercial — You may not use the material for commercial purposes.
 *
 */


// includes, system
#include <stdio.h>
#include <assert.h>

///////////////////////////////////////////////////////////////////////////////
// Program main
///////////////////////////////////////////////////////////////////////////////
int main( int argc, char** argv) 
{
    // pointer and dimension for host memory
    int n, dim = 262144;
    float *h_a, *h_b;

    // pointers for device memory
    float *d_a;

    // allocate unified memory for h_a and d_a;
    cudaMallocManaged(  );
    cudaMallocManaged(  );
    
    // initialize input data in host
    for (n=0; n<dim; n++)
    {
        h_a[n] = (float) n;
    }

    // copy data from h_a to d_a using a loop in CPU

    // device to host copy h_b = d_a
    cudaMemcpy(  );

    // verify the data on the host is correct
    for (n=0; n<dim; n++)
    {
        assert(h_b[n] == h_a[n]);
    }

    // free all memory

    // If the program makes it this far, then the results are correct and
    // there are no run-time errors.  Good work!
    printf("Correct!\n");

    return 0;
}

// nvcc 04_unified_memory.cu - 04_unified_memory
