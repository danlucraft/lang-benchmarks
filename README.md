Results:

    Daniels-iMac:benchmarks dan$ rake run
    time ./reversi/reversi_crystal_dev
    [1, 4]
    4
            2.60 real         2.59 user         0.00 sys
    time ./reversi/reversi_crystal_release
    [1, 4]
    4
            0.23 real         0.22 user         0.00 sys
    time ruby ./reversi/reversi.rb
    [1, 4]
    4
           10.51 real        10.48 user         0.01 sys
    time ./reversi/reversi_nim_release
    1
    4
    4
            0.06 real         0.06 user         0.00 sys