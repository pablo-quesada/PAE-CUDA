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

// Compute kernel
__global__
void warmupKernel()
{
    // do not worry about this kernel
    __syncthreads();
}

///////////////////////////////////////////////////////////////////////////////
// Program main
///////////////////////////////////////////////////////////////////////////////
int main( int argc, char** argv) 
{
    dim3 dimGrid(1, 1, 1);      // dimGrid.x = 1
    dim3 dimBlock(4096, 1, 1);  // dimBlock.x = 4096

    warmupKernel<<<dimGrid, dimBlock>>>();
    // Check for any CUDA errors
    // checkCUDAError("warmupKernel");

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

// nvcc 02_cudaErrorchk.cu -o 02_cudaErrorchk
