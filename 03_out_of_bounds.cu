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
// For the CUDA runtime routines (prefixed with "cuda_")
#include <cuda_runtime.h>

// Simple utility function to check for CUDA runtime errors
void checkCUDAError(const char *msg);

// Each thread initialize one element
__global__
void initializeKernel(float* A, int n)
{
    int i = threadIdx.x + blockDim.x * blockIdx.x;
        A[i] = (float)i;
}

///////////////////////////////////////////////////////////////////////////////
// Program main
///////////////////////////////////////////////////////////////////////////////
int main( int argc, char** argv) 
{
    // pointer and dimension for host and device memory
    int n, dim;
    float *h_a, *d_A;

    // allocate and initialize host memory
    dim = 50000;
    h_a = (float *) malloc(dim*sizeof(float));
    
    cudaMalloc((void **) &d_A, dim*sizeof(float));
    cudaMemcpy(d_A, h_a, dim*sizeof(float), cudaMemcpyHostToDevice);
    
    initializeKernel<<<ceil(dim/256.0), 256>>>(d_A, dim);
    // Check for any CUDA errors
    checkCUDAError("<<<ceil(dim/256.0), 256>>>");
    
    cudaMemcpy(h_a, d_A, dim*sizeof(float), cudaMemcpyDeviceToHost);

    // verify the data on the host is correct
    for (n=0; n<dim; n++)
    {
        assert(h_a[n] == (float)n);
    }

    // free host memory pointers
    free(h_a);
    // free device memory pointers
    cudaFree(d_A);

    // If the program makes it this far, then the results are correct and
    // there are no run-time errors.  Good work!
    printf("Correct!\n");

    return 0;
}

void checkCUDAError(const char *msg)
{
    cudaError_t err = cudaGetLastError();
    if( cudaSuccess != err) 
    {
        fprintf(stderr, "Cuda error: %s: %s in %s at line %d.\n", msg, cudaGetErrorString( err), __FILE__, __LINE__ );
        exit(EXIT_FAILURE);
    }                         
}

// nvcc 03_out_of_bounds.cu -o 03_out_of_bounds
