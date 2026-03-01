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
#include <thrust/device_vector.h>
#include <thrust/transform.h>
#include <thrust/functional.h>
#include <iostream>

int main(void)
{
    // pointer and dimension for host memory
    int n, dim = 262144;
    
    // pointers for host memory
    thrust::host_vector<float> h_a(dim);
    thrust::host_vector<float> h_b(dim);
    thrust::host_vector<float> h_c(dim);
    
    // initialize input data in host
    for (n=0; n<dim; n++)
    {
        h_a[n] = (float) n;
        h_b[n] = (float) n;
    }
    
    // allocate and initialize device memory
    thrust::device_vector<float> d_A(dim);
    thrust::device_vector<float> d_B(dim);   
    thrust::device_vector<float> d_C(dim);
    
    // transfer data to the device
    d_A = h_a;
    d_B = h_b;

    // compute vector sum C = A+B
    thrust::transform(d_A.begin(), d_A.end(),
        d_B.begin(),
        d_C.begin(),
        thrust::plus<float>());
       
    
    // transfer data back to host
    h_c = d_C;

    // verify the data on the host is correct
    for (n=0; n<dim; n++)
    {
        assert(h_c[n] == h_a[n] + h_b[n]);
    }

    // free host memory pointers
    // done by Thrust

    // If the program makes it this far, then the results are correct and
    // there are no run-time errors.  Good work!
    printf("Correct!\n");
}

// nvcc 06_thrust_vec_add.cu -o 06_thrust_vec_add
