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
    int n, dim;
    float *h_a, *h_b;

    // pointers for device memory
    float *d_a, *d_b;

    // allocate initialize host memory
    dim = 262144;
    h_a = (float *) malloc(dim*sizeof(float));
    h_b = (float *) malloc(dim*sizeof(float));
    // initialize input data in host
    for (n=0; n<dim; n++)
    {
        h_a[n] = (float) n;
    }

    // allocate device memory
    size_t memSize;
    cudaMalloc(  );
    cudaMalloc(  );

    // host to device memory copy d_a = h_a
    cudaMemcpy(  );

    // device to device memory copy d_b = d_a
    cudaMemcpy(  );

    // device to host copy h_b = d_b
    cudaMemcpy(  );

    // verify the data on the host is correct
    for (n=0; n<dim; n++)
    {
        assert(h_b[n] == h_a[n]);
    }

    // free device memory pointers d_a and d_b

    // free host memory pointers
    free(h_a);
    free(h_b);

    // If the program makes it this far, then the results are correct and
    // there are no run-time errors.  Good work!
    printf("Correct!\n");

    return 0;
}

// nvcc 01_cudaMemcpy.cu - 01_cudaMemcpy
