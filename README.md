# plain-linpack
HPL Benchmark in a container

### Ryzen 7 2700X

**Image**: qnib/plain-linpack:native_zen.2019-07-24.1

|   N   |  NB | P | Q | #MPI | #OMP | Time | Gflops | Comments |
| 29464 | 232 | 4 | 2 |   8  |   1  |  | 188    | |
| 52000 | 32  | 2 | 4 |   8  |   1  |  | 80    | |
| 28160 | 32  | 2 | 4 |   8  |   2  |  | 77    | |
| 28160 | 64  | 2 | 4 |   8  |   2  |  | 136 | |
| 28160 | 256 | 2 | 4 |   8  |   2  |  | 184 | |
| 28160 | 256 | 4 | 2 |   8  |   2  |  | 180 | |
| 28160 | 512 | 2 | 4 |   8  |   2  |  | 175 | |
| 28032 | 192 | 2 | 4 |   8  |   2  |  | 187 | |
| 29464 | 232 | 2 | 4 |   8  |   2  | 89.11 | 191 | privileged |
| 29464 | 232 | 2 | 4 |   8  |   2  | 92.48 |  184 | |

**Image**: qnib/plain-linpack:znver1_zen.2019-07-24.1
|   N   |  NB | P | Q | #MPI | #OMP | Time | Gflops | Comments |
| 29464 | 232 | 2 | 4 |   8  |   1  | 89.11 | 191 | privileged |

